From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/2] status: introduce status.short to enable --short by default
Date: Mon, 10 Jun 2013 20:29:14 +0200
Message-ID: <vpq1u89ddl1.fsf@anie.imag.fr>
References: <1370878068-7643-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
	<7vr4g9j0gh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, git@vger.kernel.org,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6qP-0000KW-R4
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab3FJS3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:29:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37361 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3FJS3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:29:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AITCGh009176
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 20:29:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um6qA-00070e-SD; Mon, 10 Jun 2013 20:29:14 +0200
In-Reply-To: <7vr4g9j0gh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 10 Jun 2013 11:16:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 20:29:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227343>

Junio C Hamano <gitster@pobox.com> writes:

> 	test_expect_success '-c status.short=true == status -s' '
>         	test_config status.showUntrackedFile no &&

That's an option, but having status.showUntrackedFile set in a separate
setup test makes the actual tests shorter. The setup test has no reason
to fail, so I find it OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
