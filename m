From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 03/10] Add colors to interactive git-clean
Date: Sun, 12 May 2013 19:15:11 +0200
Message-ID: <vpqfvxsi0gw.fsf@grenoble-inp.fr>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
	<6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
	<cover.1368011946.git.worldhello.net@gmail.com>
	<d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 19:15:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZrn-0007bS-Hl
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 19:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab3ELRPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 13:15:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44649 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab3ELRPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 13:15:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4CHF9Pn009203
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 May 2013 19:15:09 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UbZrb-0007ab-SW; Sun, 12 May 2013 19:15:11 +0200
In-Reply-To: <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 19:38:48 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 12 May 2013 19:15:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4CHF9Pn009203
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368983710.33718@Gth5zUDkBgpaax6vBfhomg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224056>

Jiang Xin <worldhello.net@gmail.com> writes:

>  * color.interactive.<slot>: Use customized color for interactive
>    git-clean output (like git add --interactive). <slot> may be
>    prompt, header, help or error.

This should go to the documentation (a short summary is welcome in the
commit messages in addition, but users won't read this...)

> +	if (!prefixcmp(var, "color.interactive.")) {
> +		int slot = parse_clean_color_slot(var, 18);

For readability and maintainability: please use
strlen("color.interactive."), not 18.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
