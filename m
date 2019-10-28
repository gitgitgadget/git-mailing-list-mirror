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
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA4F1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfJ1P5T (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 11:57:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:55369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730220AbfJ1P5T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572278237;
        bh=D+rcvf4O1Xvkubfs6OUh+E/sWnAp3FBfD6dmAi1DrmI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BYyn93ppF/sh/JVVXtCsGC9bzz5Z00JIH81lI0tUadkAhu1GpP17tufzk8rM0fl/5
         kB29nj1cfN9pOX/axkv1jsnOTqluDeJ/vX/tV0BTWrdu9b7FB8ceeV8306DltUDcRx
         Wk65hzLK5TC1wPPtqIk95UBNK1eZlvd+/2NAYI3Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1hayfS1K5v-00oY5k; Mon, 28
 Oct 2019 16:57:17 +0100
Date:   Mon, 28 Oct 2019 16:57:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 9/9] bugreport: print contents of alternates file
In-Reply-To: <20191025025129.250049-10-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281655420.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-10-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u9fUjGMBVpb6CA9mCO3IX2l5t1gy6rh3CrgWRVRngpkEHQe1RW4
 WwJUz8GMeG1Pv6qbP3aZU03uzUHqejhPupMQpNiK0vRhXuZPauvBM2Bd/ce9IAoyVj+iyeD
 n/y4S4NqMJCzRwdxS0PLSNCHRISTwXtzA5SoKSMn6LaL9k2/t7WTEUAw2ixGSddwOZCwAmV
 Tl8oTuXi9PBpQ9/mCpKsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RXGxQN7HDSs=:nPPo9rX/O2xED1jCNP5ON2
 MEdSQtaMlNR5Vicg/TyX056Au53tsoZPaB8rVkmk/XwwX6y6n+FwyrYHk8eZ1W7btCUNSdoTi
 YA0MZaUw1ALzuSFu1e4BI7FYafamdYRD6pq0NVnLIvPzwK0r2gcNYKVsXdx7HkoX5+0sdxCjj
 eka0eS9hbIDWd74w2cRKB3TiZtRT6h/09e5VDybfTGkGJfSljqtRPxY2i0luCeQ9FDy4pwEPG
 AF0yf6bVtGQSzB6jN7iiJ/XndDP1R3hoRd/8h/GLQNCbAQcc6QnIN/fqKMzrP9KLJZxc4OZYW
 3HjB0rNXmgR16/3Qf7sREiAF5n51y0y6OwpDCJbkaJOIdmFgGnJpkXLXzVFF/arG8q61ABMUe
 AqwS70ZMm5uf0TaCpvD3V0PAV872kpxTtYB0urrqKdN2lMjGlaMV9HGpMLPNd4IbV1/QOKTxN
 vjqp02cCt6HYX0pkM5MkdW5BPFXvri67WAvUUJ2DJcgRmmR7W3TNNg0H97MxCKjciO5Gosc0Z
 3LyYka4jPLOOF/6eVAGld5Offcx/qLb+0fRPwhnJ9VOh6rOgLADPTVc4Ke37reF4wU/H0Qszv
 BCfMtTd6wuMIUYaUVELoQX1YGBXVDWq56xPwkfxEdS57XYxn1f1WAT10CfzBuUeDwb7MZFLkl
 fo8U6rvRQFGFGnsKFNkPsq8wtEura81ZxbCZdEPHIBLK4H7Tvro3TG0WkjvLvF8Mzm2cuXUte
 fDLvIrmZ+sCRLNLIt8Jn6gbGKl4GkJzXnapTbpB+0PEIdlEzgClUgjGve9CPBPovyXFXoegRp
 6UuDK4AAFpH6tlzWaLSNv6+Dt9LX+dCslZimhi9gr5H6H92GX+r0FXGGaH826Y0jWL3Q/JPrz
 xF7FoYyZQKYI2QbTnAoj1xMnzEnayZ6IuowArbDolfekBGp/l9M+RZw6vQRBBML0uUfS9y6Xh
 AnFEn1WCz6HjyK5WSeVV2dcP41fghPKo/9x1k+P3FZ3AJL6BcpzVKh+jCuMvufBxE0r4yE/wz
 kCanWEQkBgaD0+CpjQF8SGBA6Q0KYwGoZvZGEGpFIJ64P5RTPKJoqU198N9QaDTdtb2MP6fjP
 sIgO0gB+rLuZbpKckR4Fu38JZG/cmT4Oa+jjsfQTphZvWU/yeiCn7rWFhbFi79KaMUUiY+l8X
 L3JyAt0sdGTMMeveLhGZKTBTYycqQsCUI+bDz0op7PuGzLdHTAp3+k37xfhtRevqXqDsJlXbo
 t6C25z+cMId6Fw7HevHVemnWKYxcy3YKuoYx/2IR6M+IW4LjIVUT7p4gJHrY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> In some cases, it could be that the user is having a problem with an
> object which isn't present in their normal object directory. We can get
> a hint that that might be the case by examining the list of alternates
> where their object may be stored instead.

Doesn't this open the possibility of leaking project's (possibly NDA'ed) n=
ames?

I could imagine that we might rather want to count the alternates, and
maybe separate into those alternates that actually exist and alternates
that do not exist (which would produce a warning that the user might
have trained themselves to ignore).

Ciao,
Dscho

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c         | 14 ++++++++++++++
>  bugreport.h         |  6 ++++++
>  builtin/bugreport.c |  4 ++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index ce15904fec..a7bdc72b7f 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -298,3 +298,17 @@ void get_object_info_summary(struct strbuf *obj_inf=
o)
>  		strbuf_complete_line(obj_info);
>  	}
>  }
> +
> +void get_alternates_file(struct strbuf *alternates_info)
> +{
> +	struct strbuf alternates_path =3D STRBUF_INIT;
> +
> +	strbuf_addstr(&alternates_path, get_object_directory());
> +	strbuf_complete(&alternates_path, '/');
> +	strbuf_addstr(&alternates_path, "info/alternates");
> +
> +	strbuf_reset(alternates_info);
> +	strbuf_addbuf(alternates_info, &alternates_path);
> +	strbuf_complete_line(alternates_info);
> +	strbuf_read_file(alternates_info, alternates_path.buf, 0);
> +}
> diff --git a/bugreport.h b/bugreport.h
> index 4f5e2d1b9a..74d1f79960 100644
> --- a/bugreport.h
> +++ b/bugreport.h
> @@ -36,3 +36,9 @@ void get_packed_object_summary(struct strbuf *obj_info=
);
>   * previous contents of hook_info will be discarded.
>   */
>  void get_object_info_summary(struct strbuf *obj_info);
> +
> +/**
> + * Adds the contents of '.git/info/alternates'. The previous contents o=
f
> + * alternates_info will be discarded.
> + */
> +void get_alternates_file(struct strbuf *alt_info);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 8aad33a9b0..0784bdc42a 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -76,6 +76,10 @@ int cmd_bugreport(int argc, const char **argv, const =
char *prefix)
>  	get_object_info_summary(&buffer);
>  	strbuf_write(&buffer, report);
>
> +	add_header(report, "Alternates File");
> +	get_alternates_file(&buffer);
> +	strbuf_write(&buffer, report);
> +
>  	// Close file
>  	// open file in editor
>  	launch_editor(report_path, NULL, NULL);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
