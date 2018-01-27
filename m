Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053F61F404
	for <e@80x24.org>; Sat, 27 Jan 2018 13:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeA0NgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 08:36:14 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52419 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbeA0NgN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 08:36:13 -0500
Received: by mail-wm0-f49.google.com with SMTP id g1so6122124wmg.2
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 05:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hKzOQl9flth2eMWYN2Kj9UlfsVW9H9GKgk4bAxetFOA=;
        b=tBtUJcjgIoepv+SPr4Baj5qUwk7vwZ6YAj29VjeuoSdY69dfwgK2CykdwiTCyT1ech
         njP96JTZ5zoWLwPsz3OiqEVpdXITpEcZKczYmn/L0ioMHZ13T4vxJ/C6MuhtCl4UZJgq
         oemUzjpkcIFfOGJx7csUSIXFH8eP7bgbIxLN89If207wPJnfSRvg+pVIxC+fbk4UecaX
         RNo6FCi0lceHaeGrWLnCO29uMSxeg8xxOZLnKZ2O6dEAPkrWIoWoI1iEWQTt5CQEPMat
         5OHMSQQhGtUkc39Vy7FI1QklQPAPkp8Q8yQgHCmFHyf1nVr4HZu7JGRZQqzaEWLaHPcG
         q9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hKzOQl9flth2eMWYN2Kj9UlfsVW9H9GKgk4bAxetFOA=;
        b=uhHBrfKUVBwppY7P+oAd1cvzdriayO0eO/7FJtvEIP+MdyMnRLCu8qArquX54jDzVo
         cRnSz3Aos/MK22cAeUy00C8J3fKpwMslUKB+OHioj0sqoX+l4T5MrIEYD5pMIjcZ9mOU
         Idgb8Z2yR+weLl3VkmBT65x201lrHiipHg4Edza+9Tx0WbyWQbe8o50lNa05QTfZBPzC
         a4ArmoVfF108bXKsknbUcvAQba4wmeTeCfvUR03UfLmn047oRSLft30RafVol3O3dxhd
         Cpf15VnCiIwEhSn+1CUkgEsx5FuxZMdPkYQdC2FVSmHMiNgdJOTlCo6fHWEHZog9IDvt
         bxyg==
X-Gm-Message-State: AKwxytcAn+QLwp2X7OijYusbNEJaY98Fe3MQwXU9olmkU6ZB/1CwZNxi
        GGFWzQhFiHVbZoPaL06TooQ=
X-Google-Smtp-Source: AH8x226+4SGxvSeqpuxpz7erqClJtuGtLrfEq/Zrz5dRLQ4FERfGUn721m7nz9Vls9EaIDRmL9KeXA==
X-Received: by 10.28.64.67 with SMTP id n64mr11864530wma.147.1517060172041;
        Sat, 27 Jan 2018 05:36:12 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB4014.dip0.t-ipconnect.de. [93.219.64.20])
        by smtp.gmail.com with ESMTPSA id y204sm5708302wmg.44.2018.01.27.05.36.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jan 2018 05:36:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [ANNOUNCE] Git Merge Contributor's Summit Mar 7, 2018, Barcelona
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180119001034.GA29172@sigill.intra.peff.net>
Date:   Sat, 27 Jan 2018 14:36:10 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F92D899E-C54B-4004-A957-FD167BD0E470@gmail.com>
References: <20180119001034.GA29172@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

I would like to register to the contributor summit :-)

---

As I am writing you, I thought I could ask you a question:

"git verify-pack" tells me the "size-in-packfile" which is
kind of the "real" size of a file in a Git repo. Are you=20
aware of a way to get this number via the GitHub API?

We have written a GitHub bot (soon to be open sourced!) that
warns about large files. We query the file size via Repo Content
API [1]. Largish text files usually compress well and therefore
our bot generates false positive warnings.

I assume it is not possible to query "size-in-packfile" via GitHub
API as this is kind of an internal and not necessarily stable
number. But I thought maybe you happen to know some way!

Thanks,
Lars



[1] https://developer.github.com/v3/repos/contents/#get-content

PS: In my last email I asked you about AsciiDoc rendering via *.adoc
    extension on GitHub. Your argument that Git has custom AsciiDoc=20
    configs and attributes convinced me to not propose that idea on=20
    the list.


> On 19 Jan 2018, at 01:10, Jeff King <peff@peff.net> wrote:
>=20
> Git Merge 2018 is happening on March 8th; there will be a =
Contributor's
> Summit the day before. Here are the details:
>=20
>  When: Wednesday, March 7, 2018. 10am-5pm.
>  Where: Convent Dels =C3=80ngels[1], Barcelona, Spain
>  What: Round-table discussion about Git
>  Who: All contributors to Git or related projects in the Git ecosystem
>       are invited; if you're not sure if you qualify, just ask!
>=20
> In order to attend, you'll need to register ahead of time. There's a
> super-secret link to do so; email me and I will provide it.
> Registration is free, and comes with a ticket to the main conference =
on
> the 8th (which I encourage you to attend, but you don't have to).
>=20
> As with past years, the agenda is whatever we choose. We'll have room
> for about 25 people with "boardroom-style seating" and a projector.
> Come prepared with topics to present or discuss.
>=20
> If you're interested in financial aid for traveling to the conference,
> please send an email to git@sfconservancy.org.  And please do so soon
> (let's say by the end of next week, Jan 26th), so that we have an idea
> of the number and size of requests before making any grants.
>=20
> -Peff
>=20
> [1] =
https://www.google.com/maps/place/Convent+Dels+Angels/@41.3827189,2.165298=
2,17z/data=3D!3m1!4b1!4m5!3m4!1s0x12a4a310123f3dc1:0x4588a81b66dce9dc!8m2!=
3d41.3827189!4d2.1674869

