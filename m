Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C521F517
	for <e@80x24.org>; Sat,  9 Jun 2018 22:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeFIWLW (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 18:11:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:34941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753396AbeFIWLV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 18:11:21 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbJTE-1fiD202XFk-00Ihyb; Sun, 10
 Jun 2018 00:11:16 +0200
Date:   Sun, 10 Jun 2018 00:11:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, alban.gruin@gmail.com
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the
 default
In-Reply-To: <20180607171344.23331-4-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com> <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n9xejA/b/GlTrCyepv5w63SgJjTKxSOW0hY6K947FGQ/EGaciBc
 ynyVwmemX7BdLj6MnaVgfMBaUiO/qbiWy8vn9vsc0QJrkY0WoRX6CTPHR9Yqz6Nko5ydz5f
 nb9Ugzo1kZ0ZniOWV0/GuskGS0lxVoYHDsz33xQBGIX0HGgmlMwrjknFQV0qa+GzmlKs4Iu
 JcFs+6E5VTz11juPD47aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IiFbKYDJGOc=:JmcQb+H9yVVNvPgZdYizD7
 jq0vy0lJsVzxJBYM2ZWZYm+IjIcJ77lYMxsFFVzjM2xJdDirwFRbKErk26YamcAMhUTEH3ZKG
 0sG0i6UqCAyKJ6FSQc1jzYtNjnMcRXZuO6UAyWjzXkEmpXYxxYBTZgIIbPNe1VshbWCa4oUQZ
 P0byeykH4HPZXN+3p+j9PMbsrDm+Orn5Kj5M/BVLU5V4pCOWerP8LDUzwOYXe3D6n00Ghxju+
 rz2ztTZF/V10fkTzbVzDynqJ7ms2T3aPU17Esp4t5HEulxJRQUiFXe6XCE+2TDDkXPBF10ggn
 eglhKASzFRbunexpFq5Si6j+GdDZ+E4du29pc6QPCH9aL87aXl19Eud+Puf/qZZg/I7zgRqhR
 O04puYDleh6UwQNCwW0EdaIHEyMzuqdZVr+TLeIn3Z3WH3PERltuNDFUVrXBYNtPcPlldXHUj
 ju5nZf3MgqhPS1U4DjCKVnUQ1YR2ihksoIb/ITOB/v6YR6QyVqJRSiNmaVPpu2k0A3i+y6Wen
 BbZNU50BB7uBI0TfkTGMdduSQB1KICByKOWL8R6QLqkVdxP0sYqZaFiv76QK77YNeLaqh2NaL
 ttQzNH3l6p0x2W6ejzrOdr2z8TPLZhJ4v/Svv8KRMjKSKBFm/1I9FfyIMVIZx3f79Of/zHUj7
 +pJQY+jKh26+4M9ma++G7TbJj4S6jQ6ubZebWrMjxO0kWVdqgbHMvfZypd7WSUb1Rg0ImoSMc
 wdM9te3bprvMbhHg6IqUbWx2BbTAHVDKlL6SrmQTRqCDIH6aNrfE3rl22L1TabEBfDh5FCueq
 H4r6q/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 7 Jun 2018, Elijah Newren wrote:

> am-based rebases suffer from an reduced ability to detect directory
> renames upstream, which is fundamental to the fact that it throws away
> information about the history: in particular, it dispenses with the
> original commits involved by turning them into patches, and without the
> knowledge of the original commits we cannot determine a proper merge base.
> 
> The am-based rebase will proceed by first trying git-apply, and, only if
> it fails, will try to reconstruct a provisional merge base using
> build_fake_ancestor().  This fake ancestor will ONLY contain the files
> modified in the patch; without the full list of files in the real merge
> base, renames of any missing files cannot be detected.  Directory rename
> detection works by looking at individual file renames and deducing when a
> full directory has been renamed.
> 
> Trying to modify build_fake_ancestor() to instead create a merge base that
> includes common file information by looking for a commit that contained
> all the same blobs as the pre-image of the patch would require a very
> expensive search through history, may find the wrong commit, and outside
> of rebase may not find any commit that matches.
> 
> But we had all the relevant information to start.  So, instead of
> attempting to fix am which just doesn't have the relevant information,
> instead note its strength and weaknesses, and change the default rebase
> machinery to interactive since it does not suffer from the same problems.

I'll let Eric comment on the grammar, and I'll comment on the idea behind
this commit instead.

IMHO `git rebase -i` is still too slow to be a true replacement for `git
rebase --am` for the cases where it serves the user well. Maybe we should
work on making `rebase -i` faster, first?

I imagine, for example, that it might make *tons* of sense to avoid
writing out the index and worktree files all the time. That was necessary
in the shell script version because if the ridiculous limitations we
subjected ourselves to, such as: no object-oriented state worth
mentioning, only string-based processing, etc. But we could now start to
do everything in memory (*maybe* write out the new blob/tree/commit
objects immediately, but maybe not) until the time when we either have
succeeded in the rebase, or when there was a problem and we have to exit
with an error. And only then write the files and the index.

In any case, I think that the rather noticeable change of the default
would probably necessitate a deprecation phase.

Ciao,
Dscho
