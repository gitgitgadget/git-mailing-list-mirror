From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase interactive: Add hint how to continue after 'Unknown command' error
Date: Sun, 06 Jan 2008 12:14:53 -0800
Message-ID: <7vtzlq4soy.fsf@gitster.siamese.dyndns.org>
References: <1199634385511-git-send-email-prohaska@zib.de>
	<5F80ADF7-A68A-4DF3-8453-92B76BC927EF@wincent.com>
	<20080106195044.GA24169@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBbuI-0001Nr-7s
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 21:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYAFUPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2008 15:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYAFUPO
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 15:15:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYAFUPN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2008 15:15:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 584729EB8;
	Sun,  6 Jan 2008 15:15:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 986AB9DE7;
	Sun,  6 Jan 2008 15:15:00 -0500 (EST)
In-Reply-To: <20080106195044.GA24169@old.davidb.org> (David Brown's message of
	"Sun, 6 Jan 2008 11:50:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69742>

David Brown <git@davidb.org> writes:

> On Sun, Jan 06, 2008 at 06:33:32PM +0100, Wincent Colaiuta wrote:
>>El 6/1/2008, a las 16:46, Steffen Prohaska escribi=C3=B3:
>>
>>> @@ -310,7 +310,7 @@ do_next () {
>>> 		;;
>>> 	*)
>>> 		warn "Unknown command: $command $sha1 $rest"
>>> -		die_with_patch $sha1 "Please fix this in the file $TODO."
>>> +		die_with_patch $sha1 "Please fix this in the file
>>> $TODO. And run  'git rebase --continue'."
>>
>>Grammar nit: sentences can't start with "And", so that should really =
be:
>
> Not true:
> <http://www.accu-assist.com/grammar-tips-archive/11-07-06_GrammarTip_=
and-but-conjunctions.htm>
>
> Although, in this case, I would agree that it should just be one sent=
ence
> with a comma.  It's more of a stylistic construct, more common in fic=
tion
> than technical documentation.

I've always wondered why this part can't just re-launch the
editor with the $TODO file, have the instruction to "fix" in the
file for the user to see (together with the original "#
commented out" instructions), and do the --continue itself.
