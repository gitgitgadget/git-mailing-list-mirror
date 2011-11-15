From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] revert: prettify fatal messages
Date: Tue, 15 Nov 2011 11:04:35 +0100
Message-ID: <vpqlirhitvw.fsf@bauges.imag.fr>
References: <1321349492-5653-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 11:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQFso-0004xg-F4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 11:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab1KOKEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 05:04:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52278 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754625Ab1KOKEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 05:04:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pAFA09fL032213
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2011 11:00:09 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RQFsa-0005ZX-6k; Tue, 15 Nov 2011 11:04:36 +0100
In-Reply-To: <1321349492-5653-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 15 Nov 2011 15:01:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Nov 2011 11:00:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pAFA09fL032213
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1321956012.49435@7LedX/3J5MBuoQSoJgo5nA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185451>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Some of the fatal messages printed by revert and cherry-pick look ugly
> like the following:
>
>   fatal: Could not open .git/sequencer/todo.: No such file or directory
>
> The culprit here is the die_errno() function that takes a custom error
> message string as an argument and appends ": <message from errno>"
> before printing it.  So, we can fix the problem by not terminating the
> string argument to the function with a '.' (period).  Fatal messages
> look nicer now:
>
>   fatal: Could not open .git/sequencer/todo: No such file or directory

Sounds (obviously) good.

(I just misread the subject line at first, and understood that this was
a revert of an earlier commit, while this is actually a commit touching
the "revert" part of Git)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
