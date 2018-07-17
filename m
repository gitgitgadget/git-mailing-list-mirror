Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379301F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeGQKhH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:37:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:58281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbeGQKhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:37:07 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlleO-1gEQck3Q4u-00ZPq1; Tue, 17
 Jul 2018 12:05:14 +0200
Date:   Tue, 17 Jul 2018 12:04:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807171204080.71@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IwzDBPDnwsrf18H/pfISMMDAX/TM+Y7E5VUa7aKgZuJljuCi82S
 f8vOctJdDFNbQfFCD3ET+sYbRyPuqZHhGlTwuXK/qI9UOxAamygBhxS/LgBZuT9pbMW6hwv
 WRHQsXZTX55RPSc56xZO3kqeA0fcKMgdeUPCrVRQR0RQHb4iFP1PfE+lMb304ZRqzlxZ+ds
 E5GzCRZ0MQQrNaOKrbSaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2fJSOy7C4OU=:CAKG7bPHcZ4urhdSQVjHjh
 V2uHUVOGygmzW+d+mqRbm6H03RKDG7ZhSwUFK83YRxG90NGHItEzGNTqe7ck8N/MgNtee0UXB
 MrULQ7wtvJtRv2lCNAjQt56MQTRmdKCzLHDNmGrHTM3anoLoUGEt8EIGjWMcbVW14yr/2+roY
 qk0Zqud9qE25K0+tCI5HsTCFMYzcVocGJiDUvMdrDl9JYytmXdm2dFZbEBnI2ffQLYVg+qRCK
 Zqv6e0w+twU/XAg8v2MkV056vtV856ER0gttuji/XXn56jz/NzAqKRJwMQaOxkPclB7xy+F3T
 FS0goriIrLtHQSp6YNPmnM+cUp3tjZaKLArb3/cyPVaE0a2A0fhOAWNsJx5VviOB1MKhI3hCm
 mbk3NCTitLdoGnZFZ/amM1ESbmsOmeH27xulJ4YeyUk/jwgBQtkAiGjSrrz+YXFi7iiHrRU3Z
 FX3XlcWGUcdzneHcp85YjUJhiZVuI41jbuoy6ALuigV86Wz9s+R7Z5IHveMbj7MbqjWXaIg9O
 JkHnwA73B/Hfa8SHLkbhJB/AYTnVHKpeDMTvpOWohWhNwCBrSQXdB05Ncunr6dWJu5AWC00y/
 PkfxHYVHLvAlxjDLlf1uFnRWnWt+vcR6eh/kDdY+m8jyDUM276mV73LPGm8uFveT6gzMrnRd3
 BV05zQcYL72HP03gGpvr+yZzWiWE7lWw1NkbYsTic9JqEFzhAGt0/u0BX3ENuIe34YQ7R7V8A
 YJ5pWgFGEXJXQq+LpEVVHKjsqm0TUO1MKsQdmurtctpRzrmD75KJvwpjqVe2ucEorLEG8W0oI
 Xm4A4vC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 30 May 2018, Eric Sunshine wrote:

> Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
> git-branch-diff[1] which computes differences between two versions of a
> patch series. Such a diff can be a useful aid for reviewers when
> inserted into a cover letter. However, doing so requires manual
> generation (invoking git-branch-diff) and copy/pasting the result into
> the cover letter.
> 
> This series fully automates the process by adding a --range-diff option
> to git-format-patch.

Nice!

> It is RFC for a couple reasons:
> 
> * The final name for the 'tbdiff' replacement has not yet been nailed
>   down. The name git-branch-diff is moribund[2]; Dscho favors merging
>   the functionality into git-branch as a new --diff option[3]; others
>   prefer a standalone command named git-range-diff or
>   git-series-diff[4] or similar.

I think this has been settled now: range-diff it is.

> * I have some ideas for future enhancements and want to be careful not
>   to lock in a UI which doesn't mesh well with them (though I think the
>   current UI turned out reasonably well). First, I foresee a
>   complementary --interdiff option for inserting an interdiff-style diff
>   for cases when that style is easier to read or simply more
>   appropriate. Second, although the current patch series only supports
>   --range-diff for the cover letter, some people insert interdiff- or
>   tbdiff-style diffs (indented) into the commentary section of
>   standalone patches. Although this often makes for a noisy mess, it is
>   periodically useful.

Sure.

> This series is built atop js/branch-diff in 'pu'.
> 
> [1]: https://public-inbox.org/git/cover.1525448066.git.johannes.schindelin@gmx.de/
> [2]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1805061401260.77@tvgsbejvaqbjf.bet/
> [3]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet/
> [4]: https://public-inbox.org/git/xmqqin7gzbkb.fsf@gitster-ct.c.googlers.com/
> 
> Eric Sunshine (5):
>   format-patch: allow additional generated content in
>     make_cover_letter()
>   format-patch: add --range-diff option to embed diff in cover letter
>   format-patch: extend --range-diff to accept revision range
>   format-patch: teach --range-diff to respect -v/--reroll-count
>   format-patch: add --creation-weight tweak for --range-diff
> 
>  Documentation/git-format-patch.txt |  18 +++++
>  builtin/log.c                      | 119 ++++++++++++++++++++++++-----
>  t/t7910-branch-diff.sh             |  16 ++++
>  3 files changed, 132 insertions(+), 21 deletions(-)
> 
> -- 
> 2.17.1.1235.ge295dfb56e

Thanks!
Dscho
