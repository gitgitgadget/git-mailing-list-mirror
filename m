From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 15:45:37 +0200
Message-ID: <vpqty7wok5a.fsf@bauges.imag.fr>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
	<1317073309.5579.9.camel@centaur.lab.cmartin.tk>
	<e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
	<4E81F080.7010905@drmicha.warpmail.net>
	<CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
	<7v39fhyk21.fsf@alter.siamese.dyndns.org>
	<4E823359.7080602@nextest.com>
	<DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
	<20110927214213.GC5176@sigill.intra.peff.net>
	<CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
	<20110927233549.GA10434@sigill.intra.peff.net>
	<7vpqiltsky.fsf@alter.siamese.dyndns.org>
	<CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 15:46:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uSv-0008Jf-1K
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 15:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1I1NqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 09:46:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41464 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab1I1NqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 09:46:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8SDhZfO020963
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 15:43:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8uSA-0000cu-37; Wed, 28 Sep 2011 15:45:38 +0200
In-Reply-To: <CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
	(Michael Witten's message of "Wed, 28 Sep 2011 13:40:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Sep 2011 15:43:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SDhZfO020963
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317822218.33198@xyKuWRI2EXOrTMfCr4joJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182313>

Michael Witten <mfwitten@gmail.com> writes:

> Well, I think Jeff already proferred a solution. We could have:
>
>   git commit --no-parent
[...]

Appart from the safety objections, is the "root commit" senario common
enough to deserve appearing in the user-interface for both "commit" and
"checkout"?

I think "git commit -h" is scary enough as it is ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
