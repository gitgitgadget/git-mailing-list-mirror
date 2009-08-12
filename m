From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
 required
Date: Tue, 11 Aug 2009 19:48:12 -0700
Message-ID: <7vy6ppbvdf.fsf@alter.siamese.dyndns.org>
References: <1249995838.1589.3.camel@localhost.localdomain>
 <20090811144253.GA12956@vidovic>
 <1250002681.2707.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:48:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3t6-00051v-7u
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbZHLCsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755663AbZHLCsT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:48:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbZHLCsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:48:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD2FB2681A;
	Tue, 11 Aug 2009 22:48:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 782E126819; Tue, 11 Aug 2009
 22:48:13 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96D53BCA-86EA-11DE-982B-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125646>

Paul Bolle <pebolle@tiscali.nl> writes:

>> Shoudn't be 
>> 
>>    [-m <msg>] <remote> [<remote>...]
>
> No, since "<remote>..." means one or more instances of the "<remote>"
> option.  

Does it really?

After you brought up this "one or more", I re-read the docs your patches
touched, thinking that the author might have meant 'zero or more of A'
with these '<A>...'  notation.

And I realized that they made perfect sense.

In general, you can write:

	<command> ...

and read this as "The <command> can be followed by nothing or something
(zero or more) of unspecified kind".  If <command> takes only one type of
zero or more things, you can _clarify the ellipses_ by prefixing them with
what kind of "stuff" you are talking about:

	<command> <remote>...

and read this as "The <command> can be followed by nothing or something
(zero or more) of <remote>s".

On the other hand, you can also say (note that the ellipses stand on their
own and are not associated with <remote>):

	<command> <remote> ...

and read this as "It takes one <remote> followed by nothing or something
(zero or more) of unspecified kind".
