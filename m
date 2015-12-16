From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv3] Makefile: add missing phony target
Date: Wed, 16 Dec 2015 09:25:01 +0100
Message-ID: <vpq1tamls0y.fsf@anie.imag.fr>
References: <1450192860-60337-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 09:25:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a97Os-0001yl-2S
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 09:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbbLPIZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 03:25:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34142 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbbLPIZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 03:25:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tBG8P0BJ021230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 16 Dec 2015 09:25:00 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tBG8P1nT009711;
	Wed, 16 Dec 2015 09:25:01 +0100
In-Reply-To: <1450192860-60337-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 15 Dec 2015 15:21:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Dec 2015 09:25:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tBG8P0BJ021230
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1450859103.22579@a/lNKyUSgh1c29M5H6JJZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282545>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Add some missing phony target to Makefile.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---
> This is the third version of this patch.

Thanks. I double-checked with

grep .PHONY Makefile | sed 's/.PHONY: //; s/#.*//' | tr ' ' '\n' | sort | uniq -c | sort -n

there are no duplicate .PHONY, and all .PHONY targets are indeed .PHONY
ones, so the patch is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

> Compared to the previous I have added only the missing phony 
> target as suggested by Matthieu Moy

Note: my comments were not meant to be an objection to the additional
refactoring. At least some of the hunks definitely made sense to me, but
they are better done in a separate patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
