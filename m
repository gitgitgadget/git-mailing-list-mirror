From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Thu, 25 Feb 2016 10:26:18 +0100
Message-ID: <vpqk2lt5ef9.fsf@anie.imag.fr>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 10:26:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYsBw-0007pW-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759380AbcBYJ0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 04:26:32 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37067 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbcBYJ0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 04:26:30 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P9QHnr021887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 10:26:17 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P9QILh012016;
	Thu, 25 Feb 2016 10:26:18 +0100
In-Reply-To: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Thu, 25 Feb 2016 09:42:22
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 10:26:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P9QHnr021887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456997182.7722@clTAZaTUC8r2nnOv04/DFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287356>

larsxschneider@gmail.com writes:

> --- a/Makefile
> +++ b/Makefile
> @@ -380,6 +380,18 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
>
> +ifdef DEVELOPER
> +	CFLAGS +=	-Werror \
> +				-Wdeclaration-after-statement \
> +				-Wno-format-zero-length \
> +				-Wold-style-definition \
> +				-Woverflow \
> +				-Wpointer-arith \
> +				-Wstrict-prototypes \
> +				-Wunused \
> +				-Wvla
> +endif
> +

I guess you have tab-width=4. This portion looks ugly with tab-width=8.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
