Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616121F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCZNRf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:17:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:49393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeCZNRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:17:34 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNqfr-1eufNe2LO7-007VPb; Mon, 26
 Mar 2018 15:17:25 +0200
Date:   Mon, 26 Mar 2018 15:17:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <xmqqk1uf3kcd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803261508540.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
 <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com> <87h8pvm7zz.fsf@javad.com> <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net> <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803080804420.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqbmfzx9n0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803111248200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqk1uf3kcd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RyN3UP6+Ga6GJyMxa/gnaruD2etptgYXRk6kMqaVP/N79+iNHc1
 jgxMg5qzMpXG6tf920IMFQXd5nKkuiZgo2p8p0Iz/dZoPt2V/+dFOjClV6awu04uIlFEvZj
 LmNUoZyv2udz1UzvjFGB7NGu/W11bLj/Bq8ETYecEXHXvP3p6mfw3OZkw6lkgkCeYtyw2sE
 ivwumZp9jMVxIUWfn7KDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KEZh17Qf1SM=:9tH7cuXdR4KhJYrXr+WzWT
 4B+SG6V3IuG33n5WUsNOKw2VCT9UK7EINQIcgjoj6Nobe/M5lCBLyc89nXugoLcdzfzhtdSw8
 0iMPhA2Hy279OCqe4NuyywjOK/On/bLOFfbx6xC7UYhFkfqWU/DZZ0l82xqGYwrjdEtAV/8Fy
 QDdlIGL4LC3EXFn7zsc9TALI0SeBJmnhKrqS/bzoRevJSERukeDvPKMCwkpMkVD+mXbmfkmnQ
 aN7tJrPfat+OCXoeNE7OJyxiBSnoHRcs9ycoG3l3eYBCu1nbq+JhCwCzbfodv9M0BCoaEoPBL
 Q0JYcBXX4LUEL7V0UvjME4dIJ5ix6ekb36rvBu0Py2uM1JB3J76nq0r/jR9QelEQgspTUfVWa
 tWFYMmkCFfH6JyN2uVoplgnEKqaofM+j5nISSP7Y6rnTxhJps7sQdWcp3XTGkwrASOMdNVedx
 5XdrU7YOGjIoPpI/+BnQFPbhL2zJe/m1THSPCfFMzueIfFBr06Bz/sG/4pUlWu1FotTyfyb+z
 JcygoKq41HPM34CCq7ArurAYZPQK+j/RXnMbohCoEOznFQYoeDSGfcO3EAf1dihv3bvtSGWDE
 2tv+p7oStEMZzj4Hx8Po79SmHVXKpyJV5BOqhne5hJ5UgMz6QMEd7w2alO0pn59HR2NnURd4x
 Jk6RZNFnOWJURR+0EWeGzfIgLzzMkYSLCbQio6puFDvNHD7J46ZO67c4VA3CfKZytDShEpxwG
 FCuIo9sxvu/ewBa8M+Hcuuxb+a98PUZmlc6I335bftU4KeFGcVx0J/rr6tfVBhYcJd82otqZD
 yGY2RwzT5JSLzgt0/1WEzzg655P4eE6NIN84b1VoaEQCpe8uwRgSnx2Fmh4CYrJ7PjiOA1y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If so, what tooling do you have to identify quickly what to
> > cherry-pick, given merge conflicts?
> 
> It exactly is the issue I've been trying to find ideal solution for
> quite a while and not successfully.  Here is a sample thread
> 
>   https://public-inbox.org/git/xmqqeft3u0u5.fsf@gitster.mtv.corp.google.com/#t
> 
> and every message I mention "merge-fix" is relevant.
>
> [... detailed explanation of the current "band-aid" system...]

Thank you for the very thorough account. I have been struggling with this,
too, even chatting to Michael Haggerty about this at the Contributors'
Summit (where I missed you a lot). He pointed me to a blog post of his
about the very interesting concept of "obsolete markers" in Hg:

http://softwareswirl.blogspot.de/2013/05/obsolete-markers-in-mercurial.html

Granted, that concept really makes most sense for rebase, but I wonder
whether the concept could be extended to help your (and my) use case of
frequently-changing targets (for me, it is more rebase targets, for you it
is merge targets). It would probably be implemented using commit notes, to
allow for bidirectional mappings.

Ciao,
Dscho
> 
> The current band-aid system punts and indexes the merge-fix changes
> by merely a branch name.  When refs/merge-fix/X exists, what it
> means is "When branch X is merged to an integration branch, it is
> likely that the integration branch _already_ has merged an unnamed
> topic that causes semantic conflicts and requires this fix-up".
> This needs occasional manual adjustment---e.g. when the topic X
> turns out to be a lot more stable than the other topic Y that was
> causing us trouble with semantic conflicts, I may at some point
> reorder the topics and have topic X advance to 'next' before topic Y
> does.  And when that happens, when I merge X to 'next', because Y is
> not yet in 'next', I shouldn't apply refs/merge-fix/X (often, an
> attempt to cherry-pick it on top of a merge of X into 'next' would
> fail, which would be a bit of safety, but not always).  What I
> should do instead is to rename refs/merge-fix/X to refs/merge-fix/Y
> immediately before merging X to 'next', so that the cherry-pick is
> not applied.  When rebuilding 'master'->'jch'->'pu' chain, X (now in
> 'next') will be merged before Y (not in 'next') gets merged, and
> when it is Y's turn to be merged, the merge-fix I used to apply when
> merging topic X will be applied.
> 
> In the ideal world (I think I'm repeating the ideas raised in the
> thread quoted), the merge-fix database should be indexed with a pair
> of commit object names (e.g. a step in branch X that adds a new
> callsite for function frotz() and a step in branch Y that changes
> the function signature of frotz()), and teach the system to
> cherry-pick refs/merge-fix/A-B to resolve semantic conflicts, when
> both commits A and B appears in the integration branch for the first
> time.  And make sure these are kept up-to-date across rebasing of
> commits A and B.  After rebasing the topics X and Y that contained
> the commits A and B, if they became C and D, the system somehow
> needs to be able to locate the previous merge-fix that was valid for
> A-B pair when C-D pair gets merged.
> 
> 
