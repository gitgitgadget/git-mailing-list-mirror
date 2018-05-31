Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07E71F51C
	for <e@80x24.org>; Thu, 31 May 2018 11:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754837AbeEaLtf (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 07:49:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:55411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754586AbeEaLtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 07:49:31 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxPNC-1gPOB23YAU-016zbi; Thu, 31
 May 2018 13:49:18 +0200
Date:   Thu, 31 May 2018 13:49:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: ensure labels that are object IDs are
 rewritten
In-Reply-To: <20180530222011.GC671367@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1805311347380.82@tvgsbejvaqbjf.bet>
References: <20180529163236.646275-1-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.1805301144470.82@tvgsbejvaqbjf.bet> <20180530222011.GC671367@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:URR9TE/HDgaeA7vK2IRNLK4HG40o82xiKzBZrveVyA8MdmKAazi
 E/AcZnEHKycb7KWKlF1CAqJeKR58uges1XkB7lLfIyC+EphqqBIntMPZUahUzT+4tk6+qC+
 Q68CNhyFHAjnSLJbtJCQ7xzwKq2H1j49lAKMN9cId9wb6L6zfgbrLLF6A8Rx3LI5RMIUcOq
 y9BsYRka+R2Uk6i7qFM+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7Y3hg0+JhtM=:H3B/ROraI9zaNfTjDbQ+mp
 GF9s4H27tvwJ/3Uz859TBr99AFNgrvG7kV9zkt35/W1+yLUzVHYLhwBmcFEwzu7LhZM6oqHL4
 +lTcSgyGnU6qrKQrnOZIBj4wGro+ueNkLYZ7VMYdc1f4aJTUzQDfJWgowm+CnZPNKbsUU8NXQ
 s2BhoMZumXk3p3T6CCpZlk1/PtOcj0LJS2Pv5jxzyxA3RrB09Zb/CQnjPYBwFtlcEDEmUv+Rf
 AJjylCVU+JS4lGAVQKm4whOj1GGCxjTskpz6mSVNVIYcBEBdPsy82Jc+BhRJyPudBt2UrNqTr
 ulYNm8TnjTSxTBD8aaTqWUn0vIY7p591YKhOWqi2SMNhEUwPiIz9I3Ke4vOVA15w2WFMIBTyd
 y5zjioI0ndr4F/83gXjdhU5HMqLFDvB3cX0pLyOaJ9KLtZEyo+80VaNUKWspYfazNgjymvIF4
 6WyqAN5Ssz3FKCc6+i+niDRdyneNXm0rRFZ3HTXQn1hfvp6809Fh+OanYJNfIbslemTBw90h+
 VGjdFHBfKHDW9wbaphOHi3kwpr+YKUjV4Pr9bNb91NXm36WDCc2AFDhrZlnyu824VfLTETqqx
 EUDg6KRy7t7JgXmyLFkxqGYRTyL0gDtU/tIX+dvlvE1HenUQ2QH8fW+QJKxq9TNH+H7it+Oah
 MiBsJC+nyxPHpmUDLnsCfowcokEpYI0yrKIXC6u3QfR4Dm5/cxlZNkijKGJ1jpPMyvlME1fda
 2aYsRAvGsc1QVnhTwRbDqQhZEZwlwq9hXTPP/ggvJPgJ5jz9M+a5FD+/6u9XTiUbu80o7ZeEw
 6FTUP3+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Wed, 30 May 2018, brian m. carlson wrote:

> On Wed, May 30, 2018 at 11:54:27AM +0200, Johannes Schindelin wrote:
> 
> > > +	third=$(git rev-parse HEAD) &&
> > > +	git checkout -b labels master &&
> > > +	git merge --no-commit third &&
> > > +	test_tick &&
> > > +	git commit -m "Merge commit '\''$third'\'' into labels" &&
> > 
> > Here, the test_tick is required because we commit via `git commit`.
> > 
> > BTW another thing that I had been meaning to address but totally forgot is
> > this '\'' ugliness. I had been meaning to define SQ="'" before all test
> > cases and then use $SQ everywhere. Not your problem, though.
> > 
> > > +	cp script-from-scratch-orig script-from-scratch &&
> > 
> > There is nothing in that script that you need. Why not simply
> > 
> > 	echo noop >script-from-scratch
> > 
> > or if you care about the branch,
> > 
> > 	echo reset $third >script-from-scratch
> 
> That would be simpler.  You read my mind: I needed some script to make
> the sequence editor work, but anything would be fine.

I would not go that far. Sometimes I wish I could read minds. More often,
I am glad that I cannot. I simply guessed correctly in this case ;-)

But yes, I think it would not only be simpler, but would also avoid the
head-scratching why the earlier `cp script-from-scratch
script-from-scratch-orig`, and it would also make it more robust to future
changes (e.g. if somebody decides to move test cases around, or introduce
prereqs that skip some).

Ciao,
Dscho
