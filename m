From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: fill_one() doesn't modify textconv
Date: Thu, 04 Apr 2013 19:05:53 +0200
Message-ID: <vpqd2uaql8u.fsf@grenoble-inp.fr>
References: <20130404160557.GB25232@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNncJ-0000Ak-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763588Ab3DDRF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:05:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49897 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763018Ab3DDRF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:05:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r34H5phh008522
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Apr 2013 19:05:51 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UNnbl-0007E5-FE; Thu, 04 Apr 2013 19:05:53 +0200
In-Reply-To: <20130404160557.GB25232@ruderich.org> (Simon Ruderich's message
	of "Thu, 4 Apr 2013 18:05:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Apr 2013 19:05:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r34H5phh008522
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365699952.2513@o9f8g+j9k6IC28a5eN7RAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220037>

Simon Ruderich <simon@ruderich.org> writes:

> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -75,10 +75,10 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
>  }
>  
>  static void fill_one(struct diff_filespec *one,
> -		     mmfile_t *mf, struct userdiff_driver **textconv)
> +		     mmfile_t *mf, struct userdiff_driver *textconv)

Nice, but perhaps you should elaborate a bit more in the commit message
to say this is a cleanup without real change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
