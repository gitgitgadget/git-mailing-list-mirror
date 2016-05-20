From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] upload-pack.c: use of parse-options API
Date: Fri, 20 May 2016 08:53:10 +0200 (CEST)
Message-ID: <1446970271.10941827.1463727190993.JavaMail.zimbra@imag.fr>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr> <431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr> <xmqq60uakmr4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 08:53:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3eJI-0005ww-FA
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 08:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbcETGxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 02:53:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50308 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbcETGxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 02:53:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4K6rAsj023884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 20 May 2016 08:53:11 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4K6rB5e014162;
	Fri, 20 May 2016 08:53:11 +0200
In-Reply-To: <xmqq60uakmr4.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use of parse-options API
Thread-Index: VKNAMA4eBCk6VsOwnmvBklvq7mbB6w==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 20 May 2016 08:53:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4K6rAsj023884
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1464331993.36163@+Rw34lbmucPGmENnx3C7fQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295149>

Junio C Hamano wrote:
> Encouraging use of "send-email" with "--patience" is a losing
> approach if your goal is to present more reviewable diff, isn't it?
> Using "send-email" as if it is a front-end of "format-patch" means
> you lose the opportunity for the final proof-reading (not just
> finding typoes in the message, but the shape of diff, like you are
> pointing out).
> 
> Using "format-patch --patience" or some other diff option, and pick
> the best one to give to "send-email" would indeed be a way to do so.

It's a matter of taste. My flow is "send-email-only", I do as much as
possible in-tree, and when I notice something to do during "git send-email",
I just abort and retry. So "Oops, looks ugly, I'll try with another
option" is OK in this flow.

> What is happening is that Antoine's patch (which is slightly
> different from what you quoted above) has trailing whitespace after
> "setup_path();"

Nice catch!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
