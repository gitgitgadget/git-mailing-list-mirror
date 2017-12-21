Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2801F424
	for <e@80x24.org>; Thu, 21 Dec 2017 15:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdLUPCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 10:02:46 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:44089 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdLUPCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 10:02:44 -0500
Received: by mail-pf0-f180.google.com with SMTP id m26so14034225pfj.11
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:references:in-reply-to:date
         :mime-version:content-transfer-encoding;
        bh=u+3jTNi23V8IOsbySLnkEiWlyJjY2lCwml9rfgqCIVs=;
        b=VGNpcdmBOqU/mh68sHDZ1xJOcQ/Tj/ynKmEnqbGMaVldITA6rGevZiBs2lu12PLB11
         YSw0KJXL1cTk9E6HPxxbcNjdZGPGnhGl7fs2c85PCoW2eQEfM7eYo+loVe4VvM+Bk+y/
         mykGJ/VjXTfjmVoZqZVAxJZP8gcuAcAmjADyCT/cBBp3avbm2kKpNNemq3mH929VAyg8
         5HEbZDKeK5q2peoXVcKOt9k8UgohS18yHZ6ZPxnA4QEgy2HctSufVhrQxLllbPbCVn+3
         gHXUqcC10L47J/qtrAQBWhNbiEMBoz16hNulaUVtwIOK8iuau9DZuhsyLKrpoBfv0RAR
         YQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:references
         :in-reply-to:date:mime-version:content-transfer-encoding;
        bh=u+3jTNi23V8IOsbySLnkEiWlyJjY2lCwml9rfgqCIVs=;
        b=W37BcWWGJxHsU0reBBcXQmq2D6mR0SOklnBL4Y6lo+TyuGl387Fh/N6g6V9jXNKz/x
         1WXOAYzSfgHqhRriDSRH577vmiqk5FAIuYcsiWbwNrchIbBOqOKpC9njufVN6HUtiXAX
         3+AXEBETqsn1FsIRVL2ZhfxoasKdcmMfCnoMjJpxnudP++ZYQPBYtYjB3UYKK1dxfrVA
         A79k4RHWxJmheZZ1oi1unIJyOKDXL5ql8WtK/kl6ysrAEYZ/yZ5tv9/D/2U/s4pDFyJ4
         M4xNeIByP0A6wlCKwbCs/fTmi3RpTaql00+sfcu9NdgfjQesHN8M20qh3+7HfIyifwpp
         kw1Q==
X-Gm-Message-State: AKGB3mIPG/12BWVPlj+FlqJy8LSMpYCYeBwO3AaDr8RNcDYvnVSQ5hSQ
        +S4PQ6aUTiZjQQ6jovJ0wXg=
X-Google-Smtp-Source: ACJfBouQkLWwXHegNiZUO0LOfILZtyPn854jbkWZeHqSyF6/AySKFI1QVHWS5fVdj5Qtqdwdj1nPDA==
X-Received: by 10.99.122.85 with SMTP id j21mr9649954pgn.277.1513868563348;
        Thu, 21 Dec 2017 07:02:43 -0800 (PST)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id d2sm41266563pfe.164.2017.12.21.07.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Dec 2017 07:02:41 -0800 (PST)
Message-ID: <1513868549.3546.2.camel@gmail.com>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
         <20171213114621.30250-1-phillip.wood@talktalk.net>
         <1513794792.9785.2.camel@gmail.com>
         <18737953.1042351513802399608.JavaMail.defaultUser@defaultHost>
In-Reply-To: <18737953.1042351513802399608.JavaMail.defaultUser@defaultHost>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 21 Dec 2017 20:32:29 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 21 December 2017 02:09 AM, phillip.wood@talktalk.net wrote:
> 
> 
>     Hi Kaartic
> 
>     I'm replying off list as I've only got access to webmail at the
>     moment.

No issues brought the CCs including the list to ensure we don't miss things.


>     Are you able to do a backtrace with debugging symbols
>     please, I'm finding it hard to glean anything from the backtrace
>     here. 

That's confusing, I already had the following in my `config.mak` while 
compiling,


DEVELOPER=1
DEVELOPERS=1
CFLAGS += -g -O2
CFLAGS += -DFLEX_ARRAY=2048

NO_GETTEXT=1
prefix=/home/$(USER)/.local
#CFLAGS += -Wno-unused-value


As you can see the `-g` flag is there in CFLAGS.

If this output doesn't give much sense could you be specific about what 
output you want i.e., by mentioning the command, showing a sample etc., 
I'm not sure how to go about debugging with "git rebase" as it's a script.


> Also does it definitely bisect to this patch or the merge of
>     this branch?
> 

"git bisect" speaking,

28d6daed4f119940ace31e523b3b272d3d153d04 is the first bad commit
commit 28d6daed4f119940ace31e523b3b272d3d153d04
Author: Phillip Wood <phillip.wood@dunelm.org.uk>
Date:   Wed Dec 13 11:46:21 2017 +0000

    sequencer: improve config handling
    
    The previous config handling relied on global variables, called
    git_default_config() even when the key had already been handled by
    git_sequencer_config() and did not initialize the diff configuration
    variables. Improve this by: i) loading the default values for message
    cleanup and gpg signing of commits into struct replay_opts;
    ii) restructuring the code to return immediately once a key is
    handled; and iii) calling git_diff_basic_config(). Note that
    unfortunately it is not possible to return early if the key is handled
    by git_gpg_config() as it does not indicate to the caller if the key
    has been handled or not.
    
    The sequencer should probably have been calling
    git_diff_basic_config() before as it creates a patch when there are
    conflicts. The shell version uses 'diff-tree' to create the patch so
    calling git_diff_basic_config() should match that. Although 'git
    commit' calls git_diff_ui_config() I don't think the output of
    print_commit_summary() is affected by anything that is loaded by that
    as print_commit_summary() always turns on rename detection so would
    ignore the value in the user's configuration anyway. The other values
    loaded by git_diff_ui_config() are about the formatting of patches so
    are not relevant to print_commit_summary().
    
    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 bbd487cc285ae12cefb97a9661de4ff27d182727 9460ac528bf68f331088412f62e5d6a39305854b M	builtin
:100644 100644 99452a0e89777999418c116386f924be396ed04a 7051b20b76292e3b539875f0dc38108a734d2164 M	sequencer.c
:100644 100644 77cb174b2aaf3972ebb9e6ec379252be96dedd3d 3a5072c2ab9088c237b83d92deae3c801289e543 M	sequencer.h


FWIW, I started the bisection with `v2.11.0`  as good (because "git
rebase -i HEAD~10 worked there) and the tip of `next` (cfbfd45ee (Sync
with master, 2017-12-19)) as bad.

Here's the bisect log for a shorter range of bisection (which was
possible after I discovered the bad commit in the previous bisect)

git bisect start
# bad: [cfbfd45ee6e49007fdeb00008904064ba98f65e0] Sync with master
git bisect bad cfbfd45ee6e49007fdeb00008904064ba98f65e0
# good: [a4212f7ebd7158a1e237d776fb4bbd7a295d0bda] Merge branch 'pw/sequencer-in-process-commit' into next
git bisect good a4212f7ebd7158a1e237d776fb4bbd7a295d0bda
# good: [bdae4af87053490adad2dc9fb184d6d050d46a4c] Merge branch 'sg/setup-doc-update'
git bisect good bdae4af87053490adad2dc9fb184d6d050d46a4c
# bad: [6d12e08217360cfc042ec484129771f73ad7b97f] Merge branch 'rs/strbuf-read-once-reset-length' into next
git bisect bad 6d12e08217360cfc042ec484129771f73ad7b97f
# bad: [1b791d2503742b060f91b8159b85c06335634bd8] Merge branch 'ab/simplify-perl-makefile' into next
git bisect bad 1b791d2503742b060f91b8159b85c06335634bd8
# bad: [abfed699db9f0f0e6f03f5ee3e9d137944ba4216] Merge branch 'sb/clone-recursive-submodule-doc' into next
git bisect bad abfed699db9f0f0e6f03f5ee3e9d137944ba4216
# bad: [ec4d2b9c843b8b338ffa8906eea70095b3098c1e] Merge branch 'pw/sequencer-in-process-commit' into next
git bisect bad ec4d2b9c843b8b338ffa8906eea70095b3098c1e
# good: [5279b80103bde3ec5d6108fa8f43de2017668039] Merge branch 'tb/check-crlf-for-safe-crlf' into next
git bisect good 5279b80103bde3ec5d6108fa8f43de2017668039
# bad: [28d6daed4f119940ace31e523b3b272d3d153d04] sequencer: improve config handling
git bisect bad 28d6daed4f119940ace31e523b3b272d3d153d04
# first bad commit: [28d6daed4f119940ace31e523b3b272d3d153d04] sequencer: improve config handling

-- 
Kaartic
