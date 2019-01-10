Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B091F803
	for <e@80x24.org>; Thu, 10 Jan 2019 15:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfAJPWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 10:22:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:44311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729606AbfAJPV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 10:21:59 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfzEP-1gtOHC2z1p-00NRNz; Thu, 10
 Jan 2019 16:21:43 +0100
Date:   Thu, 10 Jan 2019 16:21:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anthony Sottile <asottile@umich.edu>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git add --intent-to-add + git stash "Cannot save the current
 worktree state"
In-Reply-To: <CA+dzEBn_-=77ZzfOaS8nVnQkf4rh0Y6TbEknZe6c02cwktrTJg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901101620470.41@tvgsbejvaqbjf.bet>
References: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com> <nycvar.QRO.7.76.6.1901091922300.41@tvgsbejvaqbjf.bet> <CA+dzEBn_-=77ZzfOaS8nVnQkf4rh0Y6TbEknZe6c02cwktrTJg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kgNNAGytJ/mEBsawKx+Y0aIUpPebLLP/V+4Fiq1o2YcmnzOTU0W
 2ocyr0c0HRR7Q4SogTQkFe8iFODPXTKZI+1pE1PeBVYg/0Z3hVRGpLpM/xL7TZ48Zf+Shgv
 04j67Ej/pHOPswFJ2M4uJkhbw5/4XGQwiJwF/BrM/ashfzfe1mCers5lzZE//vo8G0oxEZT
 iTTw9gKYQAKu9FNattidg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GvssCInf3gA=:62Urb2arCYRbTTcadSP1fM
 ToWmzhIJjeJpbwkdVHWib0IR/nFnldrkxT04BJLm612BUVKz1739LRMceutmWX/SukFxtiSmz
 KW4GbBFG0qr32YXgzRWKls5AG39JmHIxmJGtru+1rjtcNpfVlwTngtt80dQv1p3yC3EKXmsn2
 EGcuJrazRON2R2lat6clMPQMMjUWi45Z4PtxbVVPthejqiCruf1Stcm1gNnpNPFw3HESeiKQ2
 hFVf0BDU0LpmVLIDBnQIFWy7AqPD3lkI5tgywTtWoq5wVRmcobL3J/6bqGcQJPraqI76c6bOy
 PuYftqHOjmPjTrbH5c43WFSQdWduJzVWRnoqLCiBiw+sq1yytRsNTWkvDdJwT7Zvukd9OqRQ2
 Wt0Rq36WyrSf5UvFwlWV1oJJqPJ94rym5fWsIyk7CFBn4BJDtTVUsb2eZ1H27EJKT93hUZ/Xx
 8xlSVwi7hByq5seZ2Q1bGwVec7UUu9YaUvcDmogwFy9RP8JcDyEzET9e7W5lqZQbNjoWvOZYm
 NTu5FXzQOtIB64lqfHZCcdiMCixpUeKuP00I7hfP6yvvaLkVlow3aYE2V1ZUV9rHYbUFcO7q0
 vfgExQFV7cZE1dzXgVV/mDZj7BDz6ftZf60fZucP4Py+2nXg7k0pFHd1fPjrn07VjjULuuOna
 skpPnoeqI+cKFRT4k0PplhtYW1PZYvdV7pPOIE45RrGfd2QxEXcz2AC4c9g9bK7GJYqg2eygE
 7WyS/d3+0Xp1+zhgowEyOCPObrtBNLLYfo54p+v7dUTZwbTmJeu5EsVJgrZHCfTVMdg50knXk
 jgfX3Ms8ti3Zy46UTwr9oIyuJeiELUSCPRpVgmyexXqgRSt8fyN3VArntScHBxgeQ5lnkHbYQ
 NPWqql2mFUC8DZ2qvvZH/wNQ3cE17pse+Bo8TzxmlNrx/KlvVwl4AP8hQau59fplz8E6gCvU4
 Pq5K/kpLOrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Anthony,

On Wed, 9 Jan 2019, Anthony Sottile wrote:

> On Wed, Jan 9, 2019 at 10:25 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 3 Jan 2019, Anthony Sottile wrote:
> >
> > > Minimal reproduction
> > >
> > > ```
> > > git init t
> > > git -C t commit --allow-empty -m 'initial commit'
> > > touch t/a
> > > git -C t add --intent-to-add a
> > > git -C t stash
> > > ```
> > >
> > > ```
> > > + git init t
> > > Initialized empty Git repository in /private/tmp/t/t/.git/
> > > + git -C t commit --allow-empty -m 'initial commit'
> > > [master (root-commit) 858132e] initial commit
> > > + touch t/a
> > > + git -C t add --intent-to-add a
> > > + git -C t stash
> > > error: Entry 'a' not uptodate. Cannot merge.
> > > Cannot save the current worktree state
> > > ```
> >
> > Apparently it is even worse. On Windows, this reportedly resulted in a
> > segmentation fault:
> >
> > https://github.com/git-for-windows/git/issues/2006
> >
> > Could you cherry-pick the fix of
> > https://github.com/git-for-windows/git/pull/2008 and see whether it fixes
> > your use case, too?
> >
> > P.S.: Obviously, if this PR fixes the issue, the corresponding change
> > should be squashed into the appropriate commit in ps/stash-in-c.
> 
> I don't see a `stash.c` in ecbdaf0899161c067986e9d9d564586d4b045d62 --
> the patch doesn't appear to apply
> 
> `stash` appears to be implemented as `git-stash.sh`

Whoops. I thought that you were on a different Git version, one that
already has the built-in stash. My mistake.

Sorry,
Johannes
