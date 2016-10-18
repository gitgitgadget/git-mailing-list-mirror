Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE5F2098B
	for <e@80x24.org>; Tue, 18 Oct 2016 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758341AbcJRLYk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 07:24:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:56737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbcJRLYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 07:24:37 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lcjgd-1cdFRR1OYJ-00k9Vn; Tue, 18 Oct 2016 13:23:58
 +0200
Date:   Tue, 18 Oct 2016 13:23:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] submodule--helper: normalize funny urls
In-Reply-To: <CAGZ79kaE=KAWcDTEvAqGO=-zzjh3VeSwHH82SnhK6DO9THOyPA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610181323401.197091@virtualbox>
References: <20161017221623.7299-1-sbeller@google.com> <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com> <CAGZ79kaE=KAWcDTEvAqGO=-zzjh3VeSwHH82SnhK6DO9THOyPA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ki3nY67MPaF7YToQC2tPvQV8HABei/Yk9DYR0EDsPHkvbTIAlnd
 6lTp8cKlVwB6HuA7PRz4yzBPDSn4TSp802M4ncGla1Deavj0p5tTmeOUzfsqnKVx/07zsLR
 /tvuW7Epmi8/GElpSrspNY4a2mSWDKl+xBFgucUeryDnsZrwoOj0FjKfFOf1pbSzjCmfRc3
 4qAGhhq/ikcvQGqSkAemA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9EKIeWc5Vuo=:aW9b+Ems0ilr9JK8rF+p2S
 zmgwxIWXkxB6VW4bwXCe5Gwjczj/GGluOGEveYFPjbkG6G5buVefQYkeDEE3rxVZJUoywtNth
 7VxBmWegmUeLU3gPas1Zv7pEltElZysw4nS/K5X8qmnoo43pPzvEzL9R8OVSZIY4Q0QcYo6K/
 IPq7UOAhFCGZvWcX3ACh6vNGlq4XNOv+R6mfznZ/og8vSav7+SJvOP4Hzil1vc0hdj8MOAuQ2
 gfHjbiU8C+sSU/S3AYRL/9gRmpyCFuYMBbelRudMLeW3DrFWmV5VujXwX6uV6bhNadauNdXEt
 F7UjAc7W1luV94oZnNraT1YJeJ37T7jq76RoxuSs8OFtyXAr5Ah4oaQP7KfU1sBdHa6KsIEdh
 pa2bPeKfGt3x0h9SuqYHxb3UCJLO0QRZtOP+f2KYwT0yBvpFQU+ZNYGC+M2qqQAGTfuo6dCqB
 x1lulTxznZfEK4dmezO2WX3XDqDtTtJ4Rvzx5QZO3wjS49mXQ86eJNprkBzr6rbHIXHi7W/e/
 Il/AeW3FL5mACSA4k/j78NAMv5A2RCOzIUVuVbTwm41H8KgjiP9Su8wDbYhsNs3gx4ufs0rgQ
 5sNX3pZ8KJcfvu8JdHNdaPzDPDn6HF2gVUA8FNmfv30G/o58PDo2QQDsearNeuWh5pzU+vcMs
 GV5Uu8KPbqa7MNH7SxXGNuhEPekEl3/z7cSDgDuoVvc8VAnZhGTgFR2Td+zrm+l/6sNqGAheo
 WOO0UCiPSwrFxn6JgDdc7bznfOornKcW2dIGmdanRT9t8+HyLlO/l6bQDYbgb9XkFr1jodoa7
 whzpC98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 17 Oct 2016, Stefan Beller wrote:

> On Mon, Oct 17, 2016 at 3:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> +static void strip_url_ending(char *url, size_t *_len)
> >> +{
> >> +     int check_url_stripping = 1;
> >> +     size_t len = _len ? *_len : strlen(url);
> >> +
> >> +     while (check_url_stripping) {
> >> +             check_url_stripping = 0;
> >> +             if (is_dir_sep(url[len-2]) && url[len-1] == '.') {
> >
> > This is "strip /. at the end" it seems.
> >
> > Does anything in the loop control guarantees 2 <= len at this point?
> 
> Oh, thanks for pointing that out. I thought about that and missed to add it.
> I'll reroll with the length check once we hear back from Windows folks,
> that this is a viable strategy for them, too.

It is a viable strategy for me, too.

Thanks,
Dscho
