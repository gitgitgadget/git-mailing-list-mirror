Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A902E1F42D
	for <e@80x24.org>; Wed, 30 May 2018 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeE3Uwb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 16:52:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39687 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeE3Uwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 16:52:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id f8-v6so50292141wmc.4
        for <git@vger.kernel.org>; Wed, 30 May 2018 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GjmmNhYhhCGjvbjKEZhRFYklMhf0e9OFO6mvH4LQMw=;
        b=EKZpim03fnL6M3+wfhLAtrR8VmSxQcB4Uf19jFKR38sqMWf2qD24lp6GczRW7FlvRV
         mW2aYjcpAkm2hUhxF6G+N0OfbcBQa9+W51Iho3N/EmuQHqfJl6fjSnwClOR+Llbo+oUw
         1jULm1S8fJwbk5zFxFVdCCihk04MtTbrf3cxmRRiBbCg8nDPD7cp61sB8odDxQo49wTr
         H7DLNKeqlQqoptqulZPZ82AvtVzRRcYw503yFyrcQnKHVqVTDcURlRVaMKgyORa4WzDf
         aIJv9NXRBVw49U++YZCQlXYtVoGbHRtLUYgclV1Qgzng6/IQd1lnRs9nUH06u5nLUezk
         gTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GjmmNhYhhCGjvbjKEZhRFYklMhf0e9OFO6mvH4LQMw=;
        b=ZNpb9o5YHfGcSdLh37tgsctwM7je25acecVWE4uOJgOmF1kFM7p2E3W2Cp6JrsFLme
         v2ChPBXSDKmNTxgVSzS5pCN87n68QfV9tfedb5wJSoijscl4a132hcDnqHoodBiy2O34
         NobilAEcbTZbOkq5kQrBV4jRk1Mpe1gkfsYMFSwUIxSfxfeOhRe7Tls+DGXIVsLG3jid
         ZpBxhcdaMYhWVWzNLLM3/3lOJForsUwWoLDQ2zIMenlMLd3tOBp/ksDeqUp9g0Zi+NLp
         LIhbXy+HZptu6g8f0ScdyfqeodoUWNHcd2sPfxlyfwBcFtZrQwZv+moRwY1lYmtn5hMQ
         4Ajw==
X-Gm-Message-State: ALKqPwc3wmnk+plzzUc/xxuOG2X9DvrycCEUVJ2PJHK73sFA/u2MfqVv
        1oY5QMduqvWGewBZXiXD1le2InNC
X-Google-Smtp-Source: ADUXVKJqqw3b7b6qpf/aRFNJJBeWqSo5XH9Dg0HmO2Q2jzKKXoUgVd0CDLL09RII4xC4LN31eW+tUg==
X-Received: by 2002:a1c:57c6:: with SMTP id l189-v6mr2517217wmb.161.1527713549373;
        Wed, 30 May 2018 13:52:29 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f143-v6sm18883604wme.43.2018.05.30.13.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 13:52:28 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] note git-security@googlegroups.com in more places
Date:   Wed, 30 May 2018 21:52:55 +0100
Message-Id: <20180530205255.13090-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.1181.g093e983b0
In-Reply-To: <20180530205255.13090-1-t.gummerer@gmail.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180530205255.13090-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a mention of the security mailing list to the README, and to
Documentation/SubmittingPatches..  2caa7b8d27 ("git manpage: note
git-security@googlegroups.com", 2018-03-08) already added it to the
man page, but for developers either the README, or the documentation
on how to contribute (SubmittingPatches) may be the first place to
look.

Use the same wording as we already have on the git-scm.com website and
in the man page for the README, while the wording is adjusted in
SubmittingPatches to match the surrounding document better.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/SubmittingPatches | 13 +++++++++++++
 README.md                       |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 27553128f5..c8f9deb391 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -176,6 +176,12 @@ that is fine, but please mark it as such.
 [[send-patches]]
 === Sending your patches.
 
+:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
+
+Before sending any patches, please note that patches that may be
+security relevant should be submitted privately to the Git Security
+mailing list{security-ml}, instead of the public mailing list.
+
 Learn to use format-patch and send-email if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client that is optimized for "multipart/*" mime
@@ -259,6 +265,13 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
+:security-ml-ref: footnoteref:[security-ml]
+
+As mentioned at the beginning of the section, patches that may be
+security relevant should not be submitted to the public mailing list
+mentioned below, but should instead be sent privately to the Git
+Security mailing list{security-ml-ref}.
+
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the `git
 contacts` command in `contrib/contacts/` can help to
diff --git a/README.md b/README.md
index f17af66a97..f920a42fad 100644
--- a/README.md
+++ b/README.md
@@ -36,6 +36,9 @@ the body to majordomo@vger.kernel.org. The mailing list archives are
 available at <https://public-inbox.org/git/>,
 <http://marc.info/?l=git> and other archival sites.
 
+Issues which are security relevant should be disclosed privately to
+the Git Security mailing list <git-security@googlegroups.com>.
+
 The maintainer frequently sends the "What's cooking" reports that
 list the current status of various development topics to the mailing
 list.  The discussion following them give a good reference for
-- 
2.17.0.1181.g093e983b0

