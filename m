Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C761DC54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 13:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbiIBNHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 09:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiIBNGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 09:06:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF91157FC
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662122540;
        bh=TT85Q1D+nqgnMsZe78MXwjgEuPQmh2LizpzWbfNGN1s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b6VDxeZqtiVxpPWa3Lk4+Yx8yVq+xkHIiXSOVhlpYWTtd61bRwN1R4Hneu5sqC88c
         HUnPB8la9Xwx1v4HRudvuIumuyd9JcaOf97avbLeAoqo1NBusUwXIydfgjHTrrg9sk
         goYgd4YIk6TbbRfcoJz9QOl6SYBQNoULVngVNtVo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1pDIdg3rKJ-00k6xd; Fri, 02
 Sep 2022 14:42:20 +0200
Date:   Fri, 2 Sep 2022 14:42:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: several messages
In-Reply-To: <f5dbcbf78db127d738c11a1aca416201298426cf.1661992197.git.gitgitgadget@gmail.com>
Message-ID: <9on60586-rr40-onn0-907s-53816r61qn07@tzk.qr>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com> <f5dbcbf78db127d738c11a1aca416201298426cf.1661992197.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k8Pm0Fe3kwND2xDnQ67wOdMB0XrtSW6XDDCrj0crjuuVs/xXSch
 760aw9TFci+o2c/FCVFg2TMl3Zwss53Ev0wuT5bZ1JeOpomlOkpZI3szERBkAOXb2i7rXr+
 4lV1y6JTEjeIZ9t9g6hbDUUsQ94lG2RNfBbrd0Ki66uM5r4PwVskOwT6zpWdheVuUZpIjEG
 BZaRnwluOypw8KGn0gufA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SRFZmafB9LM=:9mGElvtQTZmo5YfS2Lteta
 OguXscIOp7Yuzrg33Nk8n5o8eYdjpPRsw/ybBrkSMx4sq5STOzfztvaPoxpF6iD2esxnV3Kb1
 6j1IwlEJan2WHDkQoKV25h3M7wjb9iSjkiD8PcXnlNkN4dXihnmhxydMfd43w8spwhmtlwmRU
 GE1aWvOcRuNHlRPwCm517WSruCiHaa3z7+BsdyKWFvJA3zPBOM8c03wwFWT+AgkBOYQlKcqQl
 HrkHzHlvqiIeFVVsIIu49K0cjJyvpg1oH0caWbzQy4Xl7cnW84tc5u31cwiPeiT8ZH+3ZgdOe
 +8mm6WsaHgsnGW4mIEHNkcy+Yf6XHTwTdVAcoKaZ1Tr9r6xflhw+kxlbxxSZxAdpZlh4RGO6T
 gmLA1hKSiHnVQnZQirMWxcIqE6SCk3UUEBs9f4eInZ263atnbQnuQxI2qGl4NOIqJuNK+74sh
 pnOjd0ZFU91NXnIsJ+xnMegZnJNEle6P2hqj3EkJF0YU+V4Ttj+PzPeezBo9lG9E11E2Nk98+
 d/umOT/84QST+o35hkxQUfsu5pDNq9WnKOH4JYimzkZktUfp4A+xch5qXjjdOlWH1fyF4ZlOo
 vBBDK1Tsnd/7KXRCVvTh2XVsPYleKo9P6OKaXXMI+fOO+B80XDXRLDy1GnYjDUoaV41DifwuR
 SY+x/hm4pHJwj3hAEQiiDVquOp385smGkXfA8Yf4Cj+NYUJtKT6XQR7v6Xw510QqrNx90zvXU
 XD5IZ4pojBhaOQO25Z0i24EC3aClOEubaBzWt9TFHJhmzRPLtjNx11QMzKQv88S4WBrVIsdus
 TVrv9cpjx9YzdQymmMuB/tLkX0N7xgyxXzcXPO7Wpz+AmzZc+ebrZ1d4idLZ1HYLII85yBl4l
 urOCGMPfpT2+6gAcSaSzDc3nl0MhTCLfXbTt31QLH7sAkpB6wLCJhcBo6Y1aL7JISOrilNwRI
 6B+kDTwUW4e0bGrE7h5R3hmL9UWCttAkMENSIqIHT60RttMuoMBtSRld5qAiCWGcs+oQ6WwoA
 IL9Si2mB0F6IZbvtyqC10dVRfScpx+p76qFR504iigDlnEuJvUKPjR0iJ+qtQbJrA9h41UXsu
 WIzBikZdQY3ylBIBv8Up3H8Mtuwx37qZ3mYqZ0ZUMzY+DsGFHmQndRM/hBPLeWcJGOSiWmeUf
 WgQQDlz3Gm6YTU4jaGi+Y+8lqS
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 1 Sep 2022, Eric Sunshine via GitGitGadget wrote:

>  contrib/buildsystems/CMakeLists.txt           |   2 +-
>  t/Makefile                                    |  49 +-
>  t/README                                      |   5 -
>  t/chainlint.pl                                | 730 ++++++++++++++++++
>  t/chainlint.sed                               | 399 ----------
>  t/chainlint/blank-line-before-esac.expect     |  18 +
>  t/chainlint/blank-line-before-esac.test       |  19 +
>  t/chainlint/block.expect                      |  15 +-
>  t/chainlint/block.test                        |  15 +-
>  t/chainlint/chain-break-background.expect     |   9 +
>  t/chainlint/chain-break-background.test       |  10 +
>  t/chainlint/chain-break-continue.expect       |  12 +
>  t/chainlint/chain-break-continue.test         |  13 +
>  t/chainlint/chain-break-false.expect          |   9 +
>  t/chainlint/chain-break-false.test            |  10 +
>  t/chainlint/chain-break-return-exit.expect    |  19 +
>  t/chainlint/chain-break-return-exit.test      |  23 +
>  t/chainlint/chain-break-status.expect         |   9 +
>  t/chainlint/chain-break-status.test           |  11 +
>  t/chainlint/chained-block.expect              |   9 +
>  t/chainlint/chained-block.test                |  11 +
>  t/chainlint/chained-subshell.expect           |  10 +
>  t/chainlint/chained-subshell.test             |  13 +
>  .../command-substitution-subsubshell.expect   |   2 +
>  .../command-substitution-subsubshell.test     |   3 +
>  t/chainlint/complex-if-in-cuddled-loop.expect |   2 +-
>  t/chainlint/double-here-doc.expect            |   2 +
>  t/chainlint/double-here-doc.test              |  12 +
>  t/chainlint/dqstring-line-splice.expect       |   3 +
>  t/chainlint/dqstring-line-splice.test         |   7 +
>  t/chainlint/dqstring-no-interpolate.expect    |  11 +
>  t/chainlint/dqstring-no-interpolate.test      |  15 +
>  t/chainlint/empty-here-doc.expect             |   3 +
>  t/chainlint/empty-here-doc.test               |   5 +
>  t/chainlint/exclamation.expect                |   4 +
>  t/chainlint/exclamation.test                  |   8 +
>  t/chainlint/for-loop-abbreviated.expect       |   5 +
>  t/chainlint/for-loop-abbreviated.test         |   6 +
>  t/chainlint/for-loop.expect                   |   4 +-
>  t/chainlint/function.expect                   |  11 +
>  t/chainlint/function.test                     |  13 +
>  t/chainlint/here-doc-indent-operator.expect   |   5 +
>  t/chainlint/here-doc-indent-operator.test     |  13 +
>  t/chainlint/here-doc-multi-line-string.expect |   3 +-
>  t/chainlint/if-condition-split.expect         |   7 +
>  t/chainlint/if-condition-split.test           |   8 +
>  t/chainlint/if-in-loop.expect                 |   2 +-
>  t/chainlint/if-in-loop.test                   |   2 +-
>  t/chainlint/loop-detect-failure.expect        |  15 +
>  t/chainlint/loop-detect-failure.test          |  17 +
>  t/chainlint/loop-detect-status.expect         |  18 +
>  t/chainlint/loop-detect-status.test           |  19 +
>  t/chainlint/loop-in-if.expect                 |   2 +-
>  t/chainlint/loop-upstream-pipe.expect         |  10 +
>  t/chainlint/loop-upstream-pipe.test           |  11 +
>  t/chainlint/multi-line-string.expect          |  11 +-
>  t/chainlint/nested-loop-detect-failure.expect |  31 +
>  t/chainlint/nested-loop-detect-failure.test   |  35 +
>  t/chainlint/nested-subshell.expect            |   2 +-
>  t/chainlint/one-liner-for-loop.expect         |   9 +
>  t/chainlint/one-liner-for-loop.test           |  10 +
>  t/chainlint/return-loop.expect                |   5 +
>  t/chainlint/return-loop.test                  |   6 +
>  t/chainlint/semicolon.expect                  |   2 +-
>  t/chainlint/sqstring-in-sqstring.expect       |   4 +
>  t/chainlint/sqstring-in-sqstring.test         |   5 +
>  t/chainlint/t7900-subtree.expect              |  13 +-
>  t/chainlint/token-pasting.expect              |  27 +
>  t/chainlint/token-pasting.test                |  32 +
>  t/chainlint/while-loop.expect                 |   4 +-
>  t/t0027-auto-crlf.sh                          |   7 +-
>  t/t3070-wildmatch.sh                          |   5 -
>  t/test-lib.sh                                 |  12 +-
>  73 files changed, 1439 insertions(+), 449 deletions(-)
>  create mode 100755 t/chainlint.pl
>  delete mode 100644 t/chainlint.sed
>  create mode 100644 t/chainlint/blank-line-before-esac.expect
>  create mode 100644 t/chainlint/blank-line-before-esac.test
>  create mode 100644 t/chainlint/chain-break-background.expect
>  create mode 100644 t/chainlint/chain-break-background.test
>  create mode 100644 t/chainlint/chain-break-continue.expect
>  create mode 100644 t/chainlint/chain-break-continue.test
>  create mode 100644 t/chainlint/chain-break-false.expect
>  create mode 100644 t/chainlint/chain-break-false.test
>  create mode 100644 t/chainlint/chain-break-return-exit.expect
>  create mode 100644 t/chainlint/chain-break-return-exit.test
>  create mode 100644 t/chainlint/chain-break-status.expect
>  create mode 100644 t/chainlint/chain-break-status.test
>  create mode 100644 t/chainlint/chained-block.expect
>  create mode 100644 t/chainlint/chained-block.test
>  create mode 100644 t/chainlint/chained-subshell.expect
>  create mode 100644 t/chainlint/chained-subshell.test
>  create mode 100644 t/chainlint/command-substitution-subsubshell.expect
>  create mode 100644 t/chainlint/command-substitution-subsubshell.test
>  create mode 100644 t/chainlint/double-here-doc.expect
>  create mode 100644 t/chainlint/double-here-doc.test
>  create mode 100644 t/chainlint/dqstring-line-splice.expect
>  create mode 100644 t/chainlint/dqstring-line-splice.test
>  create mode 100644 t/chainlint/dqstring-no-interpolate.expect
>  create mode 100644 t/chainlint/dqstring-no-interpolate.test
>  create mode 100644 t/chainlint/empty-here-doc.expect
>  create mode 100644 t/chainlint/empty-here-doc.test
>  create mode 100644 t/chainlint/exclamation.expect
>  create mode 100644 t/chainlint/exclamation.test
>  create mode 100644 t/chainlint/for-loop-abbreviated.expect
>  create mode 100644 t/chainlint/for-loop-abbreviated.test
>  create mode 100644 t/chainlint/function.expect
>  create mode 100644 t/chainlint/function.test
>  create mode 100644 t/chainlint/here-doc-indent-operator.expect
>  create mode 100644 t/chainlint/here-doc-indent-operator.test
>  create mode 100644 t/chainlint/if-condition-split.expect
>  create mode 100644 t/chainlint/if-condition-split.test
>  create mode 100644 t/chainlint/loop-detect-failure.expect
>  create mode 100644 t/chainlint/loop-detect-failure.test
>  create mode 100644 t/chainlint/loop-detect-status.expect
>  create mode 100644 t/chainlint/loop-detect-status.test
>  create mode 100644 t/chainlint/loop-upstream-pipe.expect
>  create mode 100644 t/chainlint/loop-upstream-pipe.test
>  create mode 100644 t/chainlint/nested-loop-detect-failure.expect
>  create mode 100644 t/chainlint/nested-loop-detect-failure.test
>  create mode 100644 t/chainlint/one-liner-for-loop.expect
>  create mode 100644 t/chainlint/one-liner-for-loop.test
>  create mode 100644 t/chainlint/return-loop.expect
>  create mode 100644 t/chainlint/return-loop.test
>  create mode 100644 t/chainlint/sqstring-in-sqstring.expect
>  create mode 100644 t/chainlint/sqstring-in-sqstring.test
>  create mode 100644 t/chainlint/token-pasting.expect
>  create mode 100644 t/chainlint/token-pasting.test

This looks like it was a lot of work. And that it would be a lot of work
to review, too, and certainly even more work to maintain.

Are we really sure that we want to burden the Git project with this much
stuff that is not actually related to Git's core functionality?

It would be one thing if we could use a well-maintained third-party tool
to do this job. But adding this to our plate? I hope we can avoid that.

Ciao,
Dscho
