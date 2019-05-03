Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A60B1F453
	for <e@80x24.org>; Fri,  3 May 2019 04:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfECEQD (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 00:16:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51029 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfECEQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 00:16:03 -0400
Received: by mail-it1-f193.google.com with SMTP id q14so7165888itk.0
        for <git@vger.kernel.org>; Thu, 02 May 2019 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xZZ3KuI8d0VHvDb6L/sJFZao2FPwvDOHRsHkPh2fHOA=;
        b=MQ+A4N1kzo20EeK33vQ7wHa8XJA9EgfIswCk8d/DrkfwqpAYJAD4/NVDIUJ2YNuPfS
         S6kfa8+Pe9PMqBOPeg1Rx630ELx2E4YXOJf/8pabHsClDboAJMSxv5fAJTNNnycRIJKb
         ySq8Q/sxrhECSEgNtP2FhQufPTaUxKrs79Nv5s1clmdX+bu0vbVcEfSD3iUgnI2YpD/s
         2eIvZTV9QSM7dxPDoA7W3wy1sicUqTIgvpAsj77HeUmJcMScqOfo4eumqaQ6vOdJK9+K
         lZ/9CN94u0VlPSJtyIEfdTPdfkWNgU9UZHMlyMUU7tFZua64QBtDkgBdPnHddL15qu13
         bI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xZZ3KuI8d0VHvDb6L/sJFZao2FPwvDOHRsHkPh2fHOA=;
        b=oNLtEnzIGPAd40h7ec8A1nKbsqtgYoZMYj8NyxbuLfYBQksdfiERWl2XvkhsF1OWPu
         gMGPh/naIjzX814UIeO+syz/J5a3AISZO8SqcWMpsgtdPGy44nul5b0rrTby7O89Jy9Y
         4+iSPLFFqTFgG2FIHPyqs8sKd9Xx7MGO/P2FBWBuleaT3+JFe+JzVi2LNPbGBEO4reR8
         zMf8KtmW0kxl3im6AeVf06ei7Wu0OH4lqHeWJHCzglrPbGp02lp50OvwDoue5SHoxTIX
         Fj3k5Yh1nN0CM0kkDtW/J+PwolbwFub0UuEMBTsM3k+jt0fCg/gSspZgBpU0U9D6DDiC
         KIeQ==
X-Gm-Message-State: APjAAAXdzY29pulkUKNXKc+Q6DLV5Q4AgWZ417vwFx0TQQT3yOsCZwKv
        /+ptRd25IaY1tL7AGd40wFBGGcgiBSXr7W9KOB0=
X-Google-Smtp-Source: APXvYqy+QrYBIuVQx0rz8WTh2mZj5GGFJ43DP7J7alvkWBRgij2k2Pj6Z+jKPRLGwdpPmlcqMHnpeLzf6Moih5k9/mI=
X-Received: by 2002:a24:6292:: with SMTP id d140mr5056017itc.12.1556856962380;
 Thu, 02 May 2019 21:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
 <20190501234512.GD202237@genre.crustytoothpaste.net> <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
 <20190502231537.GE202237@genre.crustytoothpaste.net>
In-Reply-To: <20190502231537.GE202237@genre.crustytoothpaste.net>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Fri, 3 May 2019 12:15:51 +0800
Message-ID: <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>,
        phillip.wood@dunelm.org.uk, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

brian m. carlson <sandals@crustytoothpaste.net> =E6=96=BC 2019=E5=B9=B45=E6=
=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=887:15=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Thu, May 02, 2019 at 08:35:23AM +0800, =E6=9E=97=E8=87=AA=E5=9D=87 wro=
te:
> > Thank you for the support! I'll be very happy if my patch can get into
> > the code base. Is there any improvement I can make for this patch?
>
> The patch seems sane to me. There's less duplicate code than the patch I
> started writing; the goto conclude seems to avoid most of it.

I see. Let's wait for more comments on my patch. Thank you.

Best,
John Lin

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
