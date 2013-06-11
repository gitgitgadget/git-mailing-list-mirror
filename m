From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/2] rm: introduce advice.rmHints to shorten messages
Date: Tue, 11 Jun 2013 18:35:01 +0200
Message-ID: <vpq38so38sq.fsf@anie.imag.fr>
References: <1370962561-12519-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<1370962561-12519-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 18:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmRXT-00006I-D5
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 18:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab3FKQfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 12:35:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41143 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab3FKQfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 12:35:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BGYxjn030184
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 18:35:00 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UmRXB-0006jT-NH; Tue, 11 Jun 2013 18:35:01 +0200
In-Reply-To: <1370962561-12519-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Tue, 11 Jun 2013 16:56:01
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 18:35:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227461>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr> writes:

> Introduce advice.rmHints to choose whether to display advice or not
> when git rm fails. Defaults to true, in order to preserve current behavior.

I went through the serie, and it seems OK to me.

I like the way this patch 2/2 became an obvious 4-lines patch (+ tests)
after 1/2 is refactored properly :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
