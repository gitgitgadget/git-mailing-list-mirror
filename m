Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570B01FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdJFOn4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:43:56 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:47927 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdJFOnz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:43:55 -0400
Received: by mail-pf0-f171.google.com with SMTP id u12so9660876pfl.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=PumScc90jFpXd251H+PWJZ7Alhjpl46YSXwzwe+G3gE=;
        b=edGbJU56hsjOhS9m4TvZovHTnxPsV4EOXMRuflFITouQT/uyCLDkzNXZsXvpavv/zx
         ANDmOv1dFHXrt9JfJ8v+Wd5FFj9geZcZieZ82OHjRVdBTUpucRfDGrt5am8cFuewwqYE
         chmg3YeyJQxVYaw88+EdYnwueappMKXs/AkBc70bhQ0dfRbIo8YR/LQElYfOzBr/a8eC
         6+GwGHZeG6TJ0sMmBAeeIxZOIaWsslapWXkoRoyFzl1YE2xVmRYf6LXjTSbAUHwhSMlh
         8g7ZtTDyjeBQsqqpg5RORzH6TpwYEzVG9xVR15kyLWVKmQe6tfmm7D3P7PpqjerSb1dd
         ginA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=PumScc90jFpXd251H+PWJZ7Alhjpl46YSXwzwe+G3gE=;
        b=GFsdOK6pldZKpuUXjLv773IiD53paWCPQwHop4WFtB99+f5AR6WAU8AhYjJbtr08kr
         WGrnrBCWzkWr0/M+OgWzFtZR18Ojatdoc/RYAyd3dtNJDEeTiSsJselBCsj9uMjPC5A2
         /wql+9xCxDbA284bjHemK6vlqKHkHdIbWCQRF3pJI9muPTDfmoj/gnhZjI4Dtw5cH14+
         c4jvBx3cz1zAVr8HsjkgYF64P4To6iMxt/hqXjc4ZoqYuBA5wogtgqLU0B6OvTPUkHDj
         GjK35kIvxBjhwuqlbQuDB+2YrX0vdL/OhB3nQqQHVEMIx/IZ0BmPkSd0gbaBQc+MjZrc
         CZTw==
X-Gm-Message-State: AMCzsaXr/x8NOmdHRHaLuQ51i09XTeJcSihqWKhZo66IKYZ8fQQKIBIq
        E2JeV4HWD2mHfD2T2OMltXaNo/hv
X-Google-Smtp-Source: AOwi7QB874bCJm9h1wmyaxh7QvZYtKPrNYt3m0+Ig7Nz3orrFi5hdvLYh3nqgVK7K9YqUAS2azjLlQ==
X-Received: by 10.84.253.16 with SMTP id z16mr2180840pll.210.1507301034688;
        Fri, 06 Oct 2017 07:43:54 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id p6sm2908984pga.93.2017.10.06.07.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 07:43:53 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam@gmail.com>
Message-ID: <1507301029.12554.12.camel@gmail.com>
Subject: Re: git send-email does not work with Google anymore?!
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
In-Reply-To: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 06 Oct 2017 20:13:49 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-10-05 at 12:52 +0200, Lars Schneider wrote:
> Apparently that stopped working today. I get this error:
> 
>     (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from line 'From: Lars Schneider <larsxschneider@gmail.com>'
>     Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
>     5.7.14 <https://accounts.google.com/signin/continue?...token...
>     5.7.14 ...> Please log in via your web browser and
>     5.7.14 then try again.
>     5.7.14  Learn more at
>     5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp
> 
> Of couse I tried to log in via web browser etc. Does anyone else use 
> Google as SMTP server? If yes, does it work for you?
> 

I thought I was the only one having this problem. Seems, I'm not alone
;-) Until recently I was using the email address,

kaarticsivaraam91196@gmail.com

to send patches. Last week, I got the same error message you did and
tried to fix it in various ways but failed in my attempt; got fed up
and switched to another mail address I owned (the current one) using
which I'm able to send patches (surprise !). Fortune for me as, it
wasn't a big deal. I think this is an issue with Google.

(I still don't know when I'm going to get the error for this one. I
don't have ideas to change this one.)


-- 
Kaartic
