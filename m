From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9r1 2/2] test-config: add tests for the config_set API
Date: Wed, 16 Jul 2014 13:49:38 +0200
Message-ID: <vpqvbqxjzfx.fsf@anie.imag.fr>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C665A0.2060705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 13:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Nie-0003ox-12
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 13:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759506AbaGPLtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 07:49:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35565 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759364AbaGPLtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 07:49:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6GBnbjn015505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 13:49:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GBncPd022668;
	Wed, 16 Jul 2014 13:49:38 +0200
In-Reply-To: <53C665A0.2060705@gmail.com> (Tanay Abhra's message of "Wed, 16
	Jul 2014 17:14:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Jul 2014 13:49:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GBnbjn015505
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406116179.30146@wtdAEgpN0JkkdHvfoLoqLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253666>

Tanay Abhra <tanayabh@gmail.com> writes:

> +# 'check_config get_* section.key value' verifies that the entry for
> +# section.key is 'value'
> +check_config () {
> +	if test "$1" = expect_code
> +	then
> +		expect_code="$2" && shift && shift
> +	else
> +		expect_code=0
> +	fi &&
> +	op=$1 key=$2 && shift && shift
> +	if test $# != 0

Broken &&-chain after shift.

(No time for more review right now, but I'll have time in ~3h from now)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
