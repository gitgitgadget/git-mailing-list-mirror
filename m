Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0A5201A7
	for <e@80x24.org>; Mon, 15 May 2017 20:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755760AbdEOUrM (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 16:47:12 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34173 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdEOUrK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 16:47:10 -0400
Received: by mail-io0-f173.google.com with SMTP id k91so81570499ioi.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hpkm+z9T0GK2+SWPZRfdmB3oJFykPG074i53JhGzrTg=;
        b=szsDdbiX1cmWUtLYuwII1iSARMUp6ZHxpWHKjiyRdq8di7grc01bhPp3QCtRlJ6EYL
         +fOneU8UKBiyQxNwWHDwP3lRKz/9PY7F4sXDazkumZvmYKnwfiAJ+ZWzzTTdLAcgUWq7
         mGYYe+aM5Lozrfk4eAa+4FQ40/Ss+8qfplTRTeK/HhWq8nJ46Bz2k21jrnhMGkmT0Bek
         3R6D5wQCjl4LyLBfcyamejxDUjAVcb8utfhVeh0hM3wUzRFH6yVMZA08wo1htu8watUM
         d37VkI8mqSVPcIAHkQPDPNc2IULJAEl1JN0yyqpixuDLk+0Tpm0ELZCoGhI7DMHYU085
         0Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Hpkm+z9T0GK2+SWPZRfdmB3oJFykPG074i53JhGzrTg=;
        b=uhnKDoA+Y9aklZgUX+ZI/BfRkgHT1Q8B8D3bCFrbjzC6D0nn7P3WT0Wrtw4B5xKR2D
         R8/kB9Q6IhCsjPU6FD/VJhyvK5KbHotZAyrGkaAi1UUnyPz76BSe4GPm39gJVxAWwE4C
         gOxtdHYQ7i0oUf2ZEoX3LIV1JkalJxqUos+DtYKLfrG32NWGBaBq6DEJGL2ZbVthxM5i
         ryc8ygRYJZjgo5M9NF1npe4DUaERy+SK5yCXnQPcsrALIODmoqS24BNh3ih8QQ30PQA+
         5U7AEI+8fGWohml+OhFZ0IXloM8ysqmJiA5fR5MX+uJ+uMU7oVTGEg8/A816h2GHmB91
         ar7Q==
X-Gm-Message-State: AODbwcCS1WgCwk/IszSODfgUxxVmkk5m/3YnXgo5MP1iDQTUJD01Lvgm
        +EcLdZn94WwJZwlxhmUd9RX0Gnvtgy9ggLA=
X-Received: by 10.107.138.21 with SMTP id m21mr7300722iod.80.1494881229645;
 Mon, 15 May 2017 13:47:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 13:46:48 -0700 (PDT)
In-Reply-To: <20170515155454.k6bu4psohr674oo7@sunbase.org>
References: <20170515155454.k6bu4psohr674oo7@sunbase.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 22:46:48 +0200
Message-ID: <CACBZZX5C0fetqrqF+3hRciH+QoSPUezcP-A3OzsR=+S_hdztXQ@mail.gmail.com>
Subject: Re: Git just passed Subversion on openhub.net
To:     =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 5:54 PM, =C3=98yvind A. Holm <sunny@sunbase.org> wr=
ote:
> openhub.net has a comparion of the number of public repositories on the
> net, based on searching public hosting services on the net. Git just
> passed Subversion after the number of Git repositories has exploded
> lately. It seems as lots of new repositories were created after cpython
> changed to Git in February.
>
> I've been tracking the development on
> <https://www.openhub.net/repositories/compare> since 2014-08, and all
> the data since then are availble on
>
>   https://gitlab.com/sunny256/openhub-repositories
> and
>   https://github.com/sunny256/openhub-repositories
>
> Current status:

Thanks, that's really interesting!

>  https://gitlab.com/sunny256/openhub-repositories/blob/master/status.txt

ITYM: https://github.com/sunny256/openhub-repositories/blob/master/status.t=
xt

> SVG graphs are available on
>
>   https://gitlab.com/sunny256/openhub-repositories/tree/master/graph

ITYM: https://github.com/sunny256/openhub-repositories/blob/master/graph/re=
pos.svg

> Regards,
> =C3=98yvind
>
> +-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=
=C2=B0 |-+
> | OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
> | Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
> +------------| 27e0042e-3985-11e7-b3fc-db5caa6d21d3 |-------------+
