From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] merge-recursive.c: replace `git_config()` with `git_config_get_int()`
Date: Wed, 13 Aug 2014 13:34:35 +0200
Message-ID: <vpq7g2cvd10.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<1407918122-29973-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 13:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWpR-0001A6-2S
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 13:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbaHMLem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 07:34:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58214 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbaHMLel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 07:34:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7DBYYhS024983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 13:34:34 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DBYZNV023635;
	Wed, 13 Aug 2014 13:34:35 +0200
In-Reply-To: <1407918122-29973-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 13 Aug 2014 01:22:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Aug 2014 13:34:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DBYYhS024983
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408534478.21531@uNcLq5Ypcvr+P2t0bUhc+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255203>

Tanay Abhra <tanayabh@gmail.com> writes:

>  merge-recursive.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)

>  builtin/apply.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

These two look straightforward and good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
