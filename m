Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4D91F731
	for <e@80x24.org>; Fri,  9 Aug 2019 21:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIVNM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 17:13:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:35185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfHIVNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565385184;
        bh=Ka/W3SVGDVLP8VmRWCh2F/LllSxg7PSssyo3by+itk8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TV9qqP2h8MEfnhYTt1koXGQ92FnMHTMFlYobKClLGBNh1TSZp86d1f0QC8NYDykHA
         Pt1avPuVcNXW3c/+jmNuhGesxGijqhF//oSf9jc9G/leEaIp59vYOJyXfG+YbGhzrU
         ShMB+D5R2+E2bKRY54a1yS6hIe3HtmxTrBzoYqAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML6qP-1hvv4z0E7N-000Obu; Fri, 09
 Aug 2019 23:13:04 +0200
Date:   Fri, 9 Aug 2019 23:13:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v3 0/3] grep: no leaks or crashes (windows testing
 needed)
In-Reply-To: <CAPUEspibDcNfGk4=6Mvi2BHATGSxRPPph3F=3pLm_bLMBkBTNQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908092311510.46@tvgsbejvaqbjf.bet>
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1908082219160.46@tvgsbejvaqbjf.bet> <CAPUEspibDcNfGk4=6Mvi2BHATGSxRPPph3F=3pLm_bLMBkBTNQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m1d37yDJpt2iDLRT4TlHpKwf0a8uLS2K0oN8eo0Dmz203FNK+xn
 N9qI+pbuasatlv42sIbuqallYMK/F2icD5a4a3yYdBQL05bm8ZPTd+vvRYyRLXx4P60gEDv
 fQCwydaJPu5B3phGrdMojqfG5LeTziCUhSXdhpRXfYbb+kmpc0iDsq7/gilZtzZkSIehtUV
 srUMdnzcxHSo+InqBBqaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x75t+nYlLKQ=:l1w44DqAguOYVeENWcLlRa
 IbHFkUbTrZCB8dt/a4iHtgEbI1BAckpSiIRZZHEI/+ykL+OAwy3Ra9qBIC8dfq0Khm+DLRZ1K
 NjmMXyXfEl3EijtZ9LwRsUrj2nwscAdl0D2pqX/D/YqF/ntGjcXHg/Wl4K/8SljeSx13liBon
 9VRIhNGzvHLKy8nruX/ALm9t7CU3B497UKYwbBKU/6fJgYcWMF7hjv92peGm8+SxKWw6orJQJ
 M9tzTyRiN8xAVqPCGECEtOCp6EVaVTPDIBKH/NHmlOGv14Bc1nEleG5p8ErVk7vjodJT4UKJb
 6fjSHADE2meIo+CluOgDKwZdsnLJJRkrrhdyFPwAIOFfHll7A9c2Yo9dcUdJpYBZE1M+t1Hqa
 Oz/buejxsUycj7QtzLkNR+kkrd1rzscYfWlvH7Hon25NHgolBocSG1zM8nEBp9egsdI5bGLvY
 uf7RMDjLyb/0pBOFPOcj4KknWTS+Cc1Lb6jAky8tpxq9BJrZIMY0o9D4tknDuOwj+ufrDcNme
 dk3QE/s3L36kArQGlL8nr4g89lC3QIFIE0W2tmUghI3UtrUWIlrBAxMMnc3mAoq4sGNo061pJ
 0HtKgdrwTF2aap24nt8YMQhSyfmQVQFtAOp20LNDiaNpBakd+nhjJbDTk/UkCBLGgaZ7BTshU
 DOzxvsn7dii4Qq3dRWPD26vsf7K4GR7nWMmrCsJoD0Xn4X/2s2KBSNwqGuXch8R0c8jCUYJqJ
 x9ArWXGPx5EkCuV/4G20k+EF7tT991JiYSc2Hg79BH7/OXNK7VDzlKNCDpf0g6YDh6sByqLjT
 3P7ozR6nH663liTkdZ+aHd5A0BT/ZgYtTlqdnG0+akHba4IOgNTy5N4fS5VDAOlRGu4Jl2uj2
 fLeyt7xzzkNdF1698APMIZAZBgDqw2TN0egPyx77i59shjzbXuZUoD95kkUW1frcgyxVJgVXQ
 UfrdPMaqDE/B/UdmxkhDe+wIsfRF9E3tQPzcIhY38NwKAuxsYr1xXMbPW4rll6gs4h+9Y5Xpw
 ZTDUvuIiekQwX+LmWPwYA0ki4tdrZSe+DN92HkmsSI46EX6+H9M6KFG8lGAK8ig106yvKnSsM
 DOJLhAWHO5OYKh3oAsTObir9k9QxA661IK3/89cGfECXu8Q20WHwSIpXvmMe7Uus5FbvdpwqQ
 Dd7PU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Thu, 8 Aug 2019, Carlo Arenas wrote:

> PS. I might had broken something here as I can't see the test results
> that failed
> https://dev.azure.com/git/git/_build/results?buildId=857&view=ms.vss-test-web.build-test-results-tab

The test results load dynamically, so you'll probably just have to wait
for a couple moments. After that, just click on the lines indicating the
failed test cases to pop up a verbose trace of it.

Ciao,
Dscho
