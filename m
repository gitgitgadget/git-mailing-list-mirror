Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9892202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 03:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbdJUDHI (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 23:07:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:51139 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdJUDHI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 23:07:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id b6so13401155pfh.7
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=lF7BebaOUbIEznkcCH2VmrAQAnwZz/jPdOI0WOgZa2Y=;
        b=ft0QDpcuCi0OdxlGjQioOz5Iw/odM8HE1UP8vwRQd7GuP/BIFJQK+MOAV4UrwKueyO
         rK2IvSZEMWBMFEGGfIoEBcVuE5rP5Vn/M/QTeusXquJ8b7pmLW7WvU+DefoQxlKzoHE3
         GdCgile2uIGM8qPYXc2HGMtTtvwPlebds1sOXLJVLDM3/cJYDy3p6d+vtHOI5o/KD3cV
         H38SVuFfrtNXApOxnDld1sfrjFozTDzMcCp8meXlR2DBvb/wQUkpwnbXALhSGslOs6Yj
         q6l1+yHdbQlVyLynSIEyPVrxTvMkse7LyJuqDj2ol/GeFbrHyJAizooLXJx9zQum60vv
         +Q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=lF7BebaOUbIEznkcCH2VmrAQAnwZz/jPdOI0WOgZa2Y=;
        b=NjL2MHgTWVxwyINsvjjvyOFrUTXRFOHmdkbUnitSSDQSolB1S/GFdxslT4vp5yAss0
         iwE9kt4E5CtzQdPDIMQw9T78qSGXfBUpjO8rEfRrwSFtV3jVvy8hCHOgzgCV5/0cm8Qy
         /e1IW4uW4tX7q5J7Sg/c+303TKRhFXMnGh5a31rNwehpXCQxYW115BIWEZ0PkXG23sXg
         QAC26XHdWq0st9mi/FAafJrX8mntdKHwdbsg6K3x3wTN5kRI/XtVhKQTE22b6mBU/XAq
         Pa+fy6RVnyqSY08tagRzWNCuHmZ40QnZ01RO1xx2djVpdHumccDuXE6ESNbObNyoNL+Q
         zxpw==
X-Gm-Message-State: AMCzsaXkDW8mRJGNpKYoNVnRlKWdf8QDpMk7wvr/1X88QFQYaBO6tpqc
        phrtcq8kQ3Rc85k+zF5SQvc=
X-Google-Smtp-Source: ABhQp+R/JvmMinNS6jJE9pDj4ja9OWZUDx9Rq1u/mYVI2iyt93yPnaK/IgZQV+0GWNuP1FW2FUDnNQ==
X-Received: by 10.101.64.140 with SMTP id t12mr6290928pgp.305.1508555227607;
        Fri, 20 Oct 2017 20:07:07 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id e62sm3384286pfa.51.2017.10.20.20.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 20:07:06 -0700 (PDT)
Message-ID: <1508555222.2516.11.camel@gmail.com>
Subject: Re: [PATCH 0/3] a small branch API clean-up
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <20171013051132.3973-1-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 21 Oct 2017 08:37:02 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-13 at 14:11 +0900, Junio C Hamano wrote:
> This started as a little clean-up for a NEEDSWORK comment in
> branch.h, but it ended up adding a rather useful safety feature.
> 

Part of this series seems to duplicate the work done in part of my
series that tries to give more useful error messages when renaming a
branch.

https://public-inbox.org/git/%3C20170919071525.9404-1-kaarticsivaraam91196@gmail.com%3E/

Any reasons for this?

-- 
Kaartic
