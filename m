From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Wed, 23 Jul 2014 21:38:53 +0200
Message-ID: <vpqwqb3vp9u.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:39:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2NR-0008LG-Oz
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025AbaGWTi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:38:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60514 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387AbaGWTi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:38:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJcoi8003274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2014 21:38:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NJcrln026178;
	Wed, 23 Jul 2014 21:38:53 +0200
In-Reply-To: <1406140978-9472-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Jul 2014 21:38:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6NJcoi8003274
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406749131.48924@h+y4RZ6uhGTQjO6KTmazJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254114>

Tanay Abhra <tanayabh@gmail.com> writes:

> This series builds on the top of 5def4132 (ta/config-set) in pu or
> topic[1]

Not exactly: 5def4132 has been replaced in pu, and it does not contain
tests, hence PATCH 3 does not apply on top of 5def4132. The series
applies to 0912a24, but does not compile, since you use strintern which
is in master but not in 0912a24.

OK, applied and compiled. Let the review begin.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
