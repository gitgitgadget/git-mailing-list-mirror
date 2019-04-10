Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A72C20248
	for <e@80x24.org>; Wed, 10 Apr 2019 21:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDJVvs (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 17:51:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:47077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfDJVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 17:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554933103;
        bh=YrV99MwMFSB8OXS35/k4qBrFKNqmSG8r7dAWagG4Pow=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Do8iELBlbmg4sDSAShWlbSQKnnBLJo2yAORirPDjET8PNmgofbR04On3uqy3BkEly
         dqCCX3NkTvBwtcvUBLGzw1ILiaqe+FrqIxubxGMWQMutvb724vXg9tVEkzMesQLaxQ
         VJtEBfRZdnUzeCZ2fK9Q7bjH1VyAZgGjj0L6xoWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFAaV-1h7SR206sF-00GGjC; Wed, 10
 Apr 2019 23:51:43 +0200
Date:   Wed, 10 Apr 2019 23:51:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: nd/switch-and-restore, was Re: What's cooking in git.git (Apr 2019,
 #02; Wed, 10)
In-Reply-To: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904102348500.41@tvgsbejvaqbjf.bet>
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vDRFOrSRfkS7BjlItRRL5q/oGvrsTONkB43iytyz6jFi5VnBzVl
 wbrnrenbl+D7UZGmudjGNSE7cNfS1BCuDftoit5a98cmoZyT0zy3mY+kpla95sbJ4egK3Ww
 C73gdN1vQo1YsQ/UINoo1UMJOb5XIQAR7X477i7FZJ4KjDOCvItZQcpqEfn7LO7mesMYCTO
 qEIdxZXHgtFutsFEC1jQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rsmnjSAWcRk=:vw0b41L6tr8Q8MzOlINoZS
 OzFUT7COp1Y4KuaN5LVMw4sIHFslWeRbE06q/tFUGTjyUTmlUQNbB25YupTgdJatMJUnr2f1Y
 VQxiZ5oxVxpx5NA310keW53rfSTJcqsOQ7rvzLy8HmcuLB3yd2tmz8kEA1o6erQNdtPsotvHV
 VHMTRMZsIY3g0zG1PcKE+woM+AoNmcquQW6rs085E0hBE+FSd8ip+ZPOf8SfwtldBTrM7iROb
 nFEXQ4e1q6XQUFTlauoZUWLnmyoRlcoPlniw9iJagoe6FVp4t/xilzH1i8BqkeEZG1WXWfvZw
 qezcHxVC2ajHA2Swp/gzKHp7AsOYrR/jV5Zrbs6L+BhYbqeY1FHzBaNaOr3+mhOhBG1l7KVpi
 PoPefZjxIG/mpliRoQICk32IVVNLJ+LIN0VOA/P4Udl0gVe2fKWg6h8+zpJk8XUIV9sUcOKa7
 lfSyFfptnjqRpExyajmJQOFTFHl+iY8YHtZfVkF9+8/1avUozMMZRjhJ97IIKkMei+Gw9ol3B
 ZSoTTWUHKuNb2Iv7n5xSijbp34B4qY+FsC22HQ0dfgD2VE5Uy+u4GGkUZL5hH1zJeM1ElkdhS
 goP8yL4v18le9ncO2uzYsUGH8bxXZ3+qdqNLw17RaboGFAcFHZgy2kSYZWLsVQNy8wBrRAOqw
 UVqGXKjkWvN977kxVWCcLlhS5BN3UQxrMXh1VG1IVTG4WdlJoD8qNuptLeYNdCXjs3v57p5Td
 dHtkRXaxDNZwm1pdqCyAbqInmCk44u/pTnydMrflOr2lZBNVNvHC2rrN4Kr2hncFFw2QhmJep
 vEFUiP6TmhWpxSeIPclt+LsH7dk5b4O6QUD0h91qTj4AqEsnkQ1HRvvj1WAwcIKRuSgcixlkS
 +QLfpcM2JGtA6nnT8REakMGxeO6I9jLsOgNfObQLOuqCSrjC6mnbCyq3juKyBAT6A5DWEke3B
 vRJr2H+KEig==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Apr 2019, Junio C Hamano wrote:

> * nd/switch-and-restore (2019-04-02) 39 commits
>  - doc: promote "git restore"
>  - completion: support restore
>  - SQUASH??? move -p test to 2071 from 2070
>  - t: add tests for restore
>  - restore: support --patch
>  - restore: default to --source=3DHEAD when only --index is specified
>  - restore: add --worktree and --index
>  - checkout: factor out worktree checkout code
>  - restore: disable overlay mode by default
>  - restore: make pathspec mandatory
>  - restore: take tree-ish from --source option instead
>  - checkout: split part of it to new command 'restore'
>  - doc: promote "git switch"
>  - completion: support switch
>  - t: add tests for switch
>  - switch: make --orphan switch to an empty tree
>  - switch: reject if some operation is in progress
>  - switch: no worktree status unless real branch switch happens
>  - switch: implicit dwim, use --no-guess to disable it
>  - switch: add short option for --detach
>  - switch: only allow explicit detached HEAD
>  - switch: reject "do nothing" case
>  - switch: stop accepting pathspec
>  - switch: remove -l
>  - switch: add --discard-changes
>  - switch: better names for -b and -B
>  - checkout: split part of it to new command 'switch'
>  - checkout: split options[] array in three pieces
>  - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
>  - checkout: make "opts" in cmd_checkout() a pointer
>  - checkout: factor out some code in parse_branchname_arg()
>  - checkout: keep most #include sorted
>  - checkout: inform the user when removing branch state
>  - checkout: advice how to get out of detached HEAD mode
>  - t: rename t2014-switch.sh to t2014-checkout-switch.sh
>  - git-checkout.txt: fix monospace typeset
>  - doc: document --overwrite-ignore
>  - git-checkout.txt: fix one syntax line
>  - git-checkout.txt: spell out --no-option
>
>  Two new commands "git switch" and "git restore" are introduced to
>  split "checking out a branch to work on advancing its history" and
>  "checking out paths out of the index and/or a tree-ish to work on
>  advancing the current history" out of the single "git checkout"
>  command.
>
>  cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
>  cf. <20190308101655.9767-1-pclouds@gmail.com> (restore v1)

This one fails the CI for almost a month already, still needing this
squashed in:

=2D- snipsnap --
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index a667a5ced4ec..1faeee50593e 100644
=2D-- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -144,7 +144,7 @@ $ git restore .
 ------------

 or to restore all working tree files with 'top' pathspec magic (see
-linkgit::gitglossary[7])
+linkgit:gitglossary[7])

 ------------
 $ git restore :/

