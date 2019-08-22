Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEEC1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 14:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfHVOrI (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 10:47:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:38581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfHVOrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 10:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566485223;
        bh=BtHHFYDRp64dzhQ5mHouZytrWYqixW5JsrNvOGX2n8s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kfs0Qb7tfmQTPdPMRQP8076jrOo4IsDFukdnchVQH5Pr042j6BftRkn06EISpE0Sy
         Z+e7i7kVv3vpVru97NflFPjh1pFkqRJb5eFx6lX+6NKrKlrRBtXj5iy5YD2lmnXBMr
         RvhZCBvoFHOsaWjTQk/nYF1fnXi8OKtErdFMieS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwrS8-1iKVyQ36zo-016L8F; Thu, 22
 Aug 2019 16:47:02 +0200
Date:   Thu, 22 Aug 2019 16:47:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parseopt: move definition of enum parse_opt_result up
In-Reply-To: <58e5dd7b-d577-a1d9-c704-44642f553323@web.de>
Message-ID: <nycvar.QRO.7.76.6.1908221646460.46@tvgsbejvaqbjf.bet>
References: <58e5dd7b-d577-a1d9-c704-44642f553323@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-327453726-1566485222=:46"
X-Provags-ID: V03:K1:dvu0eQ8vI6ImEmOUHBJxAKtNJIZcv38NJgRxvh7ZrRjTC319iGJ
 GnyWmtIJfCg9TwPKfSGvyuljlPLQmp/vYg6Bq6/si5ft9aU7CrPEv7y+zkoDl9D8xON3nud
 oQiFsnYPD58xF/7PASWc4BibiO8ajC1JckHuq1pBWu4K0qfvDEr/Lc8XK7IyBTjHrujPyd/
 eFOd7DmUyFYqH+l24Klhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wO9xAiihRsI=:ya2m5342X1l3Hu8tAmkEfK
 PfXDu3Z/bh44K/7lEX4AS1FeQeJQTOAD+HTF5e7/DSy4IVKLPGKMS0/wrXXQKul8VxqidbNjt
 0yb3jTDAvQoDxHSdnPlq/UXR2E5F0l7dEHev3omv8oGa8z22VIiAAbDWPZPXP5eP92GuC2azq
 OE4ed0ypJRIAaw8Vsh1SuVguXzJX85cqSnnu5Y1900VwRjYyGq013gddQ18wj7WJI91pjQcfv
 ZfYwgVYJ8mTytuDnBaJVUMMxk9gFlpDS1QPaWkoPLJxTrJ1iEEErSJUnesN8al2MzKOVM0QEP
 tnQdz3cPriWOXDamlyBwBkrYAcSTiK5LwPKgFSn6ACi8UCD2/9JDWUIR5sHV/mw5GxR+69hms
 vej4ujR62YPGj/TodSxWabLmcLVFoTFYGRqmdp/Rc4/CDuPbOFj3NSEGP2FYT/4iQBUYDn5qP
 JAmBD36AFfQsKZXgs1lHBAf33XqNgh65jyeQyHNNIivVsJASqUl+/5NSV4Ass9XNGDhRML2/U
 B6HG4JYntvsDgrl+9n6HS9+VOgcQcZpZNGuDTBs+GBPjTect7Wdf6PGE1LMWhwWQy14kVT7At
 lNYPOPRS5TtHlZyyZCHOHjTlCsTyI13BOhSFWIsKMCv46mk1fP388ZxSoRz99iZOvYVEr7qcR
 gQA/v4GknUdWdzbCNEOtMUDFALTc7HTcCO7K+VFvgGGwUCyBsIApFfB/BvmtMXSiFJr6y8iAU
 VLv0JLCHa2XClmp+PW/gxmnAkL7ZB3cfSL84mpGWc8oG9x0mHJAYvBZkxSWOfG37gwiH2POJd
 kMVIC09sm8H+NhT39rulXZ9Sn63GAk02mgipT3n8Io3B9k0qJzWNwscEbHR2Dp4+wvkung4r1
 BfMQ81Um7zPDRMBtIbVckvO56T1hQEnzFRs/DMifloNMExhq0YKzYMkch1iV1nA1xsI0PeBMO
 hBDGjmK6EzEUMKvHkfqm5a0NBZMEpAcgvQuc5eJZU3uLz5Z8AGnxnJXSHSTXyk2IfSpOxnBdI
 T8PyT+wEmBkRoJbbS2xLTFcb+31OH9F42BqrAf+u2DAVZks/yDxav19FB3Iz+nqVRygfPZGws
 qJOZjvbKgwYHikaIus7CI2n9KGmyO7HXJvpLQLo76U+il+1QoPxU+YNkxOWvIFhQ3TNBgUnZO
 JAHuocCOWDBUkzmVNU1zsjaFt2IjLgFvNpxSx3tI0VcU3xgiet1TC2pnmb9UxpmROScrY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-327453726-1566485222=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 20 Aug 2019, Ren=C3=A9 Scharfe wrote:

> Define enum parse_opt_result before using it in a typedef.  This avoids
> the following compiler warning:
>
>    ./parse-options.h:53:14: error: ISO C forbids forward references to '=
enum' types [-Werror,-Wpedantic]
>    typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t =
*ctx,
>                 ^
>
> While GCC and Clang both accept such a forward reference by default,
> other compilers might be less forgiving.

Looks obviously correct to me.

Thanks,
Dscho

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  parse-options.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index a4bd40bb6a..38a33a087e 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -46,6 +46,15 @@ enum parse_opt_option_flags {
>  	PARSE_OPT_COMP_ARG =3D 1024
>  };
>
> +enum parse_opt_result {
> +	PARSE_OPT_COMPLETE =3D -3,
> +	PARSE_OPT_HELP =3D -2,
> +	PARSE_OPT_ERROR =3D -1,	/* must be the same as error() */
> +	PARSE_OPT_DONE =3D 0,	/* fixed so that "return 0" works */
> +	PARSE_OPT_NON_OPTION,
> +	PARSE_OPT_UNKNOWN
> +};
> +
>  struct option;
>  typedef int parse_opt_cb(const struct option *, const char *arg, int un=
set);
>
> @@ -241,15 +250,6 @@ const char *optname(const struct option *opt, int f=
lags);
>
>  /*----- incremental advanced APIs -----*/
>
> -enum parse_opt_result {
> -	PARSE_OPT_COMPLETE =3D -3,
> -	PARSE_OPT_HELP =3D -2,
> -	PARSE_OPT_ERROR =3D -1,	/* must be the same as error() */
> -	PARSE_OPT_DONE =3D 0,	/* fixed so that "return 0" works */
> -	PARSE_OPT_NON_OPTION,
> -	PARSE_OPT_UNKNOWN
> -};
> -
>  /*
>   * It's okay for the caller to consume argv/argc in the usual way.
>   * Other fields of that structure are private to parse-options and shou=
ld not
> --
> 2.23.0
>

--8323328-327453726-1566485222=:46--
