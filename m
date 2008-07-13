From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
 completion
Date: Sun, 13 Jul 2008 16:25:35 -0700
Message-ID: <7vhcatnz80.fsf@gitster.siamese.dyndns.org>
References: <20080713111847.29801.8969.stgit@localhost>
 <7vskudpiqq.fsf@gitster.siamese.dyndns.org>
 <20080713230724.GJ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 14 01:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIAxr-0005AM-FD
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 01:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYGMXZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 19:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYGMXZn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 19:25:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbYGMXZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 19:25:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E78142A03F;
	Sun, 13 Jul 2008 19:25:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 92C9B2A03E; Sun, 13 Jul 2008 19:25:37 -0400 (EDT)
In-Reply-To: <20080713230724.GJ10151@machine.or.cz> (Petr Baudis's message of
 "Mon, 14 Jul 2008 01:07:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 028FA81C-5133-11DD-960B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88356>

Petr Baudis <pasky@suse.cz> writes:

> On Sun, Jul 13, 2008 at 02:38:37PM -0700, Junio C Hamano wrote:
>> By the way, the above command line is another "dot" related frustration I
>> always have.  If you try:
>> 
>> 	git log v1.5.6.<TAB>
>> 
>> the completion code adds a dot unconditionally when I want to choose from
>> the list of v1.5.6.X tags.  Of course, I can work this around by dropping
>> the last dot before asking for completion, so it is not really a very big
>> deal, but I mention it here because this annoyance is exactly in the same
>> league as your "git-submodule.<TAB>" example.
>
> Actually, my original solution to this problem was simply to remove the
> . -> .. completion altogether. Maybe this would still be the best course
> of action? I don't think the . -> .. is actually very useful for anyone,
> since you might as well just hit the dot another time instead of a tab.

I think that is what Shawn sent a few minutes ago, so you two are in
agreement, and I will be happy with it, too.
