From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc 8.2.5
Date: Wed, 30 May 2012 11:02:12 +0200
Message-ID: <vpqipfeujmz.fsf@bauges.imag.fr>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
	<87ehq3mbxg.fsf@thomas.inf.ethz.ch>
	<CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
	<20120529215613.GB17598@sigill.intra.peff.net>
	<CACBZZX6a2BQVhe8-X5o+WnfbsrqPKa_Cn93GZ1bbq1TLezB97Q@mail.gmail.com>
	<20120530085111.GA9917@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 30 11:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZenv-0003l3-5N
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 11:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab2E3JCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 05:02:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42935 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932272Ab2E3JCr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 05:02:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4U8roF6008823
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 10:53:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZenF-0007mP-5A; Wed, 30 May 2012 11:02:13 +0200
In-Reply-To: <20120530085111.GA9917@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 30 May 2012 04:51:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 May 2012 10:53:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4U8roF6008823
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338972835.3458@c6BDjD/k9przTmDMRw7Tow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198786>

Jeff King <peff@peff.net> writes:

> If we are going to go the route of providing an asciidoc for people
> whose asciidoc is buggy, we might as well go all out and provide a
> complete standalone asciidoc (or at least some subset) for those who
> don't have it at all.

Perhaps a "make install-asciidoc" target that does the
wget && make && make DESTDIR=contrib/ install
(or whatever asciidoc needs to be installed)?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
