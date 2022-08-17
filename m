Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F05C32772
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiHQG2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiHQG2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:28:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A45BDD7
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660717681;
        bh=M/DascS8ERyEbxyi97o+fB1x7IsZUaWdeDy2/2HO6ds=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tb1Jp4A1Kdy/hPLOZoXrpkMnHqMDmk6Yb1m+P8DN8njDnWVfu+uZTbnosqPeWH7eF
         sKTeug0nwX7WQxDpSIecxv8230dluNgLAQ+Lar4gN3GRi5dgiz77j3rHaYrne7uTyh
         rP8i7DS34k7taleyGR4mjYt15LWAFWk2xNu1sDE0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1nTV8l1wCA-00w0Gf; Wed, 17
 Aug 2022 08:28:01 +0200
Date:   Wed, 17 Aug 2022 08:27:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15)
In-Reply-To: <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com>
Message-ID: <p941o26q-op57-n2q9-1646-oops0300n837@tzk.qr>
References: <xmqq5yityzcu.fsf@gitster.g> <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr> <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2127770750-1660717682=:241"
X-Provags-ID: V03:K1:A8J0vIq0qenLWOrFnp3WSVD4o82HB8t6PeEhcPX4L9eCvHQzBu8
 ThE+vwju1SmWJv2FoOE2Km39ubEYq+4Lfz1AtTsZ3oE/GEJx6gWjl0pzFQijx9179SiKLHQ
 KaEH8SGoujFKhAqcEJrbXJ8EPwqFxmrmsSSjmGINg8gmnuCkNVwytZdgEmvWeSunMxFJiZn
 YVURaQOBqI1eSxAD4KCPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oc3C5NDe5uQ=:YPVd18pecKJaJmnSl1BSaG
 +J0FVD77ojLcICjzpaz8OfzyHPsvyfyEk56djo5BnCHBOOkAnvDfU2zLknDDD6Drx83pA/sLe
 306GgG9KEjiAk69PcJOeVuKeopox5IhzNl8z8OAzX/zSzZ6is86rWekARYdCqPRe2eT6SS2Kl
 FW7bychiA8vOl9NeD9fGMn5yuvChL7An6jdugwsfUYQLQFSpgK09R8EztTAmgV1wvBCB59e69
 JG7D3UdL4+0iiZzP4QllpY8dUmOtUjskqLjSSbFMmBy2dBI9IlSKGvjxj4hw65XKmLRJEN+Oy
 rjv+nTgrRojQ62NvRWJVtinXiPv1wQReXRhaMYLKBHiCULQgLz2qQPHjDzqVcYPFSoZItF5so
 +AcXyt+PBJ4iXk03tnJ5jOqmLEWAIjoNcSgWXwtezxsw2pUta8qHsmPTRPlWKZXnA972/9aUb
 cixkbcVARElzbK9Gr9UD5QyAh+l1/5Y9jjQ2j1PhfbilRLWjYtzSF802jg0JrknC4xX/6He1g
 evnpGtudsFJg+Ya2f5JQ9SzsdQ3yu/jvmWSNoZMcYhTrskUczGoJ2kBIv6fTV5V5qWnxYse9J
 NA7VSWnCvta/b5YmRHo7TGP638CjUlzlM/lPI9l0d51VnkzZzlsIJBmtSe983MT7rWDqa+M/9
 jWz+4OLfjSUYrbYJiCvgyLzNC/xfvOBROVaCJ4T53SvhnYFrAcwnPi7guUqf9sdgfA/aoKk57
 KiA5lvhmS/aCe+1iolaRuCQ6L/dmOKS+FFPyOegn47JPBSn4vS0rSEVmbutbVPu/Vi6E1o2YS
 /dMGuHrk/Y4eze/xlp/412u502apQyqLtQofNQnSNtVzqrVOjpWd/D+pLpVgkRqFcym1CknNt
 TQFY0Gifo7ibv0z8uA7IrdfDdQjLk5vNaCPJHCAi1JTE2s3LV4JsdBWJ3CfVUk0QFpQlzKE9S
 aVnEhQbhfTaDrN0d17cddmRFR+uy052bcjJpJk4c3a8pq/Ke7VVnH9WuweMaTI9q8WF+j473v
 H45Nxz7JTCdKDGdmbTi25QaihM1qny0I1fqCiwVnRxaK/qgSVKKDvcTFGu/5FaSwHAktJulaV
 aEa0zUITJmzLXr83NjfEvtxBw2ix2zSXveyDJOnkAhCOW1TpI3n9d2DyQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2127770750-1660717682=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Tue, 16 Aug 2022, Elijah Newren wrote:

> On Tue, Aug 16, 2022 at 3:49 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 15 Aug 2022, Junio C Hamano wrote:
> >
> > > * js/bisect-in-c (2022-06-27) 16 commits
> > >  - bisect: no longer try to clean up left-over `.git/head-name` file=
s
> > >  - bisect: remove Cogito-related code
> > >  - Turn `git bisect` into a full built-in
> > >  - bisect: move even the command-line parsing to `bisect--helper`
> > >  - bisect: teach the `bisect--helper` command to show the correct us=
age strings
> > >  - bisect--helper: return only correct exit codes in `cmd_*()`
> > >  - bisect--helper: move the `BISECT_STATE` case to the end
> > >  - bisect--helper: make `--bisect-state` optional
> > >  - bisect--helper: align the sub-command order with git-bisect.sh
> > >  - bisect--helper: using `--bisect-state` without an argument is a b=
ug
> > >  - bisect--helper: really retire `--bisect-autostart`
> > >  - bisect--helper: really retire --bisect-next-check
> > >  - bisect--helper: retire the --no-log option
> > >  - bisect: avoid double-quoting when printing the failed command
> > >  - bisect run: fix the error message
> > >  - bisect: verify that a bogus option won't try to start a bisection
> > >
> > >  Final bits of "git bisect.sh" have been rewritten in C.
> > >
> > >  Expecting a (hopefully final) reroll.
> > >  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
>
> Junio: This link came up dead for me; I think the intended link was
> 220627.86ilolhnnn.gmgdl@evledraar.gmail.com ?

I had mentioned this in
https://lore.kernel.org/git/s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr/
but failed to ask Junio to change it in the What's cooking mails. Thank
you for pointing it out, too.

> > >  source: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
> >
> > I had another look at the thread and did not see any feedback that foc=
uses
> > on the actual scope of the patch series. Conversions from scripted par=
ts
> > of Git to built-ins are always a bit finicky (and hard to review, I
> > admit).
> >
> > Therefore I would like to move the status to "needs review".
> >
> > I do not think that there are any major issues with it (=C3=86var's fe=
edback
> > notwithstanding, it focuses on tangents that should be addressed after=
 the
> > conversion, to avoid losing focus), but I would love to see a thorough
> > review of the conversion to avoid obvious regressions like the one in =
the
> > built-in interactive `add` I had to fix recently.
>
> I reviewed it --
> https://lore.kernel.org/git/CABPp-BEOX+zxR9-yyx-EaiOV-Z9yD0YP_Kwvu4iGB8e=
nz40XXQ@mail.gmail.com/.
> I looked over the subsequent iterations too, and they still look good
> to me.

Ooops. I am sorry for misrepresenting the situation. I honestly had
forgotten that the patch series did, in fact, receive a good and thorough
review.

My apologies and thank you so much for all your help!
Dscho

--8323328-2127770750-1660717682=:241--
