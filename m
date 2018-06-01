Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804781F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 08:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeFAI2M (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 04:28:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:56053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeFAI2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 04:28:09 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJBEo-1fRQJ42ArS-002oCm; Fri, 01
 Jun 2018 10:28:04 +0200
Date:   Fri, 1 Jun 2018 10:28:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <xmqqmuwszcs4.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806011023430.82@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <xmqqvabh1ung.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805211144340.77@tvgsbejvaqbjf.bet> <xmqqmuwszcs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UEnxPoNL9d2/p9+Ozgeugdws8wfAO8o4YgowegG5WvLQmDu21JO
 zfatUzVNuSJFNjMuulKBi6bWxWBbKGBxe66UuRolgP9pWw/idSpF1wFCPMD3z4kUN1Za+UI
 VsP7bJH9dmfI0AxAM4d0tmY0llkORldPPwjWxnMHEcwKzAq9NQh/zXgriWxTPqUoHv833Tx
 kAiNP091DO2beVG+c/Rig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2yIXt8E9ono=:zDXYxIpl5jJIUYtZrH4/7T
 JrTl+4/dSuj0qQ+O6k8zKWiyYoyo/DSn6+p1ikpjoLHypTEANaFhYr3AtmK4ZgzqUtdGcFV4c
 Ak+H8TBMV9qipe4Tjm6rsSitS6ilGi07eMLddGxsYstyLVK2e8sJmjYr1BcqC0WQKZH1xs5Fr
 7WCiPj0h/4QntoewCBMNupIcGjEaQDapIbqzNZ5egO4soS+CvOUqmLTKGHmWQJDuIbl1Ueym5
 1tMnwstE6kjxA8pvuXUvhuNqxHHXMWNpyDJAMuiw3kGbo5ejMY7OWHK19WuzZ4JwDI1yCt6eI
 xsnlz00hxsNkVjzJVjNfLPLMVNvG75dSRe/l+B7Hh8sWJazsu0e2dGyfc1mO5/di2aPjeQHQi
 GX7/BZAvv0igA0OiTthOHRdKOnre3cY+0sDrQWMMb5rlL7LzFAp8cTnzskvSCNA16E5ZkTt0l
 CSfNnaAOeQUJkgUNiWCR7cBP4YXQi58xTKLvw8DltMqzw+ykc+ZoDuONqtJdJbnlDYqfwN7a8
 9xDTO73z1ZfCyB+hhwKcDB1E+95tZB/425PBQ9TKQY3m9yeLsh+5EgngQQvNXobA7/E87yZhL
 KvvYV6Tu28Xk3z0Xe/4Jdbcd0HrmWhLE/AwWGZwNmNCNvG1c0NhIA1lMQ1WMp75ztaA2nCj87
 2ZKkV4g7abeCVPCtUlLharhpTw3F6qV8NnZcBBEgLXh/uJ665Y4o8/DAPrpl8XbAAgdc8KuMa
 f1aGkvQIm5xp6+1VEf74UHS8ayMQ6zfugInm4OqGvArPRJfBUusqr2K1YlypP3ApfhmAzuhMY
 Ys+5KA9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 22 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> In the picture, the three pre-context lines that are all indented by
> >> a HT are prefixed by a SP, and that is prefixed by a '+' sign of the
> >> outer diff.
> >
> > Yep, that's exactly it.
> >
> > The way tbdiff did it was to parse the diff and re-roll the coloring on
> > its own. I am not really keen on doing that in `branch --diff`, too.
> 
> Are you saying that these are "whitespace errors" getting painted?

Indentation errors, to be precise. Yes.

> It is somewhat odd because my whitespace errors are configured to be
> painted in "reverse blue".  Perhaps you are forcing the internal
> diff not to pay attention to the end-user configuration---which
> actually does make sense, as reusing of "git diff" to take "diff of
> diff" is a mere implementation detail.

It may have been the case before I introduced that call to
git_diff_ui_config(), but that happened after -v2, and I did not
contribute -v3 yet.

> In any case, the "whitespace errors" in "diff of diff" are mostly
> distracting.

Precisely. That's why I tried to suppress them in --dual-color mode.

I did not try to suppress them in --color (--no-dual-color) mode, as I
find that mode pretty useless.

> > I was wondering from the get-go whether it would make sense to make
> > --dual-color the default.
> >
> > But now I wonder whether there is actually *any* use in `--color` without
> > `--dual-color`.
> >
> > What do you think? Should I make the dual color mode the *only* color
> > mode?
> 
> Sorry but you are asking a good question to a wrong person.
> 
> I normally do not seek much useful information in colored output, so
> my reaction would not be very useful.  Non dual-color mode irritates
> me due to the false whitespace errors, and dual-color mode irritates
> me because it looks sufficiently different from tbdiff output that I
> am used to see.

Do you use --dual-color normally?

I derive *a ton* of information from the colored diff. It really helps me
navigate the output of range-diff very quickly.

I ask whether you use --dual-color because in that case I would consider
scrapping the way I handle color right now and try to imitate tbdiff's
way. But that would lose whitespace error coloring *altogether*. So I, for
one, would be unable to see where a subsequent patch series iteration
fixes whitespace errors of a previous iteration.

Ciao,
Dscho
