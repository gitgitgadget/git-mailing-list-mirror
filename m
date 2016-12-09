Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2EA51FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbcLIPxI (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 10:53:08 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34425 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933539AbcLIPxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 10:53:06 -0500
Received: by mail-lf0-f68.google.com with SMTP id x143so365022lfd.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I3z2R78wV4oCEBXbYk780Nc5BNcFxL6fTktLES4p3Zc=;
        b=uDQArrhkc6+AI/ge+gTCcaFb7w/vsJl9rMg7fuUekFmzrqZ8skqdZCLKj9CyddrHXr
         LUJ7QbRBhcluDtLIJAEirUSzNfurcHAWXAPNcsJnbpc8uLXVx9i+9YA0heSLSLBzcBD6
         JsY9+vhJ3282ulJd7cAeFuL0m49OTcFqOl+OuMrzXzltU8J1KV9hNdR3kkjppg1OPiwN
         m5OuwAexXmtfSc2Q8umum3z7h4Wi6IeCiFk6c7A31rhckyd6T772q+vM57yncN9Ny4aQ
         902Gvw5SaX4/1S+Li8/NGcKyswpdB/G3K8bPZli1eIvGnHvflmhX8u+8vDDbJmT4aJWn
         S5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I3z2R78wV4oCEBXbYk780Nc5BNcFxL6fTktLES4p3Zc=;
        b=iuLAujb0STS1gdmBOZ8GLTUKTVDO5+dWSCkD6y9WtnaOKZg5v6TfbTCWp+aaJ1J+sU
         E0LEcsm1vhTL/0YEqpbDOlppRLsoxHQZIHOzA1rDmXeDDuofSfNL+rgFdT86CIl8OFgY
         ls3srcqp38kV5vV6ZZuW0DnPvpZtwRHMVu6OmxYtqL2ZynJD3cqbFgKTkW21V7DtfNeW
         UHLz18fvMr+0zhR+zvIXoI7JMtfjWo1tpGL6v9bQJflZwKGAwSuqm8C16icd2+8MW1Eq
         N06Mf9PyvAtStDKSBRP3tOEmz0oksXaq8l8eZ80GoRO+UMD5248+VFB8WWblovHnV9d9
         KbhA==
X-Gm-Message-State: AKaTC02F6wgPIZHtBUC80i3dHDsMn29Lg98QwxDgMwuaioTKjn0gADmU65v3qhu3U/oRGw==
X-Received: by 10.25.104.2 with SMTP id d2mr22329510lfc.95.1481298785239;
        Fri, 09 Dec 2016 07:53:05 -0800 (PST)
Received: from kristoffer-SZ68R2.privnett.uib.no (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id r204sm6646500lfr.19.2016.12.09.07.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 07:53:04 -0800 (PST)
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: [PATCH 4/4] doc: omit needless "for"
Date:   Fri,  9 Dec 2016 16:51:12 +0100
Message-Id: <20161209155112.2112-5-kristoffer.haugsbakk@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What was intended was perhaps "... plumbing does for you" ("you" added), but
simply omitting the word "for" is more terse and gets the intended point across
just as well, if not more so.

I originally went with the approach of writing "for you", but Junio C
Hamano suggested this approach instead.

Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
---

Notes (kristoffers):
    The original patch was sent to the mailing list on 2016-11-04, and Junio
    replied with his suggested correction on 2016-11-10; see the cover
    letter.

 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 72ca9c1ef..22309cfb4 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -25,7 +25,7 @@ you want to understand Git's internals.
 The core Git is often called "plumbing", with the prettier user
 interfaces on top of it called "porcelain". You may not want to use the
 plumbing directly very often, but it can be good to know what the
-plumbing does for when the porcelain isn't flushing.
+plumbing does when the porcelain isn't flushing.
 
 Back when this document was originally written, many porcelain
 commands were shell scripts. For simplicity, it still uses them as
-- 
2.11.0

