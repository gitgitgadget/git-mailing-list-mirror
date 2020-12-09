Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487B1C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B423B51
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgLIOKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:10:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:54295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732758AbgLIOKm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607522945;
        bh=pTmhaJ0RFM+XSeIXCqJYU0sRbtTqbhyOPIx6STyyHYo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FJ7P2QSMHNj/30KA3t4kDoUhvxRwFqrS1Mrau8PAPiHRT7RgO3L7cLBNySOT2IsKk
         zI2aGzhqnmmYvW6gIn9F7KaE3hK/asKeGnzMW5+z5DvwxuuH3TJPEb6Th/dtZD8E4P
         Ijd/iUDerXB4XAy4AYQnEB+8Xi3cXwvN0WcgqHds=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1kAd4G1Sg1-00fAgc; Wed, 09
 Dec 2020 15:09:05 +0100
Date:   Wed, 9 Dec 2020 15:09:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec 2020,
 #01; Tue, 8)
In-Reply-To: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:flIep3Vf3A5T83VH+NcSD/x182CqZ64sG+lzOabql19ayayEOPQ
 f6uOiFak2hIof6ePleTszPSkHvC66TcSyQhRWWdr0odv/2PzUAMAKlPCWG2e2HL9xWvF1mF
 F+C9W55V1yNt5w8S4fuw/M0X+s60IcZnmsl8B0TuHu28Z1XIkcF8r1neH/xkQthyARB6akY
 zxlzuVDAOC0WopSqN+YCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:11Kmj4VfqcM=:+ghefbFpqpuDJ55nkpdlEw
 QANtl27z83L3b4DIzlByeG5f20BebXClHfIg7bLS4wfI6RUWRsW70kyskjvpeo+lNZrOhmsvB
 ljcO8wF8JUqfIz9xdflL3beeY+VXS9Ibel6XaKWCj22AVh8WuSexqtLc1FuXmDE6NjDKUY07h
 V2EjzFDW7QNy1HYPfROEEK8Xvu3tLUUJmPRS4H5sh0gdhgwTvMtrXufU2rxw20IykSJT8i9Vp
 CkTt10K6dppqLn+XlCaH85WxPBN32EpqAvQv0k/WdmKzKef1N77AQdlIbeCFVf7KLBgyusSRM
 sqATKYI4POaITs9YO0rtvTxL36lRE2CPJVND5dMSrd2YuAhkvD7oJ9cdxrlLLxMoYme+/ictT
 wT/86IMjd8J8n33niDB007tv3WdhGC5Ewcr7uhilCL23ZnB0mK/UFyeiZNM/hXel2fvxmvwIe
 gip0aAIpIe6HwmC7CfNkliVYr0HHJic7kX6zvn0RRP6+OUFFD/ZYr0Hq1bfCgfRfxMq6IR84/
 yYJVpBHvRLIuRfGojL6mS2qUygJol0zcmJV0HZ7S/rMOo9sXBNg6Ew01e3W+O0KA0skuDIHX3
 xHWktbGVObZpMfiVhA3AdNgezzmZPSDUgzk6fSqrvsZ8nd9IGegEEbxsTohvqkP+Kxv0W0v2U
 F/HHl4oqp7w870/ggK1XDNfAA3ZFmkxXahXzJ9opohMcMt5OeqydUevmzcDMXsG/FOcHGkXTN
 DTW/mclgN0lHuwD4DnMLTxCiDzuuFlzXXSp1mh727/VJyncTtEWs8GNKt2p9WWgb6IfEGSQVa
 +VGBCYgDoeqFQ0U7c8txWhwLcy2JytHOqImhGEr6Pm3OhcBLLknU9Wu/g5FjAl8RSTNsqJkMt
 OlUaE+EdlyNV3KvPSxyUIaxdBzbn7Ya3w51T8j0o4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Dec 2020, Junio C Hamano wrote:

> * fc/pull-merge-rebase (2020-12-08) 19 commits
>  - future: pull: enable ff-only mode by default
>  - pull: advice of future changes
>  - pull: add pull.mode=3Dff-only
>  - pull: add pull.mode
>  - pull: trivial memory fix
>  - test: pull-options: revert unnecessary changes
>  - test: merge-pull-config: trivial cleanup
>  - pull: move configurations fetches
>  - rebase: add REBASE_DEFAULT
>  - pull: show warning with --ff
>  - pull: introduce --merge option
>  - pull: trivial whitespace style fix
>  - pull: display default warning only when non-ff
>  - pull: move default warning
>  - pull: trivial cleanup
>  - pull: cleanup autostash check
>  - pull: refactor fast-forward check
>  - pull: improve default warning
>  - doc: pull: explain what is a fast-forward
>
>  When a user does not tell "git pull" to use rebase or merge, the
>  command gives a loud message telling a user to choose between
>  rebase or merge but creates a merge anyway, forcing users who would
>  want to rebase to redo the operation.  Fix this by (1) tightening
>  the condition to give the message---there is no reason to stop or
>  force the user to choose between rebase or merge if the history
>  fast-forwards, and (2) failing the operation when the history does
>  not fast-forward, instead of making a merge, in such a case.

Despite what the commit message of the tip commit says, it is not "time to
flip the switch and make ff-only the default" because it breaks our very
own test suite left and right. See for yourself:

https://github.com/gitgitgadget/git/runs/1521231966?check_suite_focus=3Dtr=
ue
claims that a whopping 120 (!!!) test cases fail. Here's the exact list:

Test Summary Report
=2D------------------
t4013-diff-various.sh                            (Wstat: 256 Tests: 195
Failed: 84)
  Failed tests:  1, 49-62, 66-68, 70-84, 94-109, 113-117
                120-123, 131-134, 137-138, 140-143, 145-146
                164-168, 182-186, 188-191
  Non-zero exit status: 1
t5524-pull-msg.sh                                (Wstat: 256 Tests: 3
Failed: 2)
  Failed tests:  2-3
  Non-zero exit status: 1
t5521-pull-options.sh                            (Wstat: 256 Tests: 20
Failed: 2)
  Failed tests:  12, 16
  Non-zero exit status: 1
t5553-set-upstream.sh                            (Wstat: 256 Tests: 19
Failed: 6)
  Failed tests:  11-14, 16-17
  Non-zero exit status: 1
t5520-pull.sh                                    (Wstat: 256 Tests: 81
Failed: 8)
  Failed tests:  16, 33-39
  Non-zero exit status: 1
t5604-clone-reference.sh                         (Wstat: 256 Tests: 33
Failed: 4)
  Failed tests:  13-16
  Non-zero exit status: 1
t6409-merge-subtree.sh                           (Wstat: 256 Tests: 12
Failed: 3)
  Failed tests:  9, 11-12
  Non-zero exit status: 1
t6417-merge-ours-theirs.sh                       (Wstat: 256 Tests: 7
Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
t6402-merge-rename.sh                            (Wstat: 256 Tests: 46
Failed: 8)
  Failed tests:  2-8, 11
  Non-zero exit status: 1
t7603-merge-reduce-heads.sh                      (Wstat: 256 Tests: 13
Failed: 1)
  Failed test:  3
  Non-zero exit status: 1
Files=3D915, Tests=3D22158, 448 wallclock secs ( 5.63 usr  1.64 sys + 555.=
46
cusr 190.71 csys =3D 753.44 CPU)
Result: FAIL

Given that not even our very own test suite is well-suited to this change,
I rather doubt that this is a safe thing to do.

In the _least_, the patch series should put in the effort to show just how
much work it is to adjust the test suite to let it pass again. This would
also give an indication how much work we impose on our users by that
ff-only change in behavior.

Ciao,
Dscho
