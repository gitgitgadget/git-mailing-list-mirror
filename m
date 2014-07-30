From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] git_config callers rewritten with the new config cache API
Date: Wed, 30 Jul 2014 15:46:30 +0200
Message-ID: <vpq1tt3rmbt.fsf@anie.imag.fr>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:46:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCUDP-0005uO-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbaG3Nqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:46:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43155 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbaG3Nqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:46:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UDkSEu009384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2014 15:46:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6UDkUcv013754;
	Wed, 30 Jul 2014 15:46:30 +0200
In-Reply-To: <1406727549-22334-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 30 Jul 2014 06:39:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 Jul 2014 15:46:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6UDkSEu009384
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407332790.854@cicOGkeN9PmrHMCMSq43AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254494>

Tanay Abhra <tanayabh@gmail.com> writes:

> [PATCH v4]: Tiny style nits corrected. Patch 2/5 has been totally reworked.
> 	One thing to check is if the config variables I changed in the series
> 	are single valued or multi valued. Though I have tried to ascertain
> 	if the variable was single valued or not by reading the docs and code,
> 	mistakes may creep in.
>
> [PATCH v3]: Most of Eric's suggestions has been implemented. See [2] for discussion.
> 	Also, new helpers introduced in v7 of the config-set API series have been used.
>
> This series builds on the top of 4c715ebb in pu (ta/config-set).

I think it semantically needs your other WIP series, that makes
git_config_get_* die in case of error. Otherwise, there's an unexpected
behavior change in case of error.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
