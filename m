Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB5620248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDNVTd (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:19:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46901 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfDNVTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:19:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so12894587edd.13
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bmLxfGOYFkRPzwOfAScQZAJO4Qb6uuc5fdvNBwHewN0=;
        b=m9B1DmyB4MSDE0tFEP48UHKZr3nL7TXIRyxWG6XBvMVo+AQdn3FMpFLooH5O+ZG/UY
         R+YMojtiN0s/lYJAWk9uT3X3n/YsMqiNNoXdIkpRiGQSPYq/elSQIO1tYO2NK89lwgXk
         WI+KH+3c4FFm4gyBX/MNdPC679MojJcTZzokdca40jwCABvoYLNQKh5ot1nk2xoRd2Xa
         N0J8WH/vdWq7AWWtR+DO11TKXtBj6WeZLxwj2OmOeaSiySJMLnrrJK0qZm+J8yCEwCl8
         GvVAnMKe96zb87nJZ+SfJKXWDnWC6D3X5kNSUp+jOqg8lkSeW21X24GGHqPoB5AskoSa
         4aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bmLxfGOYFkRPzwOfAScQZAJO4Qb6uuc5fdvNBwHewN0=;
        b=h5Rm6h2W4WBCU/yG/2EhjoJhtpL1rswo70QNKnTWK9Uc17HStH94M/fCLfFHTPCcwh
         1mXifPgu2C9m1HecjWPRz/Q1+2Nkb+P6mkCwqugJ2j3X/S9ILeBVVb4D+a2DTz+bqHXp
         Bh9TiVTB685e9SlaGqK/1Qu7RNuHHpIuq/+vr5iZ25tsjHuc77+pfxKiSN3x4pGbTDKV
         U6lJK3O5izuY7IMYGOL1DZWH9cuOnESWefjoZxtFU1keknQu5UDVJ0HZs/RINEKtdhfp
         /PWrItDtNdPg3puLg+KDNby+c6ToHcKjFw4SgFUkGaC+3JZzLssGpoy5gRlgLwBMRkw5
         5DXw==
X-Gm-Message-State: APjAAAUfAwE++FGsobj+46TWozEmaEr3y6c/OItUAfhbsXZPGdqBvD+X
        fETvhUAQl4AgNl6Ft3RWGZ4lrws0
X-Google-Smtp-Source: APXvYqyv2rQpUpHGLXxK1jAvWwflBOS59uoYmbyddgpqulZVieYwK76+D1Y+e8jtAL1aD4euDM4j7Q==
X-Received: by 2002:a17:906:7b58:: with SMTP id n24mr15995890ejo.224.1555276770418;
        Sun, 14 Apr 2019 14:19:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm5176536ejr.5.2019.04.14.14.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 14:19:29 -0700 (PDT)
Date:   Sun, 14 Apr 2019 14:19:29 -0700 (PDT)
X-Google-Original-Date: Sun, 14 Apr 2019 21:19:27 GMT
Message-Id: <25be67b1b74e585571213c9af1a314b95969090b.1555276767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.179.v2.git.gitgitgadget@gmail.com>
References: <pull.179.git.gitgitgadget@gmail.com>
        <pull.179.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] macOS: make sure that gettext is found
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Due to reasons (some XCode versions seem to include gettext, some
don't?), Homebrew does not expose the libraries and headers in
/usr/local/ by default anymore.

Let's help find them again.

Note: for some reason, this is a change of behavior caused by the
upgrade to Mojave, identified in our Azure Pipeline; it seems that
Homebrew used to add the /usr/local/ directories to the include and link
search path before, but now it no longer does.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 41e85fab1c..3605fead53 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -114,6 +114,8 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
gitgitgadget
