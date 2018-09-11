Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48E71F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIKVFm (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:05:42 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35105 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKVFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:05:42 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so4015605iob.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hs824dLAjANBVIY1p9zS9zTVHzyQwhc/4rQkPDCCgiw=;
        b=BHnAieVnFycqDVxNs/nIPJD2ctznUed3KMeSsu33Db9kWrc3nIS1Cbh4Q2pVXvleFJ
         rH+KLJMuBfO3u03r/JwuFCc8/H7UwDkLE7R86nmSFcWmWqFCkgQlTCTMKeCwef1oNdCN
         n8pnTnOasOj29Qt1/AYGI3eLHGVc8OKygRPV4WFAxqXHwoDjkvjmpPpPyK3hz3IhNtPY
         qHAsBRmW23YvBLByHzj9tZpPeDvQ1aZCs2dmbDwIEUxJs/+4VY4WCXcYIjHeuSOmgoCZ
         OezACRfDTSpQMpDLSgYMW+JbFwLOBsY9VV82Bur4qVAQH5A3v604z2IMFeYehHH8vHLx
         iN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hs824dLAjANBVIY1p9zS9zTVHzyQwhc/4rQkPDCCgiw=;
        b=Wdkfx4vgVLS1fjLYFVlFnWAjSyOSn0OdzgFwi2nRh3R27nIU62HrBKpKP+blX+I9gp
         GQZl0mpnoAC/lXNDZFL+khwpl+j2G/4BPksYxjnh8R+GHNKvU3WoRTS2sw0LYkni/lZO
         HLWOwAsF7yMK4V6ef0xHkZJnZDLr3ziKlgP9F3XR1czIO1M5T5cOEBpz+KlEvkyfhl/r
         bM6Go28GElPk5xXg4U/mCnA4AcrF6LLzefLKwrYc+KTKjA5ei/JZzCX2SIvxq8l2UnxD
         Mfh0lcWSYnaTOBKnLSo7FRFNBFXct+ZVFtkgDUjrivssHjHn8O4C3p8z+wdrZyrxmqrV
         gzGA==
X-Gm-Message-State: APzg51DyFtSHynLzMafyVXScLyXBH6dzjHtjlTrVUisenZxr+yRJ1XJ+
        LvYtFyJcKyKaUhxhE0VY/TBqcfJRDEpBpG9OuSU=
X-Google-Smtp-Source: ANB0Vdb0Cj3AGK748IyZ5WBRlpx0RspgFb6zCRw4Bx+W79QRudOjyjQmDaATiBYcxM7dqWUPIvBedanyeV7rVCM2epw=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr20092753ioe.282.1536681943384;
 Tue, 11 Sep 2018 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180932.32260-1-pclouds@gmail.com> <20180909085418.31531-1-pclouds@gmail.com>
 <20180909085418.31531-15-pclouds@gmail.com> <CAGZ79kYS2bTFowEYwH6t9sBAAZ=ikMn7eAut8O0-6NdG=eq3dw@mail.gmail.com>
In-Reply-To: <CAGZ79kYS2bTFowEYwH6t9sBAAZ=ikMn7eAut8O0-6NdG=eq3dw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Sep 2018 18:05:16 +0200
Message-ID: <CACsJy8CHXvYgh5WACPbB=6jwqDTTtcVTJ5eAQ3pMYxQBySzaWw@mail.gmail.com>
Subject: Re: [PATCH v3 14/23] patch-ids.c: remove implicit dependency on the_index
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 8:50 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Sun, Sep 9, 2018 at 1:54 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> >
> > ---
>
> Junio would have to forge your Sign off here?

I _knew_ I missed something in that "git format-patch" command but
couldn't figure out what! Will resend (I have to fix your other
comment about init_revisions anyway; my mistake)
--=20
Duy
