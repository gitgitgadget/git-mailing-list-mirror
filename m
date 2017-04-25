Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF229207EB
	for <e@80x24.org>; Tue, 25 Apr 2017 22:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1432646AbdDYWFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:05:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:62856 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1430964AbdDYWFI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:05:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mb8MV-1ciRKs1jhr-00KkTm; Wed, 26
 Apr 2017 00:05:05 +0200
Date:   Wed, 26 Apr 2017 00:05:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] sequencer: require trailing NL in footers
In-Reply-To: <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704260003570.3480@virtualbox>
References: <20170421220155.GA142345@google.com> <20170425190651.8910-1-jonathantanmy@google.com> <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com> <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
 <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5AugRpdRWTu8eehcx9hjuQNswbtI63yZyDhtilLuCAFKJcP+3LW
 iBrpcuEuPArA82AAm7LCqgou/Aq8IMjJ7C4TOdteBfvihAyzdZGERq3w25JlRQvN2p8IKez
 mT+V+g5AwVgqcKof6mc5wE2SF9exaQZyxq2Me4TAaTPSnGtDMEADo4J9BynX04Z3AVwxVbr
 FtWGf4usdkk5wi+K1eliQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/b0lWDv/5zk=:2XaqEB8w1ljZPhM0nPs54S
 Lv4Yu0VCmTS88p2eQqz2llorwcSxZ2b4qEVu/d7rbdntSs57u3pARR+Qb5nJHuqVZaMSumtmZ
 J5OxoqtUeJxq8ShWzims0LQruD7o99QaARqaSHFQfWgsccitgdsGA/Mn/cLUoc2nLhFXamF6M
 5OHSgWXBJLlP2UvqGFwNVYpTS8V3tECZ9qbYP7zHqgPTrdIWJwiiEQxUz1vLbhBXdKVj6Ud6a
 9Rhm+hp/hm3P1S2VFIjExpFVB/IipUFGwkN/UrPMUGJ0R03+PPzjcfZYiZGMelIQfh500LwcR
 YjtdpFoCYhgeHfB/JJ9hY9sD473iyEZpbK711ictOYuEepKQ4MjPYxqj/vKeNFFKW5/tqDpXz
 OOzxrxXNjuEaZ4i3NXj+rRm0wJlFJtxgW7i+wLvO2791+607YBgaR3RMG9AwFBuQ0OPQnO5C2
 PwWKmfZXsqKNMQpOPKrJggxhkp53eVfGxvZDEZ9P6VdwSAjADZEjbHEEQe8hfI59XjIdeTTN9
 SZLY93XWe3q+QgaF8MScCnfYZ6QxgENe9HV8B6uEHZQ/xXDkuS3RKZCiUICs5fDKuB8Tz9JIx
 OZ05WdIjpCCXtWbyL9fHxJt16g4K84lXxJPcqWAH7yN9itA3E1Z2fgq6aVKmmcyVXAyXK8P9J
 KwFsm8LXlA6e8LosCl5khe41qanrktS75PMFKy/4Dr5BGM23+dT3qS/Y0Wt+mPRhQE6si5VgJ
 oVatbllcbfUepP0wwP25xvddIjCWtWskMyV+VF7zIUAVzZ1C0kkhVpNXQC536tbVLy+z9mtzZ
 3EhELKP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 25 Apr 2017, Stefan Beller wrote:

> On Tue, Apr 25, 2017 at 2:51 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > On 04/25/2017 02:04 PM, Stefan Beller wrote:
> >>
> >> Thanks for the fix. :)
> >> Do we want to test for this use case in the future?
> >
> >
> > Thanks!
> >
> > I'm not sure of the value of including a test for this specific use case,
> > because Git normally does not create commit messages with no trailing
> > newlines. (To test this, I suspect I would need to use hash-object with a
> > specifically crafted commit object.)
> 
> Okay, makes sense to omit a test.
> In that case: Is it needed to hint at how this bug occurred in the wild?
> (A different Git implementation, which may be fixed now?)

Just because Git usually does not create commit messages without trailing
newlines does not mean that it is a rare thing. We got bug reports about
this, so I think it is frequent enough that we could save time by adding
that test and avoid future bug reports/bug hunts.

Ciao,
Johannes
