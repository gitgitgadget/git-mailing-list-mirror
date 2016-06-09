From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Use "working tree" instead of "working directory" for git status
Date: Thu, 09 Jun 2016 21:46:35 +0200
Message-ID: <vpqporqb0x0.fsf@anie.imag.fr>
References: <1465496370-11664-1-git-send-email-Lars.Vogel@vogella.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Vogel <Lars.Vogel@vogella.com>
To: Lars Vogel <lars.vogel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:46:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB5ut-0006tx-6D
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbcFITqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:46:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49302 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcFITqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:46:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u59JkXbf026892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 21:46:33 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u59JkZoc012077;
	Thu, 9 Jun 2016 21:46:35 +0200
In-Reply-To: <1465496370-11664-1-git-send-email-Lars.Vogel@vogella.com> (Lars
	Vogel's message of "Thu, 9 Jun 2016 20:19:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 09 Jun 2016 21:46:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u59JkXbf026892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466106395.74372@jE/WcbT01lf3Dh3rlbex0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296920>

Lars Vogel <lars.vogel@gmail.com> writes:

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1554,7 +1554,7 @@ void wt_status_print(struct wt_status *s)
>  			else
>  				printf(_("nothing to commit\n"));
>  		} else
> -			printf(_("nothing to commit, working directory clean\n"));
> +			printf(_("nothing to commit, working tree clean\n"));

Looks good to me, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
