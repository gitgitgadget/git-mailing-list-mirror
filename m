Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E63E20964
	for <e@80x24.org>; Thu, 23 Mar 2017 14:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933890AbdCWOzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 10:55:55 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36327 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbdCWOzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 10:55:54 -0400
Received: by mail-wr0-f173.google.com with SMTP id u108so149212630wrb.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VFDMVeMPBgp/DdpUVfGs9S1VArZJc3GgOZPCZIpYSng=;
        b=BDrqANWjd0Kuc0MFKMHgdbSvyfh2DAlMMA30yZLWGB0C7WCBMwUI+OAniGqFmHPyBW
         7KurxmlDD5q6fi+nzCPAZSZM8BVafS+6Y8Gf+5qnWK6MVheyQ+cnh7GXd7d683Gted0E
         NMaxc3ZP1LAGQBIuBWk0FLc9bPitgFNuSLkV7CRb0GsXfQ1fAhgIxvInv5asU5RVWw5l
         oLpjMljbZpt7eAVJvyPcQ9R5Ogh8Ldj1lzSRTaaFu52/2LgM+KHor/Gnqx8n7MQa4fWS
         1dGlNzTGfknMA+1OqCQxcPSIJtMuUjd8iadI2m8RqQ52mMwOEJVEp+4NB6+sDHUmzQUo
         ISGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VFDMVeMPBgp/DdpUVfGs9S1VArZJc3GgOZPCZIpYSng=;
        b=Q6F3z6YdZ5Cox8ZDc7U5wg1FhPLqtKMBQdaQZmvjRN801ClMVJO64Rfc9dJ+LJsXrG
         t0StPmQsEuWkKh4+HWYNFPnHCtJMmkzE1OeSXgQGUFM7akembwQ0e8IZaD+a4eA3TrPx
         4KYiul8cbcwyxG+e/0n+zMSUmh9WVuO79UlyacA6FUTMTTfoxCu9AnvcHiX2yfhHCLoq
         K8CGfhW4wlat8tSwC3lYKlp3CeoCMdOry3QNGeeiZ0UmGw3tJ9zYDG/oEoYNHfFYDqG7
         yXJOoXWKBStNGnQB2Omloueo9QH7BTn6d+0mLCPlG4kjUWUpTr5oAI59YTFPTSlwybHx
         MBoQ==
X-Gm-Message-State: AFeK/H2hucPohpbE3ref5cDUr4B27nqKZtc4qYyN+UXF1sYTpGmWSB05xGbZo26jjuTszE1dyJU7F1MHPt+Muw==
X-Received: by 10.223.165.6 with SMTP id i6mr3231073wrb.18.1490280951979; Thu,
 23 Mar 2017 07:55:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.153.150 with HTTP; Thu, 23 Mar 2017 07:55:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1703231541180.3767@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
 <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de>
 <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
 <alpine.DEB.2.20.1703221704500.3767@virtualbox> <xmqqefxpkwjf.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231541180.3767@virtualbox>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Thu, 23 Mar 2017 15:55:51 +0100
Message-ID: <CAHGBnuOJKopxq4s0e-mw0=siOERDcLXCEF4xzERpq7usbrZa6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls commit-msg
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 3:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I know Sebastian well, and I would hope that he lends his substantial
> competence to making sure that the changes that affect end users are
> correct and that I do not introduce another regression.

If you'd really know me, you would also know that I only say something
*if* I have to say something. I.e. me not making any remarks regarding
the C code means I did not find any issues.

> Besides, he is German, so I tried to spell it out clearly what I wish him
> to do in return for my addressing his problem.

I fail to see how this is "my" problem just because I happened to
notice it first. While I'm grateful that you've addressed it timely, I
believe this is a naturalness since you've introduced the regression.

-- 
Sebastian Schuberth
