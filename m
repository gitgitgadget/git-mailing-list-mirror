Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC3C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiCILsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiCILr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:47:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2E171EC0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646826410;
        bh=WbsrI2hxW4I0irR34/2OD3OsavzFdueN7RYMxsvd7bg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X4nXrBX633FsbVzsRs4aQ1PuEvIgXUSf4LTukVbSbZKLleAz/E2tNHhgRBYWhQ/Nu
         4JhSIa78kVCbilvgBTYrhuyFs6hJvCJtKEZA0kIj69+gS0s/FXLMee0xFa+Ku5Yix0
         pbxgvV4Pxc37ObWBZnuzXygO/SIN3z0Jztkx9QHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1o3iIy0lac-00gUef; Wed, 09
 Mar 2022 12:46:50 +0100
Date:   Wed, 9 Mar 2022 12:46:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/merge-tree (Was: Re: What's cooking in git.git (Feb 2022,
 #08; Mon, 28))
In-Reply-To: <CABPp-BFW7sAJSpbE2Ukm_0G1h3o2oY=AnyqErbUakAtwqqwYMA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203091245470.357@tvgsbejvaqbjf.bet>
References: <xmqqmti9ssah.fsf@gitster.g> <CABPp-BGZ7OAYRR5YKRsxJSo-C=ho+qcNAkqwkim8CkhCfCeHsA@mail.gmail.com> <nycvar.QRO.7.76.6.2203071728410.11118@tvgsbejvaqbjf.bet> <CABPp-BFW7sAJSpbE2Ukm_0G1h3o2oY=AnyqErbUakAtwqqwYMA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:49sdmrSPhuqkRTAr5+aCdhHY67Ohr+R2mvr+SQpf3VE8X7lk4oZ
 hK2XDQ0Sf/7NEBXk0YftnYoSx5MoJ8BQtY7uKcNNaqdDkXIVnZB7aeZI8xypLnyvV4wWqJC
 WC9Ihl5T/HX0Pj1hlad2Os3qDK4ExcFq8CiKuycMa6bXaX34LjKEeM3FUwMGjiG47p+I/4S
 T6K+fFzxK62CbCLLqqg3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fyxclmgjkIQ=:DYs3C+De/zY6barygeWdDT
 g0rNI14wbomd4MDit5knPDzdDNXC0xY0q5vlWvzq+rpEveE1NkldA2+yLATElII61Urrga2+G
 heyhqvchSwYoe7R0KTWaW/8o3cdMMI/A1tcNt242VGvpbuQT/8jr0YSXqnrSoojspQ0T2cNdO
 K3SHfbPtGVSrA2egF15YC+o4zwPV019VVfZG1NHNW5EN0HkiGjvwVbrL27wOl/Wr9X3ltgxya
 h2j57S+pbHSELk5lBhqJmCf9QST0PkHh5y/91X30E00IDkQgAYnQgD6453gn2jPUfTyrm1MrL
 tP9mFbEeSn0o3/HrleyzFwDYvLTQBP+foDcE7yOQUwMm6aN3OaFGW3Dzt+O14KRQ5+ffc6DaJ
 /8oJSxFYM/PdoU5wGiGS10Yeg18vOsLnAdB+Di/GKJKsYR2r9qojokjxiprbgYsiVzbbpjGvU
 /KhQpIz9S7YrvRuU/Wht8uEjXsQ6COkKKzl7nH2qKJ2I1sKj8lsMmKHVzhtLvs+KMkR2GtcWX
 zx0mpeL9jFZ9T27BXGrHCFsLgkfU4+9Jgangs0pe/wrhoJCZDiBAL174ehvc9dz1HZFzIbi9V
 7JyMLMb7jqzxYXQCj14+ZW9/36EU96OA2k3Guc8n2mZ82V15xOW0r3mHbD65yoOu8x8VHg5Dh
 MIAPk7JAPTmKWQSQ51sk2IqtIOM12+0O7OEZt8hZo1dJipRO1tYmkYxdXK1+7NuVflAaMCrUE
 n2eSF61TylxX1urh/PNWx6LyJKA+PHhJE+qB09K1F0rJ2P/hL05uWdXgVuoTzUUquYNZFPnzi
 Z/iaU726n3XiqPojQ74xjWM7DnpsCthjxF7QS0GcR5noQ5OXmv6av78PbNlnN9rTGf2oqMu3X
 Www54IWoBi/MZMj1W1FBR6RRJ03EAy0+tlT0++jwg6lgRxRwtzrjJ7NW6cX+O/vZmrSE9GClH
 zbXn9WG5/qYk9zUjaau2HE0U5tsSNDjCJCp8z6gCXzv8PzjrBB1UjZ74j6qqJFjeNYAf4wRLH
 zYAiw4hFntZCwoCwMbwPw/R5YKQ3K963Mvrel+Iq4SkxJ/HqSk0U70PUNf6aWTIaNoVgjhdnr
 vvSl02NxsSiXa4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 8 Mar 2022, Elijah Newren wrote:

> On Mon, Mar 7, 2022 at 8:31 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 1 Mar 2022, Elijah Newren wrote:
> >
> > > On Tue, Mar 1, 2022 at 7:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> > > >
> > > > * en/merge-tree (2022-02-23) 13 commits
> > > >  - git-merge-tree.txt: add a section on potentional usage mistakes
> > > >  - merge-tree: add a --allow-unrelated-histories flag
> > > >  - merge-tree: allow `ls-files -u` style info to be NUL terminated
> > > >  - merge-tree: provide easy access to `ls-files -u` style info
> > > >  - merge-tree: provide a list of which files have conflicts
> > > >  - merge-ort: provide a merge_get_conflicted_files() helper function
> > > >  - merge-tree: support including merge messages in output
> > > >  - merge-ort: split out a separate display_update_messages() function
> > > >  - merge-tree: implement real merges
> > > >  - merge-tree: add option parsing and initial shell for real merge function
> > > >  - merge-tree: move logic for existing merge into new function
> > > >  - merge-tree: rename merge_trees() to trivial_merge_trees()
> > > >  - Merge branch 'en/remerge-diff' into en/merge-trees
> > > >
> > > >  A new command is introduced that takes two commits and computes a
> > > >  tree that would be contained in the resulting merge commit, if the
> > > >  histories leading to these two commits were to be merged, and is
> > > >  added as a new mode of "git merge-tree" subcommand.
> > > >
> > > >  Will merge to 'next'.
> > > >  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
>
> So even though
> everyone else is saying to merge it down, I'd rather not quite yet.

Fair enough. I guess I'm just eager to see it land, and I do not need the
machine-parseable aspect of the conflict messages _quite_ yet ;-)

Ciao,
Dscho
