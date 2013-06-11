From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/2] status:introduce status.branch to enable --branch by default
Date: Tue, 11 Jun 2013 15:43:15 +0200
Message-ID: <vpqwqq03gr0.fsf@anie.imag.fr>
References: <1370957645-17905-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<1370957645-17905-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 11 15:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmOr6-0007JN-ML
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 15:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3FKNnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 09:43:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36078 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab3FKNnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 09:43:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BDhEO6021127
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 15:43:14 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmOqy-0002QV-2Q; Tue, 11 Jun 2013 15:43:16 +0200
In-Reply-To: <1370957645-17905-2-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	(Jorge-Juan Garcia-Garcia's message of "Tue, 11 Jun 2013 15:34:05
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 15:43:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227441>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr writes:

> +test_expect_success '"status.branch=true" different from "--no-branch"' '
> +	git -c status.branch=true status -s >actual &&
> +	git status -s --no-branch  >expected_nobranch &&

Two nitpicks:

There are two spaces before >, there should be one.

If the first "git" command fails, then you fail to create
expected_nobranch and the other tests fail too. Creating
expected_nobranch before actual would solve this. You have the same
issue in PATCH 1/2.

With or without these fixed,

Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

(both patches)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
