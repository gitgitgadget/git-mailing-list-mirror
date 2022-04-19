Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56BC433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 04:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiDSEl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiDSEl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 00:41:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ABF2BB0D
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 21:38:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bv19so30458296ejb.6
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 21:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8un2P7JYVyAqYLmOtHbCfbtSvrUz2dU4xPDVG5ePcY=;
        b=a+49Rt+53u/aZF/y3E+0eBnfcXcEuJrucKBFXG4KZbbkg680qf5G/+X22JcHJwKJvC
         daJrI1UHXg7N/bNnWobS/e2iPJqQwXhkfy8s1j7RBiD7Gjed5zLtPQKqbwy7rSZMOEpV
         1zDquQRShnhcKQ5A9LU0W6ps693ZRN7d5nAsfkT89u6i28XRGKzma7cKV5gAl8PBBbGU
         ZHR12AXUXSZR5OfcLXcIdR/uNzgRE8677edcNM3ZSTz1d8JE/MAC/AZ3/ApuuU/Bgkst
         a98oYqANqieQktUZaqANI1h/UAGrdBO12v/I7laAdl8JRMhHODHdpTYQ2lEj8ZZYX6Pa
         3Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8un2P7JYVyAqYLmOtHbCfbtSvrUz2dU4xPDVG5ePcY=;
        b=qcUHj8o/pp7LPbGdNIceHKJM8rp+nqb3GhmbPDeIxTmKD7rBOcuRlR6aI+Ptl4fDWB
         wmD9+025qPSLHrvB48zygDraPR/37i4M4T4VU5I8wMKc+Io8nV7hGf/6Pn+RgA6Dw4np
         c+xzXdW//jescRA4LbwoXrEEIS6G6Gkhx7gKqL8HPF9h14bYNMrPHXy395+UR0VHjcCl
         n9F6VLJnnyOEbO2w5nmbJyOwG54D/88tjmavkPZNp3Dbkc9ghUl7ALXVfmELasVh8n5b
         YFyvSADpr+00sWtttpy1o+X5RRvzT8OnNOIR0q2/7FdfDlv3x3Sb4lEi3F57YAREzayz
         OyeA==
X-Gm-Message-State: AOAM533x88UR7dKFaLOOD2IOLTWxalQ6iBKwcWCgY//zNhr5tuZeAiLA
        V1mc14NpLOOB1m0Y1krzE6STLx/UdcLooON2nVE=
X-Google-Smtp-Source: ABdhPJwOpwWdpxjRHpLIVKjBlJyzQnk4jGv1YOz9OAJSfUln/BL8bIWPDLH9OYy66dFAP77noI5Y5Pn3KIBUjL82KTM=
X-Received: by 2002:a17:906:dc89:b0:6db:a789:7563 with SMTP id
 cs9-20020a170906dc8900b006dba7897563mr11425760ejc.471.1650343125707; Mon, 18
 Apr 2022 21:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com> <20220418180616.14954-1-chakrabortyabhradeep79@gmail.com>
In-Reply-To: <20220418180616.14954-1-chakrabortyabhradeep79@gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Tue, 19 Apr 2022 10:08:34 +0530
Message-ID: <CAC316V45LgOYSEu=iGTAXHqeNyCVUHE-Dg_sr1vzfJMr0Zg7ww@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,

I submitted my proposal after fine-tuning it more according to the reviews :)

Thanks,
Shubham

On Tue, Apr 19, 2022 at 5:06 AM Abhradeep Chakraborty
<chakrabortyabhradeep79@gmail.com> wrote:
>
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
>
> > Just a heads up that the proposal deadline (19Apr2022 18:00 UTC) is
> > approaching shortly. I noticed that Abhradeep has submitted his proposal
> > so far. Others, do make sure you submit your proposals in the GSoC
> > website before the deadline. Only then can we consider your proposals
> > for GSoC [ref].
>
> That is the initial version of my proposal. I will submit the final
> version soon.
>
> Thanks :)
