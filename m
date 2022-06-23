Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835E1C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiFWKDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiFWKC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:02:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1B1000
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655978562;
        bh=Phg2xud2jeeyIA23RSTsm1T60ekPhcfkMraD/3lEiqc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OgVqdcV8zxxyksLTQtfGdVEIlI0EqwpiTSJ9yhLKBdLD4H0G0eHcK9pPkn2TuSlPM
         OjtFUtUcR3j8a7fbsY8g7HQpmwi0LyCEWuTByfLm/Lu6d9+5UkEME7SNCIALn0vjKq
         dy+f4IrBHTln81FnQ5FEMiq02uH/oSIfDSMS1Q9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.215.93] ([213.196.213.23]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1nIHYJ2lrl-00muR1; Thu, 23
 Jun 2022 12:02:42 +0200
Date:   Thu, 23 Jun 2022 12:02:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/merge-tree (Was: Re: What's cooking in git.git (Jun 2022,
 #07; Wed, 22))
In-Reply-To: <CABPp-BGGDvZ40TY939fFM0xPZuaogPS+ymfEpc+hv-sJnO8Jcg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206231201470.349@tvgsbejvaqbjf.bet>
References: <xmqq7d584hqb.fsf@gitster.g> <CABPp-BGGDvZ40TY939fFM0xPZuaogPS+ymfEpc+hv-sJnO8Jcg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gn0lAeQmyb+RPV1K+YzH8T7W9W4kRT72E/o8b0ndsMahxYBZ1Wo
 fV5gg33tDehPoW621nH/4pA5WfWX00h4o7SoNwRaXqfChC9ZnQ3Fu7Es1uBk13RqyEZIxis
 iQPGZiZvHQfK713rHbsf1G8JwzC8x4x31AJCDOggLI4SYwj7gF6YNYnbw2pbFe0N7jrSOZv
 Mq/iatBgF5on1A9Is+aiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zgag/qB9T5A=:61ijTA1hPQTOMfSOWUyCSZ
 iEjJCvTVTDMGjmGfiGPnwpzqAf75qbXLWwfMAYb5MVZgqXRh+O+5MPkm9HHTJX6YoCll6uwyB
 EcZJlgvV2nkcPVM9if8HmpPKPfKsaGAvqVRlOtSBEp6GGijsigniO7n7n1FVTbpELxJ6IYvtA
 /IteIJTthYFS+73M/UIdLCRWuP01h7bZmFMRB4Mtm6qZkbL2AtG/VhtE8HmN5dEDUhmCb5+W2
 v5Edg1poa/xnfoaDbY+0pWhBSKOvy758UGZWziwu8T3UBGaziRtzNawM7xg/HAW+gYXeyHNQg
 RvnsLSf9fjOjZ5eV5v8MWt/OTvSOJMkVX1wjSqdMy8aBjO7pSJubEjh9vFTWzaviwGFlv7v5A
 cNzGvN8DAPw1mrLFx1FdgSppDmZqpqbcooORYvF85ntwYxJ1OzXYX+xjP6LUePNtkCbk1QHfe
 Fo5u2fz3AyLsZXPB7P+85MYS611DqSAp9PlgLauVgh2Dyg+glbC3ly/2diVCpnFez6iM8elrb
 DvC4E2tHJ+AQY890sBOmveePTAMMznCtOf4pcaVARZ0CmqebTS+oa6ATOt373NTccap/4a6dS
 Nzp6REJo2znasMKZkxn63A9i+fpiSk/kNYchspXG45szIoigAlf1tjRLB5d+BsGPbDB5PR1BV
 wM2cSn2SQSXBc0AzJavCr8OXICM/xzxBIyysTu7eGONoxAz38ww8euIvgZAgv0fAF/edhApJB
 GUdVXc0/E9x+wd3mCwtxwJIJPf+yGDJ6NPZBJgvd0Po/a13Ul1lXO1pbX+TsUlP4z5QulSxoH
 QPdiYLRcm1jCHw2GEumcp+aDdGpy+GNTxPePgi8orE6f0qguTr/9vbCtUCq+nxYwj7HRD0uI7
 MzbveKKNrUrE3AJJW6SCe5vGtf/etpyv3xALwbrL+kjR1nRT8siqsxijp1QKKr/UuOMoDR/WA
 AZ2vdRi+42w9yEp/cvBC0XM9pBqI/ySeMMdRW+EOuRKZ6F09uvjb22EKsiL5flM1LG2gO4UTi
 Jdfq5L/unIsnanuGNSHfZqKBev/OKzZ+k6vy8KjNSkuTzxQNXytO5e8/lB/26XTRxsQuKYypr
 XIXc2oDaCBsnjm9VpPfb3NdHmvIUV61tv8QDlBs2pdaq3eJbJiP4Bttlg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Elijah,

On Wed, 22 Jun 2022, Elijah Newren wrote:

> On Wed, Jun 22, 2022 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > [Stalled]
> >
> > * en/merge-tree (2022-02-23) 13 commits
> >  - git-merge-tree.txt: add a section on potentional usage mistakes
> >  - merge-tree: add a --allow-unrelated-histories flag
> >  - merge-tree: allow `ls-files -u` style info to be NUL terminated
> >  - merge-tree: provide easy access to `ls-files -u` style info
> >  - merge-tree: provide a list of which files have conflicts
> >  - merge-ort: provide a merge_get_conflicted_files() helper function
> >  - merge-tree: support including merge messages in output
> >  - merge-ort: split out a separate display_update_messages() function
> >  - merge-tree: implement real merges
> >  - merge-tree: add option parsing and initial shell for real merge fun=
ction
> >  - merge-tree: move logic for existing merge into new function
> >  - merge-tree: rename merge_trees() to trivial_merge_trees()
> >  - Merge branch 'en/remerge-diff' into en/merge-trees
> >
> >  A new command is introduced that takes two commits and computes a
> >  tree that would be contained in the resulting merge commit, if the
> >  histories leading to these two commits were to be merged, and is
> >  added as a new mode of "git merge-tree" subcommand.
> >
> >  On hold.
> >  cf. <CABPp-BGZ7OAYRR5YKRsxJSo-C=3Dho+qcNAkqwkim8CkhCfCeHsA@mail.gmail=
.com>
> >  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
>
> Can you update from "On hold" to "new patchset exists" (new source:
> <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>) and move it out
> from the stalled section?
>
> (Also, FWIW, v7 was collaborative effort between Dscho and I, and
> we're now finally both pretty happy with the state of the patches, as
> noted over at https://lore.kernel.org/git/CABPp-BFfRGQybYManC6LfFTaAd3mw=
eBxL=3DAPCGP_vRF-WQxGSw@mail.gmail.com/).

I would like to enthusiastically confirm from my side that what Elijah
said is exactly how I see it, too.

Thanks,
Dscho
