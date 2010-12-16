From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Fix typo in git-gc document.
Date: Thu, 16 Dec 2010 09:38:10 +0100
Message-ID: <vpqei9i15al.fsf@bauges.imag.fr>
References: <4D09BCE1.9030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 09:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT9M7-0008RV-Gf
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 09:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0LPIi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 03:38:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52362 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab0LPIi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 03:38:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oBG8cAPL013903
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 16 Dec 2010 09:38:10 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PT9Lm-0003Gc-Qm; Thu, 16 Dec 2010 09:38:10 +0100
In-Reply-To: <4D09BCE1.9030209@gmail.com> (Jiang Xin's message of "Thu\, 16 Dec 2010 15\:16\:49 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Dec 2010 09:38:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oBG8cAPL013903
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1293093494.49325@SX+IDCIBrRY6LvOVQ0pQmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163805>

Jiang Xin <worldhello.net@gmail.com> writes:

> The variable gc.packrefs for git-gc can be set to true, false and
> "notbare", not "nobare".

Right, gc.c says:

	if (!strcmp(var, "gc.packrefs")) {
		if (value && !strcmp(value, "notbare"))

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
