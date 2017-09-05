Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A19D208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdIER2e (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:28:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36875 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbdIER2d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:28:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id 63so396595pgc.4
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NVRMWwLQs/SHeYVWBXGrVL5x4/fN9JR3OHgPPMUXdAI=;
        b=ofNF3jAHAn5AVrjW03F7PVHvLSd3Ynhqkdpxj0OWBglVJUnZ0V7YkPZq1W32AvoS0d
         3ZVyf7uuO3QA+EAiBNba4SDf/tBqM1BW2uLkgAqqMSc6zkD/3ZI3FcXl8uk4HpHNI/9T
         vb9rhimA2xWqWulJS2f2IQrM/4gQ7knSSu7BFjxL2WiC/k3wwj4EtfQsxzFhKxXKphsv
         0izCXVWcLC/G1Rw8RAMvOPKJgueZmuIWaBWSI82+rrGBcl6HCfR2i8qGr+xRAy0vc8I6
         7ECFsHL9xSTEsf4PSKFdhDk4aN/AU4qhoROPpfvaBqKpjlSW+eJbn3v9ltg//pA2czVK
         XNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NVRMWwLQs/SHeYVWBXGrVL5x4/fN9JR3OHgPPMUXdAI=;
        b=YHP6vRQXGrw0pNf4LGg7R2mhF4ssFOyzmUI7SzlcVPMRhu0LxUH6CMrOnQsdvdcWls
         M57yr8UdyOeJbM8+XILhZGoxk1GHKpMOy6Dz4l4Pvgew2amOv41Glv8kHsy9ihLK88Dw
         mk2eNI5lo8Ilakv5DyN2DefEAwGAWRdJ2g76Q2CRXnTvnYAaPHGpf78hVkvuZJHHg+LI
         GfG8PlQSAprNUx2ERWo+YBIt+XnsvPl8p5R0aBDDmdsfcswXnFALB0r7rSIug/8/RVEb
         l9v8+nFiuQ1e+Igaf+N0q6XgSAW1JkTJnZU4xxdKS5ve5VxW4c4I2wpqZksmvIq7/WxY
         cw9g==
X-Gm-Message-State: AHPjjUj/YK/2U72IJ6MZwrjTZHqtaOBxp+tOAQUcVRlcPDb9hMBFuDm/
        ZZ1WKRCd7nLk0GDvwo9RfM23aI7+og==
X-Google-Smtp-Source: ADKCNb5yye/bq6WDYTSnV7QN+wRlj+emsAsoF3ey/6ddNbnDdnqBFlQeuhyKOIlIw7nDoCsNSjL2J9jgT+JFOzc2Agc=
X-Received: by 10.99.126.84 with SMTP id o20mr4725679pgn.201.1504632512925;
 Tue, 05 Sep 2017 10:28:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Tue, 5 Sep 2017 10:28:32 -0700 (PDT)
In-Reply-To: <20170905084751.c4rbeuxx5rdqwdgo@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <f136e83168453af7a0d1eba45c8ad47d01dd9a41.1504024261.git.martin.agren@gmail.com>
 <20170905084751.c4rbeuxx5rdqwdgo@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Sep 2017 19:28:32 +0200
Message-ID: <CAN0heSpu-Gr6JLuhBX=m0MbGNHHznrnWHYg+ySCpEcC9ht0_FA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] refs/files-backend: fix memory leak in lock_ref_for_update
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 10:47, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 29, 2017 at 07:18:23PM +0200, Martin =C3=85gren wrote:
>
>> After the previous patch, none of the functions we call hold on to
>> `referent.buf`, so we can safely release the string buffer before
>> returning.
>
> I ended up doing this a little differently in my version:
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9266f5ab9d..1d16c1b33e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2287,9 +2292,12 @@ static int lock_ref_for_update(struct files_ref_st=
ore *refs,
>                          * the transaction, so we have to read it here
>                          * to record and possibly check old_sha1:
>                          */
> -                       if (refs_read_ref_full(&refs->base,
> -                                              referent.buf, 0,
> -                                              lock->old_oid.hash, NULL))=
 {
> +                       ret =3D refs_read_ref_full(&refs->base,
> +                                                referent.buf, 0,
> +                                                lock->old_oid.hash, NULL=
);
> +                       strbuf_release(&referent);
> +
> +                       if (ret) {
>                                 if (update->flags & REF_HAVE_OLD) {
>                                         strbuf_addf(err, "cannot lock ref=
 '%s': "
>                                                     "error reading refere=
nce",
> @@ -2310,6 +2318,7 @@ static int lock_ref_for_update(struct files_ref_sto=
re *refs,
>                         ret =3D split_symref_update(refs, update,
>                                                   referent.buf, transacti=
on,
>                                                   affected_refnames, err)=
;
> +                       strbuf_release(&referent);
>                         if (ret)
>                                 return ret;
>                 }
>
> After we look at referent.buf once in each of the branch arms, we don't
> need it at all. Disposing of it there means we don't have to worry about
> it in all of the later early-returns.
>
> I'm assuming that referent will always be empty unless REF_ISSYMREF is
> set. Which seems reasonable, but I didn't double check.

Some time after I posted v3, I had the same thought. I did double-check
and it does hold. But then I thought that even if it holds now, maybe
it's a bit too brittle. On the other hand, my patch is quite noisy and
maybe the connection between the two is obvious enough that it will hold
in the future as well.

> Food for thought. I'd be OK with either version.

So would I...

Martin
