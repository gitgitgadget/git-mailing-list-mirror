From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Small "git clean" annoyance
Date: Fri, 01 Apr 2011 09:41:48 +0200
Message-ID: <vpq62qymn9f.fsf@bauges.imag.fr>
References: <AANLkTinQscpkRDftLmCrQR+Aq5RacGyurd3kb15y=1FK@mail.gmail.com>
	<AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 09:44:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Z1d-0006Tb-1f
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 09:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab1DAHnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 03:43:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33500 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755055Ab1DAHnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 03:43:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p317fmfP032188
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Apr 2011 09:41:48 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q5YzN-0007aQ-3Q; Fri, 01 Apr 2011 09:41:49 +0200
In-Reply-To: <AANLkTikksQj3HfOJmi-uZTfc7sTNNuDA4bFVaj2cY3Ad@mail.gmail.com>
	(Alex Riesen's message of "Fri, 1 Apr 2011 09:34:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Apr 2011 09:41:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p317fmfP032188
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1302248512.72968@9eSxErNCiV/qqWzKPT0WNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170557>

Alex Riesen <raa.lkml@gmail.com> writes:

> -	if (!dir)
> +	if (!dir) {
> +		if (rmdir(path->buf) == 0)
> +			return 0;
>  		return -1;
> +	}

Sounds good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
