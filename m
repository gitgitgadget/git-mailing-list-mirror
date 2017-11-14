Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40E0201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 06:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbdKNGqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 01:46:52 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:52648 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdKNGqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 01:46:50 -0500
Received: by mail-io0-f174.google.com with SMTP id u42so5288943ioi.9
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 22:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1NvBbUj3Oa5o3VmefLenJ5aY8W8q5IlntRG8fHLCioA=;
        b=EoVvgvtb2cfzKW2PZFhDfna+rttXDNGt//K+nfx+Avi9mRMBtJzXMJZjkJpVwJPKXz
         AZA7GqOGyT7YuvraxI/R3s5tyb9x1uG1M61bCCc2K9wA+coHcJJyuI+hEmO0rL4QEXip
         IGzc6yXB+mahjUoKoNTtMeh3kxAnxXe463nRjlY+nwqsDwTsyOPxRLftMEBPjqIXjC7W
         ByaZO1YclKlNjqOv270aBT0kc92+SJKiiayu/PJ7xKAqtJHjCP5w09w8o+MoguWmzyh1
         1lrd4sLAryzxgxX9mH5x+17KMRPsTIfHgsVCy5wrukZjOC80PbkRSVU6vYhXHaCYuCml
         GLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1NvBbUj3Oa5o3VmefLenJ5aY8W8q5IlntRG8fHLCioA=;
        b=ma5eX6Wc+NFT+JN4klHiMcuqce7Gn/SzJmKBGHyy17n9mopsjY/KhNafOYtGNnI5UE
         UxSAjXsiGTyvvZFoNzHpXdoLS/z1qRcLSgpaYPnxMqd0iaJtblCjAJTiPnL4hyUtB+Vn
         jxWHcyVXF8O9amJxAykz0HfcRWeJ3eu/npw9KDcebNPVfcbUusqKRoqwcWe0e8O3QOXI
         NcPXgcnnlssKRMT5bRmDa/N15LN0GnSDx5jzaG8IYjsS0xfPl7wS+CuTakiFqg5oDReE
         Utb5PP+Mh4xOJ2n5C7KaapNsNTKxaub/SwWKfY0wMqogitJbXOA9WcFN/5xNcDuCfb8O
         x3Kg==
X-Gm-Message-State: AJaThX56MRBOk5XyD85YvNiDnTpD6K2aNW4nNXBf4lshhdllwCFLA8m7
        P+sYUgPm4lzWUmogKsGLCnVZlBTz4Kj8wkOdroIksIK7
X-Google-Smtp-Source: AGs4zMbuZMLVkwviMVQ4SIpS0AF2m5AHKxFfn2f16Fwaui8QL7WA166T1chsWdlflCJMEUQFjS6qrEoy1bKJ31lJiM4=
X-Received: by 10.107.47.17 with SMTP id j17mr12072019ioo.96.1510642010024;
 Mon, 13 Nov 2017 22:46:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 13 Nov 2017 22:46:49 -0800 (PST)
In-Reply-To: <5EC5A274-E62A-43F2-BAF0-9C83069F94D8@mail.mcgill.ca>
References: <5EC5A274-E62A-43F2-BAF0-9C83069F94D8@mail.mcgill.ca>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 14 Nov 2017 07:46:49 +0100
Message-ID: <CAP8UFD34UR7ueYj9qLuRapjjGhCxKGa2drwC5U8sZqmrvF0Dxg@mail.gmail.com>
Subject: Re: no mountable file systems
To:     Louis Gruand <louis.gruand@mail.mcgill.ca>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 10:35 PM, Louis Gruand
<louis.gruand@mail.mcgill.ca> wrote:
> Dear team, when i download Git on Mac it says =E2=80=9Cno mountable file =
systems=E2=80=9D and doesnt open after. how can i solve this?

When googling "Mac no mountable file systems", it looks like this
error is not specific to Git.

Could you check if you have the same problem when downloading and
installing other software?
If that is the case, you might want to get help from Mac specific
forums, mailing lists or support channels rather than from this list.
