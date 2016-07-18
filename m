Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230A91FEAA
	for <e@80x24.org>; Mon, 18 Jul 2016 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbcGRHMw (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 03:12:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:59099 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbcGRHMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 03:12:50 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LiDnn-1b3mjl0GIN-00nUCM; Mon, 18 Jul 2016 09:12:30
 +0200
Date:	Mon, 18 Jul 2016 09:12:29 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Herczeg Zsolt <zsolt94@gmail.com>
cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <1468804249.2037.0@smtp.gmail.com>
Message-ID: <alpine.DEB.2.20.1607180905320.28832@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JUrCKYaqYSmQVbqTLF8vhjGsaxeLjN8T9QvPtLqaAhw8ObNbKba
 PoRQtlEGwbC2VEZNyHBP6GQjRzyCwGSY0F6nI3WXt++aWnsYEXZtyW7w5w/oWeLMo0YW5kc
 iaGGx/HZnrar54jnAEILgOYvJKoZ8Lvai/6vacuBWDHZGHjqIAPGxmt0/LEIYrsN1OD6ptz
 ruBzWzMRXeh/GTgsegVTg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:A09A4NVdqCU=:nInWhmqLBKCuejOsDTooLp
 dp2EALDvziywvJ+fdPXG2OYmtUCCWOB1gq/6WRkiEN+Rg1D746BH77jCuuuVX6PcreJfzA2uD
 H5fj+rFNv6dHNucvnnQfjvk5nCripIxGuRnVS4Q7BO2Sf9I2T9pmnsyKoP2pNznq+ZnbOtLO/
 cxRO1qH3V+BL1Yu90QU6RDveU2J3HCehQu0ZcM8e4IPCNPUfHY2NN7UFReLdwS+Jfs1YinbYq
 VKaFVaLt42Q+J8GuRgK1F7qtvG200CXNPX/AypWTUwjOyV4zYiC6NsGRdH1+ARqceUlW9QreK
 XfrYCW/Y/P29TJd8iSMgF8E3Nzq8E74XmE7z+8oML53ISDIEZNA8Rk+3bwEK/AqZGTRm7TtBk
 YWs1D6lAVrF0ML+3hteVuqvhv9JWos2eCmH3LmwH7+obg/irB8IpeS0EI/m1xlGcodBMTUT4B
 mrPEveDnvEUPUQQENnlG6GWfzVB+9Gt58hiPXWSVCkEzOHtraGMJbaepGm8NkV2RE1OXNCf8L
 Wb39IXukPTJNUHSvagqoN8DIYMClwa8NqXg69n/6BTn1kLJdyaf88IaRXETjmRuM015nCQRcj
 8O+R2CAD3VDOrgyo9dgrplXuKQQ3nrRzaIhKLBrc99ah03D+ank6kwNVvAQfWnXJ3J9wFRcwW
 80tLVYyOeeGu0gitg2L81rN0J1tc6wYfTUMLeF8yN+Ja8eiwyJlklun5zhB0fvXAUoS7id9B1
 ZMABewg9szUgP/GY7/MLBZmRinSSK6rxIXOm8kZFppmKdzyvNClpZ5uEli2OdwtokOyfiQTA8
 TWOHRYJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Zsolt,

On Mon, 18 Jul 2016, Herczeg Zsolt wrote:

> I think converting is a much better option. Use a single-hash storage, and
> convert everything to that on import/clone/pull.

That ignores two very important issues that I already had mentioned:

- existing references, both in-repository, e.g. in commit messages
  referring to earlier commits, as well as out-of-repository, e.g.
  referring to commits in mails, blog posts, etc

- GPG-signed commits

Those issues cannot just be hand-waved away.

The "convert everything" strategy also ignores the problem of interacting
with servers and collaborators. Think of hosting repositories,
rediscovering forgotten work trees, and of the "D" in DSCM.

Ciao,
Johannes
