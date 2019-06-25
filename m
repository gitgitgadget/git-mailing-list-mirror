Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99911F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfFYJVi (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:21:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:53341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfFYJVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 05:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561454489;
        bh=ndfH6KIkSPsPMgTUETnBv/qQZhA4nakbSMqQLhhR8HM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hglf/4l+mV77/F3seFpUgwlcCB64POgTdW/v8f1cD6asoVAmWuIZMW/zGvkTeRf/I
         e7F//IQoETg2DeNK/WEW1Cmx/lPeXGHoaLqzQdHA2Jii/qWq8ct/9ui5JzdfY5sfFy
         4V+y0NNkIBMNLQNE+nWiEi+PAh9zJXZfQJIW431c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcvy-1hp13501L8-009OWA; Tue, 25
 Jun 2019 11:21:29 +0200
Date:   Tue, 25 Jun 2019 11:21:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
In-Reply-To: <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.1906251116020.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-2-pclouds@gmail.com> <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-819859718-1561454510=:44"
X-Provags-ID: V03:K1:2MbhDX5sA1rGsmlgGHKTGIX+IwX9D7VAg7qjGE7kTf6sD4gUBiP
 2pClFDOnm/36+ShjfTMM+YYT/ncNcZpg68u5hgcCzT3hHbFAqWJTyJ2nlDY24K+6LJzXNk0
 rWQOaTeq65cMJOAFGb+2zKE+Z6qr9SMhgoaDn6wAnNc97Om1Mzprhw/1Lov1s4mzXs3pVI0
 /qgXvPn40U4dltDKi8sYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fasPGrOHdww=:/7ibnIlby0vzplIouwn8Jy
 1ST2mkJzRS9FX8kZ2HITkZcGimCFAK7XgpwYSTpEDoLK9mCHw/vG5a9fbFbnxacCmfUFA6jkY
 TvzWgTS2PIp0UBw5oSbziTQDKJsTKWE/OoMd8ahtQrDRBYHMfmU07svDcLY7eRW81QFB138UM
 FHSADVos1wd1ZdVEcMg6+VgOOHjjbR9zh0qRoIOoP7ghkchMsrKU0r4i9lkq2/Y74nf7JyMJr
 j3d0ZYwg0uFaQhVOepJxRW4vdMRHOMgx5IlqBeCx+csR0QFqD6UP1iPUmxMjl/sFD08Bbjuvw
 0RVxvph6k3Dthoa/eaU24rVephQRvz9svZCtj5b6xwSN9PrJIl1xB2ODm6uhvP8vex8fe6g6D
 gFV6KMQ2KVglc9O2D+eMmxmrBNtK3Isa69dHU+YMob45HRNqLGEKtZ4bRHJJt/YE8/JBNkjkX
 8M4j6XHYIr2LMyHD+WDO/kbdrKOkFOnd+tY7hNvQ35LIsrzr9dXT5ivzmuuQmz8qOnrA45FVf
 zheDF8pXFQTz7Q148u+dM6IgONk7v+HLCLeN3uR1jaB8gbmHGYS6Ca852So6ThN7gu/bDGdwR
 tgo+Ws3+iwpUwTz4fzGKCWVhf8FoIWMQrJdEujfaBXB3RRH3tATfo3JypdYvh7+PpWkILyMp8
 68+ZbKs2qZh1beWnFMyV+zm8Yr2fgowhTXq7FL1yo93YCFCN2AEV4hfQ7QKDae5Ld78vykFai
 G7QyhPzN0YOvSf4rFHiXA2iKf1jtPbfDY79+hQQ+Pa1ZJHSqRNJw4aupxyX+/NXX/QMwQ+opq
 URe60egwOh4gc1AmtckpWqwbnC5hMgCgElA7jVfuVNzssmCvPfkkciUJ/M7xZHQLHk+JtroeB
 M0tgcPtPa/v1I0DhLNWhBQ7fx75G3qMV6zJM9Fcp8ZK63b3ETZiFlBcgQsON/+0ln30o3ETWN
 t/7dy3P8whYmMq4JQPb75qt4Z8RL2UzGTNPSTfg2su/iKE415Er46auoPdxJXfbE6zliNxJoI
 /+soT39XO4K5g92uEmurt4YhXuZMVSqhLI7ozk9stWRONr9uw5ITgm25GiHzf/XbWG+H9A6FS
 xPRlZSvE28mB/WLmKxpxplr8i6xp4EYYFgu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-819859718-1561454510=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Mon, 24 Jun 2019, Jeff Hostetler wrote:

> On 6/24/2019 9:02 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [...]
> > +{
> > +	jw_object_inline_begin_object(jw, name);
> > +	jw_object_intmax(jw, "ctime_sec", sd->sd_ctime.sec);
> > +	jw_object_intmax(jw, "ctime_nsec", sd->sd_ctime.nsec);
> > +	jw_object_intmax(jw, "mtime_sec", sd->sd_mtime.sec);
> > +	jw_object_intmax(jw, "mtime_nsec", sd->sd_mtime.nsec);
>
> It'd be nice if we could also have a formatted date
> for the mtime and ctime in addition to the integer
> values.  (I'm not sure whether you'd always want them
> or make it a verbose option.)

It would be more consistent with JSON conventions to have only the
formatted date, preferably in ISO-8601 format [*1*], I would think.

And for debugging, it would also make more sense, in my opinion.

> [...]
> > diff --git a/read-cache.c b/read-cache.c
> > index 4dd22f4f6e..db5147d088 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -25,6 +25,7 @@
> >   #include "fsmonitor.h"
> >   #include "thread-utils.h"
> >   #include "progress.h"
> > +#include "json-writer.h"
> >
> >   /* Mask for the name length in ce_flags in the on-disk index */
> >
> > @@ -1952,6 +1953,49 @@ static void *load_index_extensions(void *_data)
> >   	return NULL;
> >   }
> >
> > +static void dump_cache_entry(struct index_state *istate,
> > +			     int index,
> > +			     unsigned long offset,
> > +			     const struct cache_entry *ce)
> > +{
> > +	struct json_writer *jw =3D istate->jw;
> > +
> > +	jw_array_inline_begin_object(jw);
> > +
> > +	/*
> > +	 * this is technically redundant, but it's for easier
> > +	 * navigation when there hundreds of entries
> > +	 */
> > +	jw_object_intmax(jw, "id", index);
> > +
> > +	jw_object_string(jw, "name", ce->name);
> > +
> > +	jw_object_filemode(jw, "mode", ce->ce_mode);
> > +
> > +	jw_object_intmax(jw, "flags", ce->ce_flags);
>
> It would be nice to have the flags as a hex-formatted string
> in addition to (or instead of) the decimal integer value.

Instead of, please, prefixed with "0x" to make it clear that this is hex.

And "mode" in octal, please, prefixed with "0", as that is the convention
to display file modes.

Thanks,
Dscho

Footnote *1*: It is too bad that JSON leaves the exact date format
unspecified, leading to a lot of inconsistency and putting the burden on
parsers:
https://stackoverflow.com/questions/10286204/the-right-json-date-format

--8323328-819859718-1561454510=:44--
