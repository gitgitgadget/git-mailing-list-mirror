Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C46D1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeGQQ6J (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 12:58:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:45151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbeGQQ6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 12:58:09 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3x6-1gI5O31LcK-00er2S; Tue, 17
 Jul 2018 18:24:35 +0200
Date:   Tue, 17 Jul 2018 18:24:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/20] range-diff: adjust the output of the commit
 pairs
In-Reply-To: <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807171306380.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com> <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gTrVxZCDRKm7Qoz/L7VwP7pDMZMPhd+AfS1uCzjof+dk45CqqIY
 S5ANWSOc6ntblVzRZuexp8lJB6d3axX3UnQ8BQzOZ/yJNs5Rp19+iZXgLXThnrf+RN1LWw/
 1dw3sgMmNEIfBRa9SiZWaL4RJ3E66ZPWr+nqcb6SwCDG33Xs/tL2Cv/r/uKmEEaWb0/2d5/
 2kc+sVTLj9yCgo0dMxXKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YXIDqdpZeHg=:S4yyVw1oqjsx0V0MM6E7PP
 LaZKasMHlq5n8pLiTJ6g5qJv/+NV8ft9Z2ONhIcpG6iUGa7hLKLiCjh7+4zmdSHPS6p5u/V9v
 NpwGgrL7GFOe7SLi6jGCsbJ7kW4tvAHmU+Geu7ghg+LkZoV2FgRygCyUpwOSji8TgSqE4tc8o
 AbyzoOjQRaJG5PZv019gDR0w63Sk2GLmUyzALyiKz4zpx/Ex1pfBK8yu8SK7c+BaOTR/PM6Fo
 qYbaBzCqUXy9ei8yN1JhQ1Q4o3K4kpXL7hSoDBd+RrTnl0vD9GN9GMbkQIDDkFm8vJ/dvRwbR
 d1Kw/WrciJY+KPSAzm/rBrG1orfaRgKkOlj64v0NcE3gu7EvU8TamzN2lyWFWe9gOSUedR/+C
 pRwPzoFY7PYqjf0vD/4NJziN5rer0b7z8Si4NrtvsFM1eWABTiZ3lpmyTxUrA0OfeUfU1d5JR
 7R5a3cWLE75TonclEUvr+i1PKKqJTCcIoRCms8LdHPwK1X2B7QB151W8dAJ7kBTeOvUJ1g7RS
 tgSKzxa72yKISsJ/KKawn0C+NNUmxE1RKOkOFeJpH+mAVq/eSlcME9+g2QD88jjV2zshaIphh
 0di05TjHUgLg6aWwpyYY20DMAtXT7mjQWBRlJhynFs+xOoPqwc4Ye/2qLBfesXpL6I+2HvOcC
 reK2orxPXGRukn2OjJcSb8t7VWIgvyqlLUqajpkPYkgK1SSzatA8PTPX8wc+VSILgF/LxV0CR
 9LSDC64D1I/h0L/NNFPKOlQ4UHr6kIcvuk551uTDJDvOZNytP6xw4pS+LBo8lzHDUrEeuJTVO
 WKmPCpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Tue, Jul 3, 2018 at 7:26 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This change brings `git range-diff` yet another step closer to
> > feature parity with tbdiff: it now shows the oneline, too, and indicates
> > with `=` when the commits have identical diffs.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/range-diff.c b/range-diff.c
> > @@ -251,9 +253,57 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
> > +static void output_pair_header(struct strbuf *buf,
> > +                              struct patch_util *a_util,
> > +                              struct patch_util *b_util)
> >  {
> > -       return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> > +       static char *dashes;
> > +       struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
> > +       struct commit *commit;
> > +
> > +       if (!dashes) {
> > +               char *p;
> > +
> > +               dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
> 
> It's nice to see that the bulk of the range-diff functionality has
> been libified in this re-roll (residing in range-diff.c rather than

Can we *please* stop calling it "re-roll"? Thanks.

(Or are you really "never gonna give you up, never gonna let you down"?)

> builtin/range-diff.c as in earlier versions), so it's somewhat
> surprising to see libified code holding onto the 'dashes' buffer like
> this in a static variable. An alternative would have been for the
> caller to pass in the same buffer to output_pair_header() for re-use,
> and then dispose of it at the end of processing.

Sure, to be honest, I had completely forgotten about what I did there, and
had to read up on it to fix it.

> 
> > +               for (p = dashes; *p; p++)
> > +                       *p = '-';
> > +       }
> > +
> > +       strbuf_reset(buf);
> 
> ...much like 'buf' is allocated by the caller, passed in and re-used
> for each invocation, then released by the caller at the end.

Yep, I now pass in another strbuf, `dashes`.

Thanks,
Dscho
