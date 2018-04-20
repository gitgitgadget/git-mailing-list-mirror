Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0DC11F404
	for <e@80x24.org>; Fri, 20 Apr 2018 20:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeDTUFJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 16:05:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:54841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbeDTUE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 16:04:58 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0bo2-1eHEwF1hPS-00uosP; Fri, 20
 Apr 2018 22:04:53 +0200
Date:   Fri, 20 Apr 2018 22:04:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit
 messages
In-Reply-To: <CAGZ79kZONQ_xuDYJ5Z8cUnF0odwz3+Sh+ST6g+5Tefav-QXEBw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804202149260.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de> <CAGZ79kZONQ_xuDYJ5Z8cUnF0odwz3+Sh+ST6g+5Tefav-QXEBw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4s61AQEWh24ZFB0UGU4rvq7YTjmhtchHpH+nhNIQo0a9yNy1ntw
 PaNFh2Pfy5Fd1Rdqv0qyBYe9ohkUiET+b69hi7UcvOVHBSbV6XzazC4gySfFuJ2dZqVtlpa
 FT+wqGYQ+VEOA1JE37dPDuDKVQZ9TL02bwlhJKmfb6hmvw2Wy0G/qzgiaCOSdthOItwbgEP
 mwN1TM9in/j4eB6lu9Egw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mOUfHxpYr1s=:BgshyaRHSj6w3Np8kY0zTl
 AHRdhqopmZKFLA5qu4QZkhgXzTzhTo0RHA1aI0Du4ZKd1eOiPpHGoV2yARqKKc2LWxq2NTsdg
 R9KKD5x0rT/WfHWRu2o77zR0fOKK6BuOuBGPTEIn+mOOVAwCv0AVQ0qDnfYn2hXiPyqSZj8Dn
 zgjKxrJJIZCyjhZG3q4+NjfnxE6iXTt2I68qVFdxwqLU1ozS863sIMK/5XyTWHH0TdVHACwBN
 uj+LZj/75U+YTCmkK78kElvyfLe2DEp8yGJii35KuPqH7SfEYWEFoY5LlFo0cpYXu4MoNBYtE
 GQJwq92FH2Uc+UJ0ScYQ67ss775WyeGQrVJNA6DQEvJd9ci+GClochYalmBn52w1v+P7Sf4YZ
 YELf8mNC7EMOObcdHMF6Ku8l2eQy/OU5btO/pouC4EgJj1OmgVTO/G3ynTy4kYEuitecy8mHF
 RU53DsSxziYYjjRb9hjrFBuXXsF5chkeTVC0gEZ6RZT1pAHKc3EyoxZyPDKFl6kXtTw5sEuYS
 o10inzjqn7UdNwLKOTjdLTlaoG5Q/V059KEnFHoNYKsr/xedV7q5kLj2btJM0pP0mFRhTMwfo
 kvoGGxFar6fRmxBUmsQ6fmmOAbQ2vY7khrs9pfALRJdu0MvZQxi3iI9bjxJ1LvIXMBdCcd75R
 7FrvjVL4+l8JIbQ7StVd3yg5Fav8yN+z2ohMI6El+3PYi3kzqB/NK9QAdQO4ViX3ExRnS8C+Q
 WqFnzeP0Y7Y5a+nQz7BIyyLa12jOmBN4PHC5V3ggqbW1B+DRwkcgQzk01n3+RKc1GPiqw5cX3
 lxGPIyFkE3UO6gnnY7M+sDeZ4SfETGLce1bjzJyn5x+9sqRt7E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 20 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 20, 2018 at 5:17 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When multiple fixup/squash commands are processed and the last one
> > causes merge conflicts and is skipped, we leave the "This is a
> > combination of ..." comments in the commit message.
> >
> > Noticed by Eric Sunshine.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t3418-rebase-continue.sh | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > index 9214d0bb511..b177baee322 100755
> > --- a/t/t3418-rebase-continue.sh
> > +++ b/t/t3418-rebase-continue.sh
> > @@ -88,6 +88,27 @@ test_expect_success 'rebase passes merge strategy options correctly' '
> >         git rebase --continue
> >  '
> >
> > +test_expect_failure '--continue after failed fixup cleans commit message' '
> > +       git checkout -b with-conflicting-fixup &&
> > +       test_commit wants-fixup &&
> > +       test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
> > +       test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
> > +       test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
> > +       test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
> > +               git rebase -i HEAD~4 &&
> > +
> > +       : now there is a conflict, and comments in the commit message &&
> > +       git show HEAD >out &&
> > +       grep "This is a combination of" out &&
> 
> test_i18n_grep ?

Funny thing is: I tested this with GETTEXT_POISON=1, and it succeeded. So
I dug deeper why: I never understood that this is a *build* option. I
always thought that would be a test-time option... Oh well ;-)

> > +
> > +       : skip and continue &&
> > +       git rebase --skip &&
> > +
> > +       : now the comments in the commit message should have been cleaned up &&
> > +       git show HEAD >out &&
> > +       ! grep "This is a combination of" out
> 
> same

Will work on a fix. A brief test shows, however, that it is not quite as
easy as s/grep/test_i18ngrep/, something more seems to be broken.

Will keep you posted,
Dscho
