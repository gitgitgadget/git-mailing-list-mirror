From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 'Comma in -to/-cc entry' on valid addresses
Date: Thu, 17 Dec 2015 07:50:09 +0100
Message-ID: <vpq7fkdfu1q.fsf@anie.imag.fr>
References: <CALCETrWY+n-m_P-0ub4ZPn5yGrr52C8F+wAtJok-cCQmM12d5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 07:50:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9SOO-0005kU-KW
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 07:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbbLQGuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 01:50:17 -0500
Received: from mx1.imag.fr ([129.88.30.5]:50050 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbbLQGuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 01:50:16 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tBH6o9q6018343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 17 Dec 2015 07:50:09 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tBH6o9ee030536;
	Thu, 17 Dec 2015 07:50:09 +0100
In-Reply-To: <CALCETrWY+n-m_P-0ub4ZPn5yGrr52C8F+wAtJok-cCQmM12d5Q@mail.gmail.com>
	(Andy Lutomirski's message of "Wed, 16 Dec 2015 16:43:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Dec 2015 07:50:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tBH6o9q6018343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1450939812.92251@QUK76FVEEm8uG9ARV6QB4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282633>

Andy Lutomirski <luto@amacapital.net> writes:

> $ git send-email --to='"Address, Valid" <somebody@foobarbaz.com>'
> Comma in --to entry: "Address, Valid" <somebody@foobarbaz.com>'
> $ git --version
> git version 2.5.0
>
> This appears to be a recent regression.

It's not: the check was introduced in 79ee555 (Check and document the
options to prevent mistakes., 2006-06-21).

The check was _removed_ in Git 2.6.0, which happily accepts your
command. IOW, the bug is already fixed :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
