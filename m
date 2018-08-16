Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2823D1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbeHPSJu (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:09:50 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:54428 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391394AbeHPSJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:09:50 -0400
Received: by mail-it0-f49.google.com with SMTP id s7-v6so6709150itb.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QVDFgoTdqlTpiFViFMtZ39pESptl4Mb1Jqb9kONdLes=;
        b=Akw2Y1Li9+b8mgDudRDdAOpfptffaLL3pEhbSvvqvRxW4wnAgW+Dqo3IcwneU3WqVO
         RbqXuJB3ibb1W6A1FGblq9lT31DhYD3Xi+nA2JjtpX9Cj7hwyx50exyeRCAsDAGnqSsv
         XHQPgVBXB2Q+vPRjCNckFbk+nVgea15LZJ2t32EKAtunLCSwFcEEhg8nee0OESAlrZog
         /s2z01TezJ2zKHqkmaZU5Tc7OybYhgVmRRpJVB/vUSdlesYV3i8ofCqbk9Kk+jjxNv44
         vDiJcDItRsjTFcSHbRAGcNaIv7Kr1OwGX4dPNjMzQxmGtpQ+KQ0JcMBTXBCZXrlvnmnz
         r3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QVDFgoTdqlTpiFViFMtZ39pESptl4Mb1Jqb9kONdLes=;
        b=iLv6/3CyWf7+XGm1WwhjTqGanQQz9nkejwK9HfqRHaAm52NlKWCCn1AltdD1UXbURE
         Kpi0SEsG/FKNLDLKbdkb7+IavK/epfu7+d0Z27hdXkkNG3mmG2SoNa47yIEZZk04WU09
         258mHQ66EhMAtxZ7dxBgyQBSLqXu8lRaowsY+nIi9G0UhLa9ovHCx5rnnFZQCxdOPVgL
         hy1JK3DXT/5zSUCCbp/P2sGBivb9opaa1khfc5BY4rbt98bRjdibhqLtuhngUzlEwtAX
         bGzR7+l/P8ggi1gghMJxCjLciot9VU9OaMVGkl51qh3mMvH2HIdWHPY7mKMKQ3946wSc
         vh4w==
X-Gm-Message-State: AOUpUlEVbk2j2SK7LLO7ZVoRvPg0oWxKl1FwqlNJ0lCvJmxEVxE90lDJ
        0yoGEl/3jptd8e1AhRyOGygK6wNv/3wDciZb8Eygk0s4
X-Google-Smtp-Source: AA+uWPzfvt2170E3Li7rw2bvIJpShPjALZ3mrSBXc+cCMfIppifshVuewisEVy/vixu6shSQCZRtGH3obKeoKT3CfYw=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr20974486itg.91.1534432245291;
 Thu, 16 Aug 2018 08:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir>
In-Reply-To: <69624916-f6ba-d4a4-e346-69498662905e@hadisafari.ir>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 17:10:17 +0200
Message-ID: <CACsJy8At828KS_U+CzhujtJXn9Ma+p4fbmTm-72XsS28Hj62oQ@mail.gmail.com>
Subject: Re: Incomplete bash completion on git commit: --allow-empty-message
 and --allow-empty
To:     hadi@hadisafari.ir
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 3:50 PM Hadi Safari <hadi@hadisafari.ir> wrote:
>
> Hi!
>
> I'm wondering why there isn't --allow-empty and --allow-empty-message in
> completeion list of git commit command.

This is because they are marked "hidden" in the code. If you do "git
commit -h", they will not show up either. =C3=86var provided the reason for
hiding them in c9b5fde759 (Add option to git-commit to allow empty log
messages - 2010-04-06), basically "not for normal use" so it makes
sense to not complete them. If they are used often on command line
now, then of course we need to reconsider to stop hiding them.
--=20
Duy
