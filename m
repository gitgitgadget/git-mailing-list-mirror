Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08911F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbcHAJN6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:13:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:59698 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbcHAJNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:13:54 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LpcBS-1ap1Ye15y2-00fTSC; Mon, 01 Aug 2016 11:12:06
 +0200
Date:	Mon, 1 Aug 2016 11:12:04 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Stephen Morton <stephen.c.morton@gmail.com>
cc:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
In-Reply-To: <CAH8BJxGPzpymSWPpxXRcCCx-OPckm5bVgENUEjVM-+9sr1T+6A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608011107190.149069@virtualbox>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com> <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com> <20160726203041.GA4675@sigill.intra.peff.net> <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
 <CAH8BJxFvyEDuj-mm=N=ca3kxysopaBpro-HsuL-HZehqE_nxDA@mail.gmail.com> <alpine.DEB.2.20.1607271649120.14111@virtualbox> <CAH8BJxGPzpymSWPpxXRcCCx-OPckm5bVgENUEjVM-+9sr1T+6A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ahub3IqKduovD5Ianc0IRG0GoUQf8HjDS3l0UACh1Toa/sAXoDY
 ySxntds0gkou6dTQczM1NdganHqkMLnlnrBwoWE/e9te2D1oFZAe1osmtnitVz8rreWZt3f
 pN18vgIzSkrVa5wPLCA75o5cZ6P+BG6vDvE7DoKPNDS9uGlOrlUmRMgxMVbnMsvhP/y9v19
 qVS3bUblLIxranAPP2YAA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:egGYCAvkZXo=:EkcrNUq1BYSnIZhLXJFMra
 NUR2XLHQFLUBj2PAhaYhsIykfw8ubecvt8Ww2ZbMAkQCp2FAGIzq79qWTv6t4sbJ9LDOD51O6
 c/r7JgDsMCyfKdwIC/zm/uWi3XQgFzj6mcD0zD2EH9yl07IFRxQowjaUtg8dy8tK4qVf8OZFL
 axF2shmdc7QXorOhz9kosF4s1cwU8mJ0jVjExTzP3LRYI3I7NlqB5w2NUwLw+MgLJyNuJUNEz
 5BltR/vzJUrKR/mi38ZLe7MwEtPux8WFKM6Dx/DM44+Ck2zgF5hBW62lz7LOrhETPPfuKQerH
 Y8/oeswbzMK/h5up+SxWj8CcQqaIMKFTW4iLjhPFPb/I2B/NZ9YK46bhhJJgdWBcmdnZ5SBrC
 pmwgTjoP/FKZ4r6bHCwO/NCVnv009ub7Q1aRjPj8L1E5l71QsJqiz8SNIGY+r5PxqpHg/TyWH
 bAc2Ph1/OTnLbIIeQUXcYdWHRF1fPdgkRmU9Agv9Px9YPlg3PO+KucXCeVf4yUHYGVuH07Uhw
 V9du5XgguCBGyEBhNHR5TbzqO/2YI3tSM+wbr/il2y/l/F8mLdndO5Ym6BCCLjwHfVhb/Ni2/
 quqWYP+JQek4TMxWk1wsDovnUmhlmrJNLREUiuYj5b5k4S8DU7BvZXe99eRObQ9izyLqw+Ylt
 BCPqqO4JGUyebs6P+nPpztpnRA54A/R43do2ckafBi4BBZHrwLYxht/Tu6iY8s4FgRhBgU5mQ
 dJTpAKBnq0Zkmo4IpCm8pFWbuuJ9dpPbOBp72vv/3P8Ma/WECd3iFHETRxpT/RrzTsIL2/3Rh
 OLdVT8R
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stephen,

On Wed, 27 Jul 2016, Stephen Morton wrote:

> On Wed, Jul 27, 2016 at 11:03 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 27 Jul 2016, Stephen Morton wrote:
> >
> >> diff --git a/sequencer.c b/sequencer.c
> >> index cdfac82..ce06876 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -176,7 +176,8 @@ static void print_advice(int show_hint, struct
> >> replay_opts *opts)
> >>                 else
> >>                         advise(_("after resolving the conflicts, mark
> >> the corrected paths\n"
> >>                                  "with 'git add <paths>' or 'git rm <paths>'\n"
> >> -                                "and commit the result with 'git commit'"));
> >> +                                "then continue the %s with 'git %s
> >> --continue'\n"
> >> +                                "or cancel the %s operation with 'git
> >> %s --abort'" ),  action_name(opts), action_name(opts),
> >> action_name(opts), action_name(opts));
> >
> > That is an awful lot of repetition right there, with an added
> > inconsistency that the action is referred to by its name alone in the
> > "--continue" case, but with "operation" added in the "--abort" case.
> >
> > And additionally, in the most common case (one commit to cherry-pick), the
> > advice now suggests a more complicated operation than necessary: a simply
> > `git commit` would be enough, then.
> >
> > Can't we have a test whether this is the last of the commits to be
> > cherry-picked, and if so, have the simpler advice again?
> 
> Ok, knowing that I'm not on the last element of the sequencer is
> beyond my git code knowledge.

Oh, my mistake: I meant to say that this information could be easily
provided by `pick_commits()` if it passed it to `print_advice()` via
`do_pick_commit()`.

Ciao,
Johannes
