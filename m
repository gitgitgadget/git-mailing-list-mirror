Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296F61F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeDUHfD (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:35:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:42579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbeDUHfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:35:02 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0QLp-1eHxNM39mX-00uWqA; Sat, 21
 Apr 2018 09:34:57 +0200
Date:   Sat, 21 Apr 2018 09:34:41 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combination of"
 in commit messages
In-Reply-To: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
Message-ID: <cover.1524296064.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RunrBIiCdntGPlmlGh7HaAQaYUcdLFe6LvqfrWrTk5EvtiNHlXu
 x/XuHA8rW5E5J5f54N8m3vxV9a04AzjnVY2QSfEegxVK/eFL5GeIx7wKtN/uUHKSL6yWn1D
 5HFZOM2M3Ki9akT00JMOX6SBLE2dqM4cwaVqVx63Up8EPcXZxhRexiy3fnyBzPgY41jKP/j
 QLaDyj+g8HqgDdQdeCOvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hWcR7GH1qhI=:8+/i7Y7cyRAXiqXGIHT4yU
 iOzbQu5UEomIkkxBG/9yeShqsHeygeeWGLb9fQq30oET/JMbKoGRdWq4zBIbKGv9B4mazpZ4r
 G+Vv5iqITBcL8q9a+0dBVqHJx51rUlSJ5Ayao+Y0gauxZpkODSvdoX5Muji4ow//uhlREThbQ
 OSpcz5ETeThCHpkeSqq+XYWzHqNao4m6jF3Aj61c2R8C5n75YjvJk1kJkPhiMpGnmpQ4vBzsR
 tkpptOXi/rocRIh9jLfAgjWkvRa020SsTJUXNKUCtFQ/FzcfpHn1zM2x6i1gPihVaS6Kxg9uN
 md8TyeP2MGmFrjf1D8HNGQi+FKTMlp+pwnoBIGQPhTQ0Gu7sMtANaCmIPL/fAcg3YWl5pWugX
 88jS+aX5Eph5GOo/OnqOcuPCIR7xdQF0xrKKrfdmKh2eCE40r2w+Ayu5ba8hfZ6KtN0vnVTyA
 2B8/U/VUlSHOE5Hg4XAUciqG97Sj6vYIvxhSbAp8g59KtWjF9M6HGNrf61BaM3Q3Sz0acbKXJ
 pBMK6aTPO8Vb2cL/uA0EBaRaJ2K5OcE/6YXEqT1DkJmPpeYZD5ae/AljlvaRKlaFdZKWIig1R
 rHuSnKHxzNu+Lw9jqQhIVOXSB0PHio03ekvD7cslFaKKoDUCsohaEgx8bV5YuNRFG0zEKksk+
 83LGUxHE4AQTXcs0fO/H2qKZ0YJTWvu/2YCYRJym8mzmk/rqnt3eF5/x8zPzWW8UhpchRz1s4
 nWEUfvfAJ/f5Ir3eNiIAMRxyvTStXHc8DnAh1TbJM+995fwaDrVPV8xxknqbHkBC/tIr5d92O
 B3UB5rmQte0xU7T83K7khMw+tG+DAvNNoQi+W4F3jgf98OHeT8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine pointed out that I had such a commit message in
https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
and I went on a hunt to figure out how the heck this happened.

Turns out that if there is a fixup/squash chain where the *last* command
fails with merge conflicts, and we either --skip ahead or resolve the
conflict to a clean tree and then --continue, our code does not do a
final cleanup.

Contrary to my initial gut feeling, this bug was not introduced by my
rewrite in C of the core parts of rebase -i, but it looks to me as if
that bug was with us for a very long time (at least the --skip part).

The developer (read: user of rebase -i) in me says that we would want to
fast-track this, but the author of rebase -i in me says that we should
be cautious and cook this in `next` for a while.

Fixes since v2 (thanks, Stefan!):

- Fixed commit message of 2/4: "Thisis" -> "This is".

- Reinstated the order where the `message-squash` file is renamed to
  `message` first, and only if that succeeded, we delete the
  `message-fixup` file.


Johannes Schindelin (4):
  rebase -i: demonstrate bugs with fixup!/squash! commit messages
  rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
  sequencer: leave a tell-tale when a fixup/squash failed
  rebase --skip: clean up commit message after a failed fixup/squash

 sequencer.c                | 94 ++++++++++++++++++++++++++++----------
 t/t3418-rebase-continue.sh | 22 +++++++++
 2 files changed, 93 insertions(+), 23 deletions(-)


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/clean-msg-after-fixup-continue-v3
Fetch-It-Via: git fetch https://github.com/dscho/git clean-msg-after-fixup-continue-v3

Interdiff vs v2:
 diff --git a/sequencer.c b/sequencer.c
 index 881503a6463..b8b72fd540f 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2409,6 +2409,10 @@ static int error_failed_squash(struct commit *commit,
  {
  	const char *amend_type = "squash";
  
 +	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 +		return error(_("could not rename '%s' to '%s'"),
 +			rebase_path_squash_msg(), rebase_path_message());
 +
  	if (file_exists(rebase_path_fixup_msg())) {
  		unlink(rebase_path_fixup_msg());
  		amend_type = "fixup";
 @@ -2418,9 +2422,6 @@ static int error_failed_squash(struct commit *commit,
  		return error(_("could not write '%s'"),
  			     rebase_path_amend_type());
  
 -	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 -		return error(_("could not rename '%s' to '%s'"),
 -			rebase_path_squash_msg(), rebase_path_message());
  	unlink(git_path_merge_msg());
  	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
  		return error(_("could not copy '%s' to '%s'"),
-- 
2.17.0.windows.1.15.gaa56ade3205

