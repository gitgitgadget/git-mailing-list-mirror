From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1 4/4] hashmap: add string interning API
Date: Thu, 03 Jul 2014 09:22:41 +0200
Message-ID: <vpqpphmc3em.fsf@anie.imag.fr>
References: <53B48540.5070600@gmail.com> <53B4863E.1020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2bM5-0004Rz-U0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 09:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbaGCHWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 03:22:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51676 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292AbaGCHWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 03:22:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s637Mfr7030248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jul 2014 09:22:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s637Mfdo011281;
	Thu, 3 Jul 2014 09:22:41 +0200
In-Reply-To: <53B4863E.1020701@gmail.com> (Karsten Blees's message of "Thu, 03
	Jul 2014 00:22:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Jul 2014 09:22:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s637Mfr7030248
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404976965.1776@muf31Gky/v/p+gLpBp+VHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252856>

Karsten Blees <karsten.blees@gmail.com> writes:

> --- a/t/t0011-hashmap.sh
> +++ b/t/t0011-hashmap.sh
> @@ -237,4 +237,17 @@ test_expect_success 'grow / shrink' '
>  
>  '
>  
> +test_expect_success 'string interning' '
> +
> +test_hashmap "intern value1
> +intern Value1
> +intern value2
> +intern value2
> +" "value1
> +Value1
> +value2
> +value2"
> +
> +'

Indentation is broken here, but it's consistant with the current style
of the file. You may want a "modernize style" patch before yours and
then indent properly, but that shouldn't block inclusion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
