Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2F020248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCMW1N (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:27:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:34999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfCMW1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:27:13 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRI2-1hQpYT14gU-00ManR; Wed, 13
 Mar 2019 23:27:03 +0100
Date:   Wed, 13 Mar 2019 23:27:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache
 bug
In-Reply-To: <20190313163516.GA26045@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903132322420.41@tvgsbejvaqbjf.bet>
References: <pull.161.git.gitgitgadget@gmail.com> <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com> <87k1h2bvpb.fsf@evledraar.gmail.com> <20190313163516.GA26045@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-224454956-1552516023=:41"
X-Provags-ID: V03:K1:M9X2pkNxkJaN2aElZ4+cYtlyKxxyViobEnzFuayMb8sHyjbRw/5
 CksjeHXmtWg45KNS2H/Ixs22Jjw0vaLDCIgQKyVI+eQNvppZfhdOg0zNQaHQDq70beECd+K
 R6wfHydjjTpS5Ey7kwLeL0IPgoSTuZrkFrgRV3/o9r65paJAbU2DtNiVUfBaHCnUPYHcfOs
 US+/xXBRdAOv4lTnW0JIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nctFELDh1NM=:Amt91tx/MFDDscRGiyQ7+v
 Xyg8PS3/1MW2bOxtyq2xwEjn/hlPXhbbYACTpLyRYvfsldQd0IWDwZW7cBfJjJWa9qlKWe7ep
 GK9bNmt3ccTHQefos791nsMpsaj4jw+GZAKN7vnUDdw5NW/2gUf0bybx2iH16QESNUAF9FRoE
 LLdsno+FZ1pQboeOVzlkgrhg7vm069z1R7W+0CGO0XXnMQFrIBlb+aZqYU8M94uaHWdJq+iyv
 /d64MdyHszI+w/j6ev7u3G9MySIhMcNe+43X/aOvT/0YqZAttMu9WRg1Nc2Q+rBFdRrW8zXzt
 j7CB95A3IY1x26AA/fFL546D5oyceKBquyXTPgF+AzvuXiDoazbMitsBjmWwYiPb41Q2CYlyz
 iB7aGBfPmyETJzdxSKs/+5s7pnrbMuoTunXZQXovcFJyP35vbp3tBdArVCcx7l5xNYsSZCXbu
 sAued0fAjH5NEVj7JPfVTgJNZAEoDfjK9qFhp0MsJQ0O41MTSWp+rSKWcffHmkVv+wOIeqVaX
 erSj2L7b/Zmg/nsRM/bUfDyGceug80/qaO5iJpEPbKidxGOSMterifuLLXK7JZeue0btNy/rQ
 dcWQUR/kgvcrr7R3tPk+v3Wwh1S4PGfKO6OkSxmB5GFjUxrOC7EYcBZzzmu/Fk4xy6GzkN+w6
 W42kDl8sGExpPFaFSXmMZ9XgdaxgBcuVKpgFZub7bgcB+ebTup1VJjMBxkxCb5qiFEl/N8NhN
 ianrpF7ibLr70hbzMUb1eklPMUQndvNRRRWAXVXd/5y8xY4BW/0WbDD97bwPpoj7FuoUq70wY
 mQf2j056uQiZA/iavzHBjJiaDIGVyE0iVcvUUy84tB3gRqlV+ECMIDCUZ28Y+HWYCx+jy+Y+1
 D6jSVSPL6OWUxgkTX0j8tB+r/Sn5IsOr1Hj9w2F4GEG/jZC7YAUDu8D4owzhBFeOmB6YjcY5y
 Ufk/XWBP1lg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-224454956-1552516023=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar & Peff,

On Wed, 13 Mar 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 05:11:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > > And this is where the loose object cache interferes with this
> > > feature: if *some* loose object was read whose hash shares the same
> > > first two digits with a commit that was not yet created when that
> > > loose object was created, then we fail to find that new commit by
> > > its short name in `get_oid()`, and the interactive rebase fails with
> > > an obscure error message like:
> > >
> > > 	error: invalid line 1: pick 6568fef
> > > 	error: please fix this using 'git rebase --edit-todo'.
> 
> Are we 100% sure this part is necessary? From my understanding of the
> problem, even without any ambiguity get_oid() could fail due to just
> plain not finding the object in question.

Indeed. It could be a typo, for example. Which is why that error message
is so helpful.

> > As a further improvement, is there a good reason for why we wouldn't
> > pass something down to the oid machinery to say "we're only interested
> > in commits". I have a WIP series somewhere to generalize that more, but
> > e.g.  here locally:
> 
> We have get_oid_commit() and get_oid_committish() already. Should rebase
> just be using those? (I think we probably want "commit()", because we do
> not expect a "pick" line to have a tag, for example.

I did think about this while developing this patch series, and decided
against conflating concerns.

And I was totally right to do so! Because I do have an internal ticket
that talks about allowing `reset v2.20.1`, which is a tag, not a commit.

Granted, it is easy to work around: just use `reset v2.20.1^0`, but it is
quite annoying that we do not allow this at the moment: even if we do
allow `get_oid()` to resolve the tag, we don't peel it to the commit.

#leftoverbits

Ciao,
Dscho
--8323328-224454956-1552516023=:41--
