Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E43E1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbdHUKDu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:03:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbdHUKDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:03:48 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MduSz-1dwAqV0Uiz-00PfMk; Mon, 21 Aug 2017 12:03:46 +0200
Subject: Re: Git makes a merge commit but as a normal (non-merge) commit
To:     hIpPy <hippy2981@gmail.com>, Git Mailing List <git@vger.kernel.org>
References: <CAM_JFCzZWfyUiFVrYOztdJD8iSYvYUavbzKOX2bxDV0_hMz7Eg@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <d5bc0c8b-900f-456b-55a9-35408187d06c@grubix.eu>
Date:   Mon, 21 Aug 2017 12:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAM_JFCzZWfyUiFVrYOztdJD8iSYvYUavbzKOX2bxDV0_hMz7Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mJn2c2uMG4YJnHpNBEy5E6zQhoLlD7w34V6EH+TeI9dx5ARI6yl
 Vzk64yS1jg2WDxyVJRSzjIEGkYP41DAy8875960Q8uQi9tBJqtY5Fn8Gf9jCPL8G1wHzsa5
 Th/vFX4RqHxMX3O8uX9XlBHLjh7oepjGZpRjs543tHLqn0dmgTohxfF/16//IVjIApaG3q3
 ciWfXpeCFQQzaUSgN0IUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5cC78r7aAW8=:WQ/16m8xKBpzuwCZ2zGP4Z
 /uYFN+5GA/CyxPfUbGlVtsbwQj4omtlmmY7x4xSprOcY4nMkYdkVIF0tePXGti8DCZRmgR9nP
 X4BjUkETlzLjioTUQc+6YE+wreGQ/I4HcTLDD93wf5zEf7fKFLILTDA9AEblP2r6rwUwsmijf
 djxDdBO9lPD7MqwwXTY7mzOs579hKcJoX0y9Qeu5I3ssrSRQa0W6bcdE7ozX5lAYGvXZyaeKE
 NLtfSHIA+0D5sBehYmawkRveLsOEEHuUjyt+SHEXBcOz+xmp5muCDSE5C6yOCRBjGved11ieF
 GbK714iPT/qBvQugMPk0jp5bK8ybKT+DnOFYc1WPSF01N88V2RpswzpKDk5mm+hY6H7aYX+Cy
 4spHn05JUKjLUjRy/jDNLGTm5JwIQnzk7kYOTCHzAb+HtNtje+eGpM24CGgwxAuoL52AS/R1r
 bgxTNu9B32CP5MPdYyTfQY1Xl7Vn7K/mk2BGFiLc3Tz6hWqGgbeh5+uQpVXFbJYjlNj1Ml20u
 i2ChGU3jQBRpIO6ifr1O8vqClRvdQm9TIX7eGn5FAdKq3Z6aQbLNRYe80KB/wXoda4kPfRTCT
 cxd49lGx0Bh0aVumfeVTxhG8HHZQTK8dfD+DWgOvyBxaoJlLRSyuRtkXLLkCfg8OrO/ZbLED1
 ZssligsaZNEoe2kGsguCiY9v82lqaLsx6VR3+jq09YGHG2C5mzVT5cNUEOWzxDG4pVaqMrQ8u
 xP2saWkXQMoV3usP4xG/5uOx53cDYGccwiC6KDJCpA2s9ga2R2Gdi/FWAtc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hIpPy venit, vidit, dixit 19.08.2017 00:35:
> While merging if I do certain actions then the merge commit is made
> with the merge message but as a normal (non-merge) commit.
> 
> Repro steps:
> - Set GIT_MERGE_AUTOEDIT=yes (set other than "no") in .bashrc
> - Make a merge commit with no conflicts.
>   (external text editor shows the generated merge message)
> - Focus on Git Bash and Ctrl-C.
> - Commit (git commit).
> 
> Actual behavior:
> Git makes a normal (non-merge) commit (squash merge) but with the
> merge commit message.
> 
> It looks like a bug to me. This is very confusing later on as the repo
> topology would show that the branch is not merged in and there is not
> an easy way to find out when the merge was made.
> 
> Expected behavior:
> Git should stay in a MERGING state. The user can choose to either
> abort the merge or continue the merge (git merge --continue OR git
> commit).
> 
> This does not happen in case of conflicts (at least I'm not able to
> repro). I get a (master|MERGING) prompt till I resolve the conflicts
> and commit, which goes through correctly as a merge commit.
> 
> Environment:
> $ git version
> git version 2.14.0.windows.2
> $ bash --version
> GNU bash, version 4.4.12(1)-release (x86_64-pc-msys)

Thanks for the detailed info!

It turns out that his is not Windows specific. The recipe is:
- make "git merge" call and wait for an editor
- kill "git merge" while it waits for the editor

The effect is that prepare_to_commit() has no chance to call
abort_commit() any more (which would call write_merge_state())..

Now, I'm not sure why we only do half of write_merge_state() (write out
the merge_msg, but not merge_head) before launching the editor.

In any case, the following patch solves the problem and passes the
existing tests. But I'll wait for more comments (and think about a test
meanwhile).

Michael

