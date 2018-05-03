Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B36200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeECUPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:15:50 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:38832 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeECUPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:15:50 -0400
Received: by mail-yb0-f182.google.com with SMTP id w14-v6so6954321ybm.5
        for <git@vger.kernel.org>; Thu, 03 May 2018 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gLaBeUBajLpBbVsBNlBp2sU+Vc19Fr36MePftmvPS+k=;
        b=j3kIOu/+1eejM6l/og5zfdD7qgR+Gt2ddFmHd1Zik61Y/Zh5LgRDQVWiWrlGmafuy2
         lVuJB47ub0F1t0FBVrXSngruZPwRaAKmKmkXFKnYo6NbwDZ7K6Wc5/3l/A5EbptBy2FS
         YjgkC5mD7IHtHTG9TknJJN0k3S7/xTgLhfsjEQtBS+U5SduIwLCKonA0oYWSs9/cUgtU
         u+Lr+gzdHZCyll4r2r2llHCvi5ukaGfT4kfYvacl/+algcT2gm+ZrO1Ig6m+0FixvFVS
         WXs5klQ3PdFo5GDGkhd7/PdbTMNYadVjg3PYcG8r2wTaVm/LZB0Gyihq85WWUMsVv6h6
         zyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gLaBeUBajLpBbVsBNlBp2sU+Vc19Fr36MePftmvPS+k=;
        b=FUSPavmJWMPla1/mTvJ68QGVnyGIHJS/XyZbHAkmhvqam0vJYGndyGGl5lOg8H5rhZ
         PDQ+ssvUkdQw4kb1Mcgo74PZoVYjir0FUrDj86MJC9uD5mieqUF/2TQfMI4ScYtjF7mJ
         8sVCH1JewPufAeS3I0DP2m4GbreKE/9q48RQnksN/VvIvbMgVcf1QH6K9S1+ZbBRnto3
         +sPQuhS1Tsx9mkU9T/QD/lfLwYrdqIrUSCgZtYAP1x/G6hy8K/+T+jxPWND+udftDV5e
         vlBE0JyWbX9YItneWz2lhkShDxpN1se1ccV9APf2a2feXEnX4ZYCgxpAUe/SakIRqX7D
         Q3sQ==
X-Gm-Message-State: ALQs6tDKwpgFJy5f5nbMWej3AecIH1D3Q3aa4uLTN8iBgKppFJE10uaM
        Qjc1vIUddpvY2NxMaQw9q5zM5nI8cec7G32K49C3zwEG
X-Google-Smtp-Source: AB8JxZp1TnxKxyF1kT0ckvNdg/PfpANSpWqGddG7gcRwbnMuWDFtWAoEWPew9M/JC5krBB5A0C4vjw1HAdsrHSJJyOo=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr15688361ybb.334.1525378548976;
 Thu, 03 May 2018 13:15:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 13:15:48 -0700 (PDT)
In-Reply-To: <38aae093ffc23f886ab4aaeff72eae5e7c794df0.1525220786.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
 <cover.1525220786.git.jonathantanmy@google.com> <38aae093ffc23f886ab4aaeff72eae5e7c794df0.1525220786.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 13:15:48 -0700
Message-ID: <CAGZ79kaHHNVW+Mj=RkQsWmc1ta1GPRLQaZR7aEDe6PAr_7wD+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] {fetch,upload}-pack: support filter in protocol v2
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, May 1, 2018 at 5:31 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> The fetch-pack/upload-pack protocol v2 was developed independently of
> the filter parameter (used in partial fetches), thus it did not include
> support for it. Add support for the filter parameter.
>
> Like in the legacy protocol, the server advertises and supports "filter"
> only if uploadpack.allowfilter is configured.
>
> Like in the legacy protocol, the client continues with a warning if
> "--filter" is specified, but the server does not advertise it.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

The whole series looks good,

Thanks,
Stefan
