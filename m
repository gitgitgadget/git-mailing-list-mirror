From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 00/11] git_config callers rewritten with the new config-set API
Date: Mon, 04 Aug 2014 22:42:28 +0200
Message-ID: <vpq38dc9ebv.fsf@anie.imag.fr>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:42:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEP5a-0004RP-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbaHDUmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:42:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53178 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbaHDUme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:42:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74KgQFw018377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 22:42:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74KgSm5006230;
	Mon, 4 Aug 2014 22:42:28 +0200
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 4 Aug 2014 11:33:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 22:42:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74KgQFw018377
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407789746.91848@dHE6ZbhYSrldsIObeRLnhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254780>

Tanay Abhra <tanayabh@gmail.com> writes:

> This series is the first batch of patches which rewrites the existing callers
> using a non-callback approach.
> This series aims to,
>
> * rewrite the existing callers, as you can see from the diff stat the bew API
>   provides a much concise and clear control flow.
>
> * stress test the new API, see if any corner cases or deficiencies arise or not.

I went through the series. I agree with Eric that there's a slight
behavior change in http-backend.c, and I don't think it's a good thing.

Other than that, the series look good to me, although I would probably
need a second look to double check.

Tanay: I suggest you keep this as one 11-patches series. If you rewrite
more callsites, I'd find it easier to review as a second, independant
series rather than an ever-growing single series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
