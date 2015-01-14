From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] standardize usage info string format
Date: Wed, 14 Jan 2015 13:40:14 +0100
Message-ID: <vpqy4p5bknl.fsf@anie.imag.fr>
References: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBNFK-0005TU-8i
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbANMkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:40:22 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36303 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbANMkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:40:21 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t0ECeCFj028040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Jan 2015 13:40:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t0ECeEaN012848;
	Wed, 14 Jan 2015 13:40:14 +0100
In-Reply-To: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Tue, 13 Jan 2015 00:44:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Jan 2015 13:40:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t0ECeCFj028040
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1421844014.0044@Ea4w1u+0Yw47DvG6wCTFYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262382>

Alex Henrie <alexhenrie24@gmail.com> writes:

> This patch puts the usage info strings that were not already in docopt-
> like format into docopt-like format, which will be a litle easier for
> end users and a lot easier for translators. Changes include:
>
> - Placing angle brackets around fill-in-the-blank parameters
> - Putting dashes in multiword parameter names
> - Adding spaces to [-f|--foobar] to make [-f | --foobar]
> - Replacing <foobar>* with [<foobar>...]

I had a closer look and found it all good.

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
