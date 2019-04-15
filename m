Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BD620248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfDOMoN (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:44:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:53401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfDOMoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555332247;
        bh=Ku21Is1iwdVa5hDRtd+LPD3TvSqfcc6JDFmgrK3REBQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C2AIHbdPCrJ5M7oNkKpTs8ni6sX90If1doN6G7D8HPeBrcRpETKBJiXPCv3XUE1jg
         9SeNa0OUGpYafwP96niHDqa4xZY2X7MY4NIJZOgj7I1yU6mqz8z2gf/Zgq/5TluYON
         Y/X35Jsty8erUDNihCsCBtTUJxekLMa5sWIvtB8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZlZ2-1gZCuI3Aq4-00lV51; Mon, 15
 Apr 2019 14:44:06 +0200
Date:   Mon, 15 Apr 2019 14:44:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/4] range-diff: add section headers to the outer
 hunk header
In-Reply-To: <20190414210933.20875-5-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151442150.44@tvgsbejvaqbjf.bet>
References: <20190411220532.GG32487@hank.intra.tgummerer.com> <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-5-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R1LYP1i7IkMZ1auizFM9Pu0UBI6KZX11Fm9qn9Nz/y/o3xWdN9/
 xh+txaoqhyQiFEvY8boF/i/qop0Oi6yD0EU9s8qmDV4f+a73yQwVrE1mY2RE1znvGfUtAn9
 MdWCY73HHVedKH72j1L6/05qWcbOUXGwJ3N9b3Uw6P57ax7nmpmKsm6tiZI/x/0Em9Ce+KT
 WjpqbEa7hIPECK/Tgl1EA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GJAtBFz5Q+o=:uXBjrOn68mmK7z5zxqes4r
 Deh2mfvsThpOWUAEgLPmsN92jfVNMmnuwkAGLXcOjTTJvbIGFFy22JAZTAVX/OWFWJfrRaInh
 jLKAeixdwpkeszZmXuQ0tVqEO6gNwz/8D+KIVx7VuXaz/HdK0HFNf+9NpZm4aD3200V7mqjW1
 udSLGCyfCs/IHLyaVC8QMwe5FUA7y4m48apNt0pfjd/YZ6LMNMqJ0h9IsnN9Ty0+V1inf8/g7
 RwuhV1V9RVflRvL+E3261/jZvq32TgKwDh26nXyZLWeMP9H6NG5bmOY/nW9K+cZXSAgMrVu62
 5VT3KGI44uuF8qQY2AZm3UC3RN3mn0D+ITdec8WJsWFpdjCPQrdBY3lEqq3Nk2Dl0gwh1nB89
 FJ/cO3jC10pe2vZ0IyJ8vXTx3sXrpUA2uSY/+LU0UIk47+/MKUYd9E2ty3XEFqXJ9+jSUzV08
 gwW9zvp8wMvGYrqZPWq2NhUx2+jwuWsHcTTsGmNbyZHInNMJBBNCa4JA4+TMb39cCOcvmfdKn
 xf6xOBHnm3TmkS6tstuiV+kZp18biSF3Tk1SY3JLsbASEmavf05C/K9Sv4qhBfiB1bek5CO0g
 qhLK1euuR7k1KjmhMN+jNiP1zyfUIWxlP6gWfM1kSxnLy8CO4C8tStMN8cd7LpMymHeRkio9Z
 3kr4cq8kBCUyv+KFO6VH/U2uQptgFgzQKWBbOHc9H5Z9fvMVwAAH5Ys65TukVyMXkD4bBFOji
 xnSHUQt/qEyY/rIuhNZT2vpNqvG1eLB4kPNGNqOQfFv2MxnziMZ6+Lyxz6n3JnYCzWPDNvRwZ
 851ElP+atgQ8ML+Zm/tK0oOjpqcdrWirCZK5oPIHnbW1drRfkkuY743Bc4JeCVsTcnLLkjTwI
 nANpaGiUA1o9JJUx5Zj/ImMV11nFohsQLT0CnANxPgyllo/eBeff4Wl8YgfshPdKbhZlC9OT0
 2RO5BjB6uIQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 14 Apr 2019, Thomas Gummerer wrote:

> Add the section headers we introduced in the previous commit to the
> outer diff's hunk headers.  This makes it easier to understand which
> change we are actually looking at.  For example an outer hunk header
> might now look like:
>
>     @@ -77,15 +78,43 @@ modified file Documentation/config/interactive.t=
xt
>
> while previously it would have only been
>
>     @@ -77,15 +78,43 @@
>
> which doesn't give a lot of context for the change that follows.
>
> For completeness also add section headers for the commit metadata and
> the commit message, although they are arguably less important.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

That makes a total lot of sense. So much so that we should protect it by a
new regression test case.

> diff --git a/range-diff.c b/range-diff.c
> index aa466060ef..15ac54f369 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -124,8 +124,10 @@ static int read_patches(const char *range, struct s=
tring_list *list)
>  			strbuf_addstr(&buf, " ##\n");
>  		} else if (in_header) {
>  			if (starts_with(line.buf, "Author: ")) {
> +				strbuf_addstr(&buf, " ## Metadata ##\n");
>  				strbuf_addbuf(&buf, &line);
>  				strbuf_addstr(&buf, "\n\n");
> +				strbuf_addstr(&buf, " ## Commit message ##\n");

Should this not rather be added when `in_header` is set to false?

The rest of the patch makes a whole lot of sense to me.

Thanks,
Dscho

>  			} else if (starts_with(line.buf, "    ")) {
>  				strbuf_rtrim(&line);
>  				strbuf_addbuf(&buf, &line);
> @@ -387,8 +389,8 @@ static void output_pair_header(struct diff_options *=
diffopt,
>  	fwrite(buf->buf, buf->len, 1, diffopt->file);
>  }
>
> -static struct userdiff_driver no_func_name =3D {
> -	.funcname =3D { "$^", 0 }
> +static struct userdiff_driver section_headers =3D {
> +	.funcname =3D { "^ ## (.*) ##$", REG_EXTENDED }
>  };
>
>  static struct diff_filespec *get_filespec(const char *name, const char =
*p)
> @@ -400,7 +402,7 @@ static struct diff_filespec *get_filespec(const char=
 *name, const char *p)
>  	spec->size =3D strlen(p);
>  	spec->should_munmap =3D 0;
>  	spec->is_stdin =3D 1;
> -	spec->driver =3D &no_func_name;
> +	spec->driver =3D &section_headers;
>
>  	return spec;
>  }
> --
> 2.21.0.593.g511ec345e1
>
>
