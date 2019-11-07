Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376DA1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 22:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKGWCL (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 17:02:11 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36229 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGWCK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 17:02:10 -0500
Received: by mail-wr1-f49.google.com with SMTP id r10so4868132wrx.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AHMR7+PIZsLihpj6xWDqHt3lumbSudsi4FTjckhV1aY=;
        b=I/B4hJEgX8mkqlqfK0bprBiUcEuM+cHbCGuTT+yNdJRMwkqpNqLTcWhD2KDJbX5PjX
         ew4yT0ePhs0JrpsOridEiNKLpLqxpE4sM8Rz1C1vlByrYVW6FaEKpBNS/694+SmPaofZ
         5Zy8LmSkRF/9OWSzGfXka/3blYzOpcrs1tIDQbttT6OY8cJX74wJUfdzOJo1cukQff1f
         QLG/v9RrOcD6uy+Kf3w7b0Sq3RBExj7JESuPWJj/TXhna5Q/q89glqGptWvubLWPGJWr
         Vsf0hBDofxwa0MAZqorndJJNUAussh1hgAc/zdJsanVIHQ+/vYK61X0dLS8tKdrECEmF
         rkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AHMR7+PIZsLihpj6xWDqHt3lumbSudsi4FTjckhV1aY=;
        b=dm1pnyTp89laUSr49+Hso707xxPEZ9ZEWAFChKT7koiXaFS2xrKNKuA5UOUd3XV3Ce
         V7uDPRPY/lsXi+PmS09vOA8V31q/LNAxmWX7ODIZ3zwaYrnuOKUavS5tca2C5vGuSZVz
         NkgMQEtb+LYznYHDuupr94JMTLdeAqiUwjTqLaOUdNl44N1eauovc5o9fCc/PGNZ+DT7
         cDjkPtiPFCWGjOcyNw/HGTK4rXQFILRSR+M6dNUBhRpBluwWatviXR8i8bBa8jEwRRx6
         oQWmApJSLBwxLZVfHIU2lHvlvVIT8Qqn+7fluWGJGeDiHekUujSE/DjNiXV0ypB7q6Kk
         tO7Q==
X-Gm-Message-State: APjAAAWxhjruz/MOAJYvvfgM35bMnsEjhBGShvveXRMJUrjAoM4SRMBL
        rCrCN83quPx4kh8Q5opPvu22G+D0mOw=
X-Google-Smtp-Source: APXvYqyvLsqFs8y80n6geDM3z7XZTLcylbMlJit/G+VfmuaXCg7xeScp2Apk6tdmEHWM8kbc5bNEBQ==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr5545105wrw.82.1573164127898;
        Thu, 07 Nov 2019 14:02:07 -0800 (PST)
Received: from broadband.bt.com ([2a00:23c4:bf00:6100:9c55:264c:a4d1:af7f])
        by smtp.gmail.com with ESMTPSA id o187sm3447242wmo.20.2019.11.07.14.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 14:02:07 -0800 (PST)
From:   Luca Milanesio <luca.milanesio@gmail.com>
X-Google-Original-From: Luca Milanesio <Luca.Milanesio@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Git Merge 2020
In-Reply-To: <CAP8UFD0WXrG=XbZj9fyo1v0zy8p7yNnGZGVH8bHDqPOLThGD-w@mail.gmail.com>
Date:   Thu, 7 Nov 2019 22:02:06 +0000
Cc:     Luca Milanesio <Luca.Milanesio@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C3540BE-1F56-46F2-86BF-40AF5E31E544@gmail.com>
References: <CAP8UFD0WXrG=XbZj9fyo1v0zy8p7yNnGZGVH8bHDqPOLThGD-w@mail.gmail.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 7 Nov 2019, at 21:54, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> Hi everyone,
>=20
> It looks like from https://git-merge.com/ that the next Git Merge
> conference will be in Los Angeles on March 4 2020.

Thanks for the info, there is only a landing page at the moment.

>=20
> It seems that the conference will only last one day instead of 2, as
> it looks like workshops are going to happen in the morning instead of
> on their own day.

That would make the attendance from Europe quite low I believe: it is =
quite hard to justify a 12h flight for only a one-day, of which half-day =
is for workshops :-(

Do you know if there is any reason for having such a short conference?

Luca.=
