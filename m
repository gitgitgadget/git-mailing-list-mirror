From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 084/144] t6111-rev-list-treesame.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 09:52:45 +0100
Message-ID: <vpqob0u3bj6.fsf@anie.imag.fr>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
	<1395735989-3396-85-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 09:53:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSN6U-0003ov-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbaCYIww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 04:52:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32961 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbaCYIwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:52:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8qivq032519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2014 09:52:44 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2P8qjHW022976;
	Tue, 25 Mar 2014 09:52:45 +0100
In-Reply-To: <1395735989-3396-85-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 25 Mar 2014 01:25:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 25 Mar 2014 09:52:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2P8qivq032519
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396342365.80811@cRlUD/IEM4O/H7PR8gXkwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245017>

Elia Pinto <gitter.spiros@gmail.com> writes:

> --- a/t/t6111-rev-list-treesame.sh
> +++ b/t/t6111-rev-list-treesame.sh
> @@ -4,7 +4,7 @@
>  #       /        \ /             \*
>  # *A--*B---D--*F-*G---------K-*L-*M
>  #   \     /*       \       /
> -#    `-C-'          `-*I-*J
> +#    $(-C-'          )-*I-*J

The original version was more readable ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
