Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCAE1F461
	for <e@80x24.org>; Mon, 22 Jul 2019 11:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfGVLzx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 07:55:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:34853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbfGVLzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 07:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563796546;
        bh=AHaJZF9BDMQiDNNSC0PXbAAVB81W2cgxWZ5t6pLppEs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ieqBknoBXL0i+Ogfhav3tDz5OGIGPHrfxkAljtM/53fVFm1Sh3M4OmQzQoiveLnyQ
         DK/+iRFOT7S11rYzRQBR7pu4ZLDLHPbr6/RVTT3+RflKTs61KlWEUVn7MCnv7ovRPp
         HoHUTsL2b0+OOVrshkocqZy3HioUu7V/+4yiDXxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1iVnom09O6-016xM1; Mon, 22
 Jul 2019 13:55:46 +0200
Date:   Mon, 22 Jul 2019 13:55:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
In-Reply-To: <20190721183115.14985-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
References: <20190721183115.14985-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1824183362-1563796546=:47"
X-Provags-ID: V03:K1:yM2Pn4eIFqoCB/f4OfI1JM1GvvD5MPzoIATE79S0+0WEQ58wIWV
 iMCaWAXJO3ppTxlPPNoe7WzOWlZhZIMO4mjsHRnfobvoFs+AHF4H7MkW91pisBmIa9N8Glk
 h+dFVA9e7jjMHHRep85AvJkXDAETOC5tdoybJxLnvMvzQbl2CRRiRLVZYQTzaN6rax2JNrx
 lrm0oo4JyZsKN56t58+Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iC9i6SnlFRw=:8GZeD0NfRNDevMdShNBIm8
 v00hpQR5Jkhxc091jVpWRZUic8IBKgIi9qe20N/kMHozYIilVO37aCIRMob+BYDI2sBB1aYq4
 gU8aqhsgqaJ3iwoO7/9DZEDkARvttkOJQzqO4pJgv8DTtFGSkGQlLnrio8Tors40y485YUv9Y
 4KDO3rtDfvKTz9e2BfEg+e2vC5yszWd508wJvV+mQoZ9i8hBKu9+TUndJWxqitM7gsRdaarab
 aI9FUaRhxdpjnxb8r6BmlHS3Yx6kwX1sOU425N6yNYHn3O11iiVstxIgxTZTBwEXIYEnrxltH
 /eioGuO9eQ1KkEy/I6sD7718pMAAqP4T36lZOR2nqBvIn4tKmmA8CpCM8g3YV735U3bSVcwkA
 GzuBnxVNDtEzOs/lR1/lkCvHc/8YDXEpwHmOnbvjVLgVvVhMf3RZrBv5FF/9wQbPNKV8Yuf4A
 tF42EZdsEng9kFkUtuL0rpOXmxxXBoIxA0dMz1A1JjnP6lyR4c69w7mIAon5MWTIc6/C8epf7
 LGa2RjaMrXb5nwZlGs6xGazwTYu2XF15EKqu5G/iqRgd6BkwU6vTAsNRMgL79jt/7JlcdbzPx
 db/nw9wr/kvxSkf7ycaw7mYKYlbJsifRA6UzQi/EiNsIw2tGOaysFMih1vuQiHuufYUjlk+/S
 QnXxd8gb6vG1oeAvJ3+aFdOzDNczj+M8vl5ehzotajGLHCA8SRkAOdbqUqidu+jzbAHoQyDlB
 WrLlOTyraqgMjWZ+KyO3b+3/wtM3AkCTGvXAY6mBXAXLpCHuSI1YMfSgCHGRif+wgp9aDhuI4
 ZKpSqTDY0l5xIhQ42vOHl4cKxuYRXNGZBfMDfnUhERKpYPdVGkSjJWfJg5qe3Dlm51wXY80j5
 uHJPb2k2QOKR7a/ewsZGmH/sWpdrYqjYHTsFru/ANbdfjAHX/HoM+BL6KtIXAg3DSlegwhorI
 Ze2ak9GqnQyxyWl63onvhGnk/n2JETVj9dalAkns55R326lxQxr/iBmCBdeacveCjDRxY0VYQ
 KNuPyKFXpmdQ2f1bpQQk0y0ru0O4HGOlSnrEQRfOnkqhACZgJJZpt8x8MyXuaUSAdXjxByik7
 Nsc11a+m39v26XiacsEIETJAe8AlguG8V+r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1824183362-1563796546=:47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Sun, 21 Jul 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Usually PCRE is compiled with JIT support, and therefore the code
> path used includes calling pcre2_jit_match (for PCRE2), that ignores
> invalid UTF-8 in the corpus.
>
> Make that option explicit so it can be also used when JIT is not
> enabled and pcre2_match is called instead, preventing `git grep`
> to abort when hitting the first binary blob in a fixed match
> after ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15)

Good idea.

The flag has been in PCRE1 since at least March 5, 2007, when the
pcre.h.in file was first recorded in their Subversion repository:
https://vcs.pcre.org/pcre/code/trunk/pcre.h.in?view=3Dlog

It also was part of PCRE2 from the first revision (rev 4, in fact, where
pcre2.h.in was added):
https://vcs.pcre.org/pcre2/code/trunk/src/pcre2.h.in?view=3Dlog

So I am fine with this patch.

Thanks,
Dscho

> ---
>  grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index fc0ed73ef3..146093f590 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -409,7 +409,7 @@ static void compile_pcre1_regexp(struct grep_pat *p,=
 const struct grep_opt *opt)
>  static int pcre1match(struct grep_pat *p, const char *line, const char =
*eol,
>  		regmatch_t *match, int eflags)
>  {
> -	int ovector[30], ret, flags =3D 0;
> +	int ovector[30], ret, flags =3D PCRE_NO_UTF8_CHECK;
>
>  	if (eflags & REG_NOTBOL)
>  		flags |=3D PCRE_NOTBOL;
> @@ -554,7 +554,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  static int pcre2match(struct grep_pat *p, const char *line, const char =
*eol,
>  		regmatch_t *match, int eflags)
>  {
> -	int ret, flags =3D 0;
> +	int ret, flags =3D PCRE2_NO_UTF_CHECK;
>  	PCRE2_SIZE *ovector;
>  	PCRE2_UCHAR errbuf[256];
>
> --
> 2.22.0
>
>

--8323328-1824183362-1563796546=:47--
