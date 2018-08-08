Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723D21F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeHHVN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:13:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:38675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbeHHVN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:13:28 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTSKd-1fNO5o3dSR-00SL1A; Wed, 08
 Aug 2018 20:52:24 +0200
Date:   Wed, 8 Aug 2018 20:52:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>, alban.gruin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] builtin rebase: support `git rebase <upstream>
 <switch-to>`
In-Reply-To: <CACsJy8BDLvGhRvNQgSgvkR-RMAvVxPpT=i9ayi=awQYOqd2Crg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808082049180.71@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-12-predatoramigo@gmail.com> <CACsJy8BDLvGhRvNQgSgvkR-RMAvVxPpT=i9ayi=awQYOqd2Crg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:S9qspFJFRJDbSqvQuvHHiYba3HnAerBH39e0iP8THEu1tviNuTS
 Hln9g2P5LKrwgbsN/2JAf5ebnO2gcsUW6sEvkuSnTbWfvVgsl58OhPA7meZ3GD//eZmVQVS
 nXkZNg8iJXLg/EME7ROWemU3h8CcGmeNZm/EU8VXjkszm5jKytN+59ifdVmxMgRYM0yrNbh
 dDL6Jg+XUXDbNEY2NxTsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xt+AgxqhZRQ=:ZZ0qOp8mtG7Zgphyqvx8fs
 XqMuZ65IolQYhCyaH3w2GJ94/Na1LLSX3iNl+ebOaqSHB0uVokfnYov8P/zaS7rJt6ZaX2r4W
 TJKHFo9mrg9JnEjKBoeIcbLiIb0esC49kBcjtLdm2UqHDgv8wZPULfcxJpPMaZaG6lp09vPHm
 3AcxorNeE22/Jz2Mg0tCw4RNGI0D2KH/mK21ZXoga6P5eL9MYm/UpkTWzoDZsYcT9ql2fUW4W
 vjkBHzIey8PYuODaIhgJ308eTxET1xRWZ6MqYlqHVrpkyjT0k0HAzop7+TGXV2bDlgcUKt+5Q
 XKIF7WbsY51PSQvucnpokhrYhk61uUbp45fdszIPiMPRzceVFBU89d4n2aCnVjgn0YNeEf+L0
 leHlePWMevb1k75DYaxJ0K8Y+vdPV0kLrST9gS86WQDt1poxtpSFsYgyZhTavaLQyHdVjGZCD
 HtRsEuV+3uGXb0CfNB/Tg3NMU8SPtYqqrPatp+OoC17/qv3hIrl/gACc1/lU1II9kvQSi5OGJ
 Y7d2yr9A6KDPoUz7Waudl4G7dx5KFFS6tV+BtnXZPyEi0z+K7o/Vcra3rFwJJy5wa3i0jkYRW
 eF+CzRPW9utLd2CwGicUTckXo502yjMD6Lt2EZzDqvMxtHr+v04oc+E7+MVmL5Ze1RQn916a8
 7Z3780CdPsHowapxadq7h6s2U6YlxtBcl2u6pTUQ/zqis1BGamU/gqWP+m/SfVz0LzIbL8OiM
 58Byton2ReZr6YYOFYPhTpt/cc8CipcDpc3+1VMqA++SlBMFKrCbd728HfvOvwfB+2EgDI3Z3
 pdrvWFR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Wed, 8 Aug 2018, Duy Nguyen wrote:

> On Wed, Aug 8, 2018 at 3:55 PM Pratik Karki <predatoramigo@gmail.com> wrote:
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 63634210c0..b2ddfa8dbf 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -585,7 +602,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                 }
> >                 if (get_oid("HEAD", &options.orig_head))
> >                         die(_("Could not resolve HEAD to a revision"));
> > -       }
> > +       } else
> > +               BUG("unexpected number of arguments left to parse");
> 
> Does this mean "git base one two three" triggers this BUG? If so, this
> should be a die() instead. I did not real the full source code, so
> maybe this case is already caught higher up.

As you can see from

	https://github.com/git/git/blob/v2.18.0/git-rebase.sh#L615

the original, Unix shell script version of `git rebase` also says "BUG"
here. And if you care to look at

	https://github.com/git/git/blob/3358abdcb/builtin/rebase.c#L870-L872

you will see that there is a proper check for the correct amount of
command-line parameters.

So at this point, it would indeed indicate a bug if the `argc` had an
unexpected value.

Ciao,
Dscho
