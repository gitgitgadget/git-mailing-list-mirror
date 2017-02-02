Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C261F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdBBJ2C (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:28:02 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:36468 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdBBJ2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:28:01 -0500
Received: by mail-ot0-f175.google.com with SMTP id 32so7559966oth.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sj+VfqYhfSlgEigG+eDK8X/XYp0CcbUmXIN/N2w4Oz0=;
        b=jOxbJuKJRNgOHKKs2taCxoFwNLLieVqLFq/B6FbLSyRxez0errFZc/dOEkplzDzWs0
         6UPI07eTFBQj4fQJpEfBzhz6S/zhCAUXqkybF+yIS9YE2eCnW2XFfN4Du1U4jcxDBiO6
         Z4IfqOrRsZz1PKDMOhCfksSiVvX+lQgv7E9DaLcpHhoVERQEAP/X19bQWXRHLEsw6Ag6
         1q9OfxHWtJaXcQPhu2mCy8pCWmhXJ2FX1z7BgZjt/D+1erayXnm8a/uI7jfSAGyere6X
         8KcIVqlcPdyTNz74etZrT5d+WGukXml9JH+ZYSB4wROZM7Q0K6uzm1A/s1Ke01S5WE0v
         1/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sj+VfqYhfSlgEigG+eDK8X/XYp0CcbUmXIN/N2w4Oz0=;
        b=sdOGlpfsMEYWjMpjLlO2uwd03YRUgKB4rON8y2H4vEFPPgo2usfbR25kb2CjIkJ9oV
         5gbApzZusmcM0Ekwz809Ie39h5+P3a3dI1Vpj0FOIqHlk2KAWP+3NHIKnR7/3o0x0yO9
         eD9SMywdHDd5Ia2ybg5qpZbJqpbn2+htLqF1pckQbOSp/HfSNY74atlJ/90rmJCMniHU
         tPl8AEZGaFgc5gv2HYWmv4TozPpEtgzYN7OjZubhSgf16nZCq8T8La32MWGy/d34vVk9
         vO1iMcCoaFv+nPfyRE3Z0MQRDyllTSDYft43GyXO+CpdUa7sGD3nE+Wd6oBAzoWqdib/
         rY/w==
X-Gm-Message-State: AIkVDXITQfdksHWORVrnHg3QPRMNQ4VH3Ub7CplBv9GJf+SKumuw3HX/glSE1iiYgpNT7e6tGfC604oIXjazrQ==
X-Received: by 10.157.46.57 with SMTP id q54mr4142053otb.28.1486027680645;
 Thu, 02 Feb 2017 01:28:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 2 Feb 2017 01:27:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1702021015160.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Feb 2017 16:27:30 +0700
Message-ID: <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 4:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> This squashes two changes from Johannes and Ramsay: [...]
>
> Sorry, I lost track of the worktree discussions... Could you remind me
> which patch is supposed to fix my continuous reflog corruption?

The corruption caused by git-gc? It's not fixed. All the changes in
this series is shown here.
--=20
Duy
