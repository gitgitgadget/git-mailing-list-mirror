From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit
 message
Date: Wed, 6 Jan 2016 09:50:21 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601060949530.2964@virtualbox>
References: <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com> <20151221065944.GA3550@sigill.intra.peff.net> <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1512301535550.14434@virtualbox> <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601011604070.14434@virtualbox> <xmqq60z9p51f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601051342050.14434@virtualbox> <xmqq37ubke8q.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601060916400.2964@virtualbox>
 <20160106082341.GB19117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:51:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGjo6-0004dW-El
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 09:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbcAFIu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 03:50:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:60713 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbcAFIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 03:50:58 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M86jp-1a3abG1Ysz-00vhNI; Wed, 06 Jan 2016 09:50:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160106082341.GB19117@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:O2WcuZf4bCa0/ORu5vQuEli5+/chyGeNBBgHiQJWKc/6Jrscgyw
 b7WxVtb9xlKImGvtXL1ka9KoP1rYt15uRwRkYjp3mCQKXWdW0pMICNDhzQPzY8i1VqNgTVu
 4wIos5zgAC85AUVUup/KoGH8wdKzmc30aCLta9eXLNaTwjcsHq2tdS9FOPJq56wiRuEOkOu
 gNfGuyhaQsj39+qHblhwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:00fbNYRqWOE=:WwC49ItPcd+hJ7Of4YCocl
 F4amVQQqnEr0jz2C4FBIgNq6YkWKrnKCMqZQCNAog8aNiitCl+b34vyT+xrnHvBicabFRHSsx
 qcx6+UXiuy1xfr+V9cKosXPahHJwacRhmEnZdvipzOVImpJvz2wbIWYOvOEmLHXLhzNOEOHqz
 rF7tijiqdS164wQJpwMc4TNp82XvQ4zF6F/w+7aMxuB849RTZgiWdwksHZqFK8xGcaegYHNpN
 SZrSOE4jQL59h+wvpz1G8TrHSqUw9uMaEBI/wFcvfoyO8kQvMpjx9KqmldYEcgFMAZgWcuqx9
 ezRCojUtIy632kyIgtEr0S4SHrBJZT846iGoashQqTESCxr2fOfwxxfS0YavA0+7yMr27GvZ0
 IUHsLIqjBVGHWmMHHv540Eqr2F5RoCdxEufUACiVnnRraEPX/yCNIjc7KkcC6xdHMnNSStz4k
 27byoFz0uEurXuI1DdEtrxFt/P3eDtqhZ5H9IdQkw3aRlLvTcCp8uMveRAqxQdFWEPE06UOHK
 4FiEeSKxd+RQYYH9Sxf65if8zugMOtN3gJ87rA9pj8A5RYq3nr9Wr1BMfvtNM6smfWuy1jIcm
 aArcegpVDu95ao39bmiP+csiPgLdRq/BwrIzOv6ouZB2a/xYiLZFYYnCGvpiKMQNMuJB8HrnU
 OXi/MFmAMTbuEwrpDppJgQ2VLZcYM2nlxhnMmcaPB79tU77jlCwQGlwdM9YcoA4PkjF9sQ+iN
 OvQBWONpUDI+2E+mzGwM07kmAQD7g23k7zUKPRqdLIK743JfRpk4qVvngiwtInVRcp4nNgw4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283423>

Hi Peff,

On Wed, 6 Jan 2016, Jeff King wrote:

> I think fopen_for_writing() is fine, or fopen_truncate().

I like fopen_for_writing() better than fopen_truncate() because it states
the intention more clearly.

Thanks!
Dscho
