From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 11:42:59 -0800
Message-ID: <7vprv8mu2k.fsf@gitster.siamese.dyndns.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
	<CFB8A272-863C-4758-91F7-E9669D70A200@zib.de>
	<20080207123108.GA12009@bit.office.eurotux.com>
	<alpine.LSU.1.00.0802071255110.8543@racer.site>
	<20080207130715.GA14000@bit.office.eurotux.com>
	<alpine.LSU.1.00.0802071324460.8543@racer.site>
	<7v1w7ooes3.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802071831520.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:43:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNCf6-0005ws-5a
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbYBGTnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYBGTnV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 14:43:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYBGTnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 14:43:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2183D34;
	Thu,  7 Feb 2008 14:43:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 311B33D2D;
	Thu,  7 Feb 2008 14:43:11 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802071831520.8543@racer.site> (Johannes
	Schindelin's message of "Thu, 7 Feb 2008 18:40:28 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72993>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - even if it would be not necessary to accept the license (which I am not 
>   at all sure about, but do not care enough to learn about it, either), I 
>   am not amused by somebody I do not know of, and who did not share 
>   anything with me that I know of, asking me to remove that license 
>   dialog.

I think you need to grow a thicker skin.

It does not matter if the person is somebody you know or you
have shared with.  I'd grant you that Luciano could have been
more diplomatic when he started his message, but I'd agree that
it is silly to refuse to install an end user program unless the
end user agrees to GPL that governs how its sources can and
cannot be used, especially if the installer does not even
install the sources to the software.

In other words, consider his message as a bug report to the
installer.

I think removing the license dialog is a bad idea.  You need to
tell the end-user about his rights, and one of the things is
that he can get source to git under the terms of GPLv2.  The bug
is not about showing the license, but is about refusing to
install unless the end user agrees with it.

>   If you are not okay with accepting a tit-for-tat license, well... I'll 
>   not give you "tat".

The tit-for-tat in GPLv2 which we use is about "I gave you my
source.  If you are going to work on my source and distribute
the result, you must promise me that I have the access to that
modified source of yours.  Otherwise you cannot work on it and
distribute the result."

Showing the GPL (which says it does not cover the mere use of
the software) and then asking if the user accepts is merely
about:

	"If and only if you are going to modify and distribute
	it, you must abide by the rules.  Do you understand?"

The valid answers to the question would include "I understand",
"I do understand it, I do not like it, but I am not going to
modify and distribute it anyway", and even "I do not understand
it, but I just want to use it".  In any case, refusing to
install unless the user says "I agree" feels silly.

If I were writing the installer, I would say in the dialog, "git
is distributed under GPL so you have the usual rights any GPLed
software comes with", optionally show the GPL, and have a single
"Continue" button.
