From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] status: introduce status.short to enable --short by default
Date: Mon, 10 Jun 2013 16:43:36 +0200
Message-ID: <vpqli6igh5z.fsf@anie.imag.fr>
References: <1370875226-31392-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 16:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3Jz-0001jH-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab3FJOno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:43:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60098 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab3FJOnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:43:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEhYSU032226
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:43:35 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um3Jo-0002aa-FD; Mon, 10 Jun 2013 16:43:36 +0200
In-Reply-To: <1370875226-31392-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge Juan Garcia Garcia's message of "Mon, 10 Jun 2013 16:40:25
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 16:43:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227296>

Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
writes:

> +test_expect_success '"Setup of environment of test"' '

Why these double quotes inside single quotes?

> +test_expect_success '"Back to environment of test by default"' '

Same.

"test environment" would sound better than "environment of test" in
english.

> +	git config status.showUntrackedFiles yes

"yes" is not documented as an acceptable value for
status.showUntrackedFiles.

"git config --unset" is what you want here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
