From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH] Rewrite the diff-no-index.c
Date: Mon, 17 Mar 2014 11:43:10 +0100 (CET)
Message-ID: <282721457.578099.1395052990145.JavaMail.zimbra@imag.fr>
References: <1394973858-16505-1-git-send-email-ubuntu2012@126.com> <CAPig+cRjGonML5NLyv3eqsKuM45O+whVCOQKNdj-E=zW9mRy4g@mail.gmail.com> <57a096bd.145a2.144cf9c12d4.Coremail.ubuntu2012@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?5rKI5om/5oGp?= <ubuntu2012@126.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 11:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPV14-00032R-76
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 11:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbaCQKna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 06:43:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35006 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471AbaCQKn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 06:43:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2HAhFWO014446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2014 11:43:15 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2HAhGnk027373;
	Mon, 17 Mar 2014 11:43:16 +0100
In-Reply-To: <57a096bd.145a2.144cf9c12d4.Coremail.ubuntu2012@126.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF27 (Linux)/8.0.6_GA_5922)
Thread-Topic: Rewrite the diff-no-index.c
Thread-Index: uUOTwbNh4mEU/uGJ4UMNe/A+hyRtlQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Mar 2014 11:43:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2HAhFWO014446
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1395657796.1231@8EzbDdKAwoiUB/RgjDiLTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244242>

----- Original Message -----
> Thank you for your comments.If I rename some function when I work on a large
> project like git,whether it will cause other error that I can not solve .So
> I use the ugly way for this reason.

(please, don't top-post on this list).

The read_directory to be renamed is a static function, called twice. I don't see any reason not to rename it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
