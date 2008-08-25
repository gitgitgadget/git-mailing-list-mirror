From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Mon, 25 Aug 2008 12:48:09 -0700
Message-ID: <7vzln0g9l2.fsf@gitster.siamese.dyndns.org>
References: <200808221501.54908.jnareb@gmail.com>
 <200808250444.23305.jnareb@gmail.com>
 <7vvdxpivig.fsf@gitster.siamese.dyndns.org>
 <200808252042.29171.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXi4F-0006jl-GI
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 21:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022AbYHYTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 15:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYHYTsa
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 15:48:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbYHYTs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 15:48:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5942E6721E;
	Mon, 25 Aug 2008 15:48:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 209D867215; Mon, 25 Aug 2008 15:48:12 -0400 (EDT)
In-Reply-To: <200808252042.29171.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 25 Aug 2008 20:42:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C7EA8150-72DE-11DD-AC3B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93662>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 25 Aug 2008, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > +                     $markers .= " <span class=\"$class\" title=\"$ref\">" .
>> > +                             $cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"),
>> > +                                                    hash=>"refs/$ref")}, $name) .
>> > +                             "</span>";
>> >
>> > or equivalent (not stripping "refs/" in git_get_references).
>> 
>> If you mean by "hash => $it", I think it is only used as the URL the
>> anchor points at, and it is much more preferable to use the canonical
>> form.  "...?h=refs/heads/master" and "...h=heads/master" might produce the
>> same output, but then it is better for smart caching layer if you always
>> used canonical form, isn't it?
>
> Will you do the change, or do you need resend from Giuseppe?
>
> I like the feature that this patch introduces, and this time I don't
> have any reservations to the code. So, FWIW, Ack from me.

I could do it, but my preference is for somebody I trust to resend with
appropriate Ack lines so that I can just run "git am" on the message
without editing.
