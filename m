Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D491F404
	for <e@80x24.org>; Mon,  3 Sep 2018 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeIDBAh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:00:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:42607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbeIDBAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:00:37 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrvBu-1flKzl0ufW-013idx; Mon, 03
 Sep 2018 22:38:43 +0200
Date:   Mon, 3 Sep 2018 22:38:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH v8 17/20] stash: convert save to builtin
In-Reply-To: <CAPig+cTGBi1P5V3uGwtKCvoCn=-17y1dY3dBkS13Yx1ikjpXcQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809032238240.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <6832c979c8dca2a3584ed3cf828a6de060413cda.1535665109.git.ungureanupaulsebastian@gmail.com> <nycvar.QRO.7.76.6.1809032031090.71@tvgsbejvaqbjf.bet>
 <CAPig+cTGBi1P5V3uGwtKCvoCn=-17y1dY3dBkS13Yx1ikjpXcQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o0rNXtWyjEpXB96ZtJE0g2xA+GIf6Rvm9G51Qlz80yqEQhEuKb4
 abXMgRJACNHhlbyvshZD/PKlYQXf1gXLBj0+0mkEkKkbCpRY/57OW4l95kPWkh1dLl6lWeQ
 y69GwfI9mfBVF24loHxLvikYaTe6pYdG86fups3ghBThvAB/JxL87xzyqcNJP/toyTVVeos
 rJrme/JTADCDM/OYZyu0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QEGXExRJOws=:kXbqMvlPVDyD52sTGNRaen
 N0I9sDsWKIM19J0P3n0J/tzhLvAvbEOtU5wbWWZznHO71vIpoBgunmjf2gdunxY0704X+XII9
 i941IOrMlN7tnlH4V4pEyz0xiQCNSoZLI80Ro2l9MfM7dSF85r8v50lzico5Rk4nURbxvFmmx
 1QK9EEurDsjQb1XoN92Bib8hOJMQn441xGUl75VCC+JzYQaOemOay4pAJXHhtIHSjnIcNJ8zA
 76XW/+dfgKYW8vkRVLXYlWePGx2qPR3+92YRDXa6UcUXRQJJ1QUft3omXx2wOc3l9woMFtSk8
 gXh/qG7ucwAV3ddspJ7LlvtYlYSB8oBceGZUiyGiWYybw081TLxKPIWrLg48e41dMNXePhNx8
 qf6bRN1B3PCy8zz5EYhaarhASMo6eLSXNz4V0xTFTJP+BBrBGQh5zfk8rnEnQYR/x3XgYlZ/o
 oDZM6jKm2RFgGSZjUVBjjN5yGklZ+ToAfOlMCALldlBQJqXSKdbWRsgdK1M16AfO6ipHMUs+h
 Jtx1apRAu59KTWzJQfVscV3yx7DjqlYZNQ164/5141pcVMVw7kVpSq3ssZbtXmzETutTAdt5A
 +PHyuyMTC6TpvROtKzaSnQP2ImiprxbS03iqYakaWV9Lv2icerNkr7BQepHgCpokIVZinIl6G
 3CYRS7kZEoVE6Bqt6m1PvkKM6hHcuVQHZhcQlrjJKCJRzpavK/dbIABNYVSBgnhu9o/+cPZnA
 IALBW8Kpl/J8tbtensj90arEnaxI7R10QphHFEHrXrjxDuWmf03GSAs6ee2CFCpOv2qlodDyo
 hlr4kJj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 3 Sep 2018, Eric Sunshine wrote:

> On Mon, Sep 3, 2018 at 2:44 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > where `strbuf_join_argv()` would be implemented like this (and I would put
> > it into strbuf.c and strbuf.h:
> >
> >         const char *strbuf_join_argv(struct strbuf *buf,
> >                                      int argc, const char **argv, char delim)
> >         {
> >                 if (!argc)
> >                         return buf->buf;
> >
> >                 strbuf_addstr(buf, *argv);
> >                 while (--i) {
> 
> s/i/argc/

Right you are!

Thank you,
Dscho

> 
> >                         strbuf_addch(buf, delim);
> >                         strbuf_addstr(buf, *(++argv);
> >                 }
> >
> >                 return buf->buf;
> >         }
> 
