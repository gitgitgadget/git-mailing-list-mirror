Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685E11F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeGSSei (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:34:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:43993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731832AbeGSSei (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:34:38 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4CB5-1fyQNE3Ugt-00rmrZ; Thu, 19
 Jul 2018 19:50:19 +0200
Date:   Thu, 19 Jul 2018 19:50:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
In-Reply-To: <CACsJy8Cxp6Gtt3YdWvQ0=t4vqBAqNxrGPeY4B7mtjsiLNpG5TQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807191949150.71@tvgsbejvaqbjf.bet>
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com> <CACsJy8Ce0kXTCzLf6jFq1QjY4Q4QePfk1JbgGUr-kQqQDCc7mA@mail.gmail.com>
 <CACsJy8Cxp6Gtt3YdWvQ0=t4vqBAqNxrGPeY4B7mtjsiLNpG5TQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/qj/q6xLaUdFmAwKcfjVuNzFy+8cNqr8+fgR+XqCqoQ+EP5INBi
 tHCTLDP3Y+UXQie64wVTACyInV2hQ61SBRhsKCwLJMGvRWYfxId0daqR/WG5TWrPvGq+7J1
 YtSVXo+M3D3uUKfcP17P6F8apgxmvF/hm4br28MPNYsFvxNNAxFjtokuokGLElL5PzxzNg8
 H8/j98s3jOZYToahvhBWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:grl4hREprEo=:ejrLWG2sPcoskGDZZUYSS8
 4deQ71Du1vVrQlUSlUXos9rZgVX3xaYYIO0IG3Ha3NjwLlyOVDyoDGQWYHDYm6kGnyHQSDw3B
 00N0fp2HIdY5JLggMNyNtZaD7TJBU+eLpmGJgMlTjyETL6Zk4QfmzRDtSV0g864pHY4gkTjp7
 +kDHo6U0I2hdyUY/phQP8CwTA4DZToy+LdNl6f/ddArEamCDahVUyQsaUB5TWcTv3Ibu43OeB
 Fzv2NDvFgqdtN2PyM4RO+qDbLwkcCjT2WKJwdkYIpni0S8bu3HMNjhXlwRtBUQ0us4yoRNlLo
 HsOuE94Bv5L4CoJxyJspPQlV9CL2XTgBRU8wM+/BL0Hy66lN/cBP1wFpuEuhs8GFQ8w6BTxqa
 +9y5trvBWOEC+z9zLmx+fNfHIhodNL0L57dEPiroqz7Xq8dV0Gfep2SBwId3B8EbDCZEi0GGY
 QX8OQkvYjqjqSj8DYmWeweVl9BiZ8NtxdgdWbGqoStB//4brpf8vSdQK+aBwfRiMzXcFNoJ8D
 H++Va0EiFYzSqt+0jgKSWmLDq25wdJyPl8B+KdjPGggbqVnRkMCkfKTcUDhJ9OpPCe0a6hzYA
 Xf7WcAaD1cJWiZ6dM6UX8bmYPcsjC7goa9FTHlUxHoZ2fjorNHdiDRr0ayTmc48cIrS2LzCFG
 WXC8Xnekgww+Cth7R/fv8PlDbP5ItFO+gAyXS4c9ciQqIal5a1d2kj3wx81sMXIN6pMvFKy5d
 uZ+B8VveHUGAGTSWZ7MJbvJkwYASv0sWX9IciwUcY7YETgFfwALptDGXyWgB1LXBu8Q6zIGGc
 U9kdg1r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 17 Jul 2018, Duy Nguyen wrote:

> On Tue, Jul 17, 2018 at 6:39 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Fri, Jul 13, 2018 at 10:19 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > While it is true that we never add unreachable commits into pack files
> > > intentionally (as `git repack`'s documentation states), we must not
> > > forget that a `git fetch --prune` (or even a `git fetch` when a ref was
> > > force-pushed in the meantime) can make a commit unreachable that was
> > > reachable before.
> > >
> > > Therefore it is not safe to assume that a `git repack -adlf` will keep
> > > unreachable commits alone (under the assumption that they had not been
> > > packed in the first place).
> > >
> > > This is particularly important to keep in mind when looking at the
> > > `.git/shallow` file: if any commits listed in that file become
> > > unreachable, it is not a problem, but if they go missing, it *is* a
> > > problem. One symptom of this problem is that a deepening fetch may now
> > > fail with
> > >
> > >         fatal: error in object: unshallow <commit-hash>
> > >
> >
> > Could you elaborate a bit more?
> 
> Never mind. The problem is described in another patch.. sigh.. I
> understand you want to flip that "failure" to "success" but personally
> I don't think it worth it to look back in history and have "what?"
> moments like when I read this patch alone.

The split was not meant for your benefit, but for the benefit of verifying
that I indeed fixed a problem.

I don't think it is a wise idea to squash them together.

Ciao,
Dscho
