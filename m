Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CB71F404
	for <e@80x24.org>; Fri, 20 Apr 2018 20:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeDTUwr (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 16:52:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:51013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbeDTUwp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 16:52:45 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M04uG-1eHoXt2fPg-00uMXr; Fri, 20
 Apr 2018 22:52:41 +0200
Date:   Fri, 20 Apr 2018 22:52:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit
 messages
In-Reply-To: <CAPig+cRO2+NJ0-DiuHXA=mWjPnivqH3PiwM9R6OGj2Rr3eLauA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804202250070.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de> <CAPig+cSb33EG2nATjCem4-2dp87SKOXm_SCWU=fCXJCBRZzgeg@mail.gmail.com>
 <CAPig+cRO2+NJ0-DiuHXA=mWjPnivqH3PiwM9R6OGj2Rr3eLauA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hOgJuPkqQxlEsnFky3n4O6hQHTDMjDMJ+6LNzL9E06IRZrSUKaj
 v9u0ancr9nkPptoSD3YJMaUsw1LeBac047UIhVeirt1dV5pPfZ21jmQ+jLLe6GFXlSrxmbX
 VhOAxHVNNOv2v0TWiFjqBTA0co26YJ8J7PVmqp1kNvl60qIlTWnSKQEgl2vYZwCUIMaL3cQ
 OAxu60kY6Q3mZHdMCzYew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xxwM7GKk7TM=:3VonHwonJpDuyU8XTit2L9
 OZaCG9/CY8NKBiN3UeEcsiga2GTjrqvxoPc/Xj078pwdOqLNzcb8z1U+9doE9Mwj6RoKFxh57
 t1AeDCEqezfyCPI3YpwfW0azpdrNNRUCfJxwEiVpr3u87+rQYS3pe2Oz0mHMBDmyaPG/LmxUG
 Ww1Um7Tu7kLfD5icOz0Pbr+24h3Qrb2ckpq/TzJ+eYcQjkpV76DzN8Cf1+wtHPUSVWkoiygWB
 lUrKEAWpT8+Lgb/j2SphC3hb1NAMbmd7lKXUQYOP28OUNxpnjPTaRa/kYUFeNO/6HQjf0JRgg
 1XWPIEcmWuyJvmSkT6ODP1CA45vLCRCAYCMHFuWfgVWbSgIag7FIIZQCEDZMh9ABmU77Bmy6O
 bqVVp68t95+KWu+BH0WN0jTCCFZ+MlYYxUQ4OsXUUGBibKZVtkUvzipzowHjMGLecEpn8typ0
 qkGHfYuLU7RhSyvo76nPZU9YWx2KTF571SbBax4fh94/NWzZ+bndcl3vYb3QZwbUglVyI8bRm
 GW8sCG3UaeDKqCMJ+cADwaqPE+if5x0jV4Bg+fM+b8RxE2ZHXybsNfYDIuWMTjUJmmNlfrX8S
 iqWBqsXzccygbZjiQh0cP9O1aI1Qf6AIUL09H7k4Hz0zup5OFvbPzAEuxPAFrcrn5vPfGfYaG
 X4UBjA9WFz4xWwOso5ed4dC2ryTQ96t6fwlre4LtOmynojcNjJmTIdnYzd05U+rOTy+DoQSrk
 CAj8SMtXTbJmo8zOob7JGWP40nc3XaIatT35cRDCaJOTzrpSQXKIEDNTAPCIgE+M1uRBsW/Bs
 oy2wQhzNQlLj+/ET0AUFYsF1l7c0Fy3ykJxnTpGlAgFuAUTd8c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 20 Apr 2018, Eric Sunshine wrote:

> On Fri, Apr 20, 2018 at 3:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Apr 20, 2018 at 8:17 AM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> >> +       test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
> >> +               git rebase -i HEAD~4 &&
> >> +
> >> +       : now there is a conflict, and comments in the commit message &&
> >> +       git show HEAD >out &&
> >> +       grep "This is a combination of" out &&
> >> +
> >> +       : skip and continue &&
> >> +       git rebase --skip &&
> >
> > I see that this test script doesn't utilize it, but do you want a
> >
> >     test_when_finished "reset_rebase" &&
> >
> > before starting the rebase to clean up in case something before "git
> > rebase --skip" fails?

No, because then one of the next test cases fails:

	not ok 15 - rebase -i --continue remembers --rerere-autoupdate

;-)

I'll use

	test_when_finished "test_might_fail git rebase --abort"

instead, okay? ;-)

Ciao,
Dscho
