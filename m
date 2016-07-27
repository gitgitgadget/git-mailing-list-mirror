Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9900E203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 08:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcG0IVR (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 04:21:17 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33665 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbcG0IVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 04:21:14 -0400
Received: by mail-pa0-f66.google.com with SMTP id q2so1360853pap.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 01:21:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=twK/N+0LgxUFEcvi/dGKMmCq/MLFOKi0t8Kdjd2qfp8=;
        b=0Dzq5L1RSGYGlmESEHICp4+/3TfpnImQQ/4hy0iZQXEXyUyGp2nCvlxuE0EHxQcY2Z
         bJgJvj6vYtTuX7VS8XaX6IKuoDxb3PjaF06pQnj6A07Ie+7z/2ZNDiM0PdYvO9t8dla1
         ZwAdvudflUFuLzZ5Zl6OoFTTQ9m0E/MfKbPgnomPZRSmA+MJ8AzEdEvktVnRFi3dtZvo
         s7Dd89gF46KPdA2qxvezaLnE7MBVz7IxHfzvsfDM261oUQpnlsqjN1GdUzQx0SyXPrSM
         gwFZOfjJudF67LWU8B6GEjxvkuQsde1I8iYy0YI6PpE+hM+pDOB2VUJg5tjyIZv2wTmT
         it7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=twK/N+0LgxUFEcvi/dGKMmCq/MLFOKi0t8Kdjd2qfp8=;
        b=JN3z1AOekqV3AHjAoXYiJ1P9fpHCCOvMjDexdDRqL8JVhLj+EQA+hyfeD0xtfR0cVb
         /B8g4wnw4OQAeGQQLFTqNCdrTH++nUkXPIqYekH/Z6jXaWFKL6uGjK97Bw0Lf8a2eVaW
         duleEzlwJH80yzMMcIjjtdS7EpxplWIS63kU6aMxPxcunHw9mLXcTMEN869MDuv3g7bh
         VyQxnolACKmGYjE6i9ffvIwzm0Dut1WDOQuYdoyRL3gcjnZ4sg4KfmskfR25HKomfEN5
         o4tXMXJhRoo9R2Hv6Jy02ZiLjqwtz85ayvSKzcafh9xL4551eVrEfA8PRGjImaKENLLL
         QRag==
X-Gm-Message-State: AEkoouunZ0I1BFLEdNVXorTS1jDGouFAuYHN3UbiJDidjcv9XvI6d0xPB9ljp2qAp567Ww==
X-Received: by 10.66.161.195 with SMTP id xu3mr47172904pab.68.1469607673467;
        Wed, 27 Jul 2016 01:21:13 -0700 (PDT)
Received: from [113.168.13.52] ([113.168.13.52])
        by smtp.googlemail.com with ESMTPSA id a5sm6811639pfc.89.2016.07.27.01.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2016 01:21:12 -0700 (PDT)
Subject: Re: Very Very small fonts in gitk
To:	jessie hernandez <hernandezboy@gmail.com>, git@vger.kernel.org
References: <CAKEmgc=7tyb8FVpoD5yO=s3NMoGeQWr3A3WMPUXv1N+s1A7g8Q@mail.gmail.com>
From:	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Message-ID: <d10f574d-20fe-cdff-3d4e-0d17db5b1c86@gmail.com>
Date:	Wed, 27 Jul 2016 15:21:10 +0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAKEmgc=7tyb8FVpoD5yO=s3NMoGeQWr3A3WMPUXv1N+s1A7g8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 27/07/2016 15:05, jessie hernandez wrote:
> Dear git,
>
> I have been dealing with an issue in gitk for a while now. I do not
> know if this is a specific gitk issue or something else. I cannot find
> any information about it online.
>
> When I start gitk in my repository gitk comes up but all the font and
> all the menus are Extremly small. (see attached image).
>
> My OS is Red Hat 6.6
> git version is 2.0.3 (i tried the 2.9.2 version also and this too
> gives the same small font)
> I am running in bash also tried in KSH
>
> Could you give an insight if this is a known gitk issue or that this is a bug?
>
> Regards,
> Jessie Hernandez
Try to edit gitk configure file `~/.gitk` manually, like this:

set mainfont {{DejaVu Sans} 12}
set textfont {FreeMono 10}
set uifont {{DejaVu Sans} 12 bold}

I hope it work!
Thanks,

-- 
Trần Ngọc Quân.

