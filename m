From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 2/3] t4150-am: refactor am -3 tests
Date: Mon, 08 Jun 2015 13:36:11 +0200
Message-ID: <vpqwpzectzo.fsf@anie.imag.fr>
References: <1433460284-20240-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433460284-20240-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vLr-0004Zj-GY
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbbFHLgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:36:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58136 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbbFHLgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 07:36:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58BaAN4027621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 13:36:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58BaBc1001615;
	Mon, 8 Jun 2015 13:36:11 +0200
In-Reply-To: <1433460284-20240-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Fri, 5 Jun 2015 01:24:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 13:36:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58BaAN4027621
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434368173.25184@36Ih0kQT7N9wIooO1fRnjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271011>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> +test_expect_success 'setup am -3' '
> +	rm -fr .git/rebase-apply &&

I don't think you need this 'rm -fr' since you're going to repeat it at
the beginning of individual tests. But it doesn't harm to keep it just
in case.

With or without this 'rm -fr', the series looks good to me. Thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
