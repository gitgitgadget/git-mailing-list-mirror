From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Mon, 23 May 2016 19:57:43 +0200
Message-ID: <vpq8tz0hd2g.fsf@anie.imag.fr>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160518181500.GD5796@sigill.intra.peff.net>
	<b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, gitster@pobox.com,
	stefan@sevenbyte.org, jrnieder@gmail.com, rybak.a.v@gmail.com
To: Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 23 19:58:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4u7R-0006Ix-G7
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 19:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbcEWR6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 13:58:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59682 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbcEWR6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 13:58:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4NHvf8b012799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 23 May 2016 19:57:41 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4NHvhbw025413;
	Mon, 23 May 2016 19:57:43 +0200
In-Reply-To: <b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
	(Samuel GROOT's message of "Mon, 23 May 2016 18:00:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 23 May 2016 19:57:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4NHvf8b012799
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464631065.35004@DnP6n7o8MDGtp0A/9aM4+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295341>

Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr> writes:

> Since 2.8.3 was out recently, we could flip MAN_BOLD_LITERAL on by
> default for this cycle to shake out problems as Jeff King suggested
> [2].

2.8.3 was a bufix release, and flipping a controversial flag should
clearly not be done on a bugfix release. So, in this context, "beginning
of a cycle" means after a x.y.0 release.

Anyway, a patch enabling MAN_BOLD_LITERAL by default would need to cook
in pu and next as any other patches, so the time when the patch is sent
does not really matter.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
