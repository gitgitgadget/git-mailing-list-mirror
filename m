Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D9420248
	for <e@80x24.org>; Tue, 12 Mar 2019 23:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfCLXap (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 19:30:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37518 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfCLXap (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 19:30:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id x10so36568wmg.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CANhOZReJmQksDvnG8rN8vl1dNk243PYRYh8Oa4BzAA=;
        b=fGyeFXRJPuPzyarCyaRCDpNb1T516s2HO4ziAqXy0aLoGAlMsuiPquyRH/9u5RJ5Ve
         Bw92rEz0KMwmUYFHDHIlZc1zDGSfnf3IgLg+Y9/nu8ggeDSI5sbEpVyC4bW5DMnExgXx
         VKwfZiZRXmGnSaWJ6EaAgndquqGsfwQ9EtW6NiYtfQbmg23hThcjcE21FtSgeT5LSV6s
         p86LT5eL+MuA8wZw73EQjwE0ypLe29c6qjx1uFrXsy6Glls0EbJXJPdBHLrujPx6ZUep
         8Mzx8YCc8r6b7hqTrDSnD9tkILRpwtxCuk6q86qHJksk+uFXYxU7aiJWSYn9w+Vcuzz9
         YDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CANhOZReJmQksDvnG8rN8vl1dNk243PYRYh8Oa4BzAA=;
        b=JNu3O62dS8Z1Oihn3rSXjcXgXPonZ1MZ936jvMDjveAW2xVB49OAQeingCAqrLJDzb
         okQBSqYTo/FI6RavNVBdjq4SeQ57S+b3w8lJkCrmqJd3A41RuHCAlTbfAzF1gSX2eA6z
         aXwMU8xu6yr/lBLgBFxQipq/K5B5vHanjjmjBYmHOIA37wiOyNOQDTDzoRM2+B7dDAXz
         m4lEi9uBzSP7ju+xA7nTfADdCSMbTgNDI9ay80kcyIW5+psJH3vNPvaHk9HJ/oaTZP4M
         Gg6qcqnnvyVQmDs0o1Mgf6RPe2/8mZXsoi39JVRw4VPCiD3zBLRLFSSPivIRSFy2eGYz
         N/Dg==
X-Gm-Message-State: APjAAAULnPmBL8BGmdWHAB0KDzhBtEGvOgHIO+ofbEzwpzYHzo7DGgZw
        AV/UABG+FKGDwopeAdDiUmo71yM8
X-Google-Smtp-Source: APXvYqydxTIPKBmjqJP6V6uES9wtNCChZChNRu47rcrQBuxwF07VxvVkHbmmCKS1l935ciZR+ZIgTA==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr155995wmc.35.1552433442751;
        Tue, 12 Mar 2019 16:30:42 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id s5sm26947480wra.77.2019.03.12.16.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 16:30:41 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:30:40 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] glossary: add definition for overlay
Message-ID: <20190312233040.GE16414@hank.intra.tgummerer.com>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309172733.GC31533@hank.intra.tgummerer.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a definition for what overlay means in the context of git, to
clarify the recently introduced overlay-mode in git checkout.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

v2 addresses Elijah's comments (thanks!), using the wording he
suggested in [*1*], which I agree is slightly better, as no-overlay
mode doesn't touch untracked files.

*1*: https://public-inbox.org/git/CABPp-BEv1taYym_084qVJj3-jkWWS9hKXZ=grrmH7PDUb5ASwA@mail.gmail.com/

 Documentation/glossary-content.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 023ca95e7c..53df6ecb0a 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -287,6 +287,13 @@ This commit is referred to as a "merge commit", or sometimes just a
 	origin/name-of-upstream-branch, which you can see using
 	`git branch -r`.
 
+[[def_overlay]]overlay::
+	Only update and add files to the working directory, but don't
+	delete them, similar to how 'cp -R' would work.  This is the
+	default mode in a <<def_checkout,checkout>>.  In contrast,
+	no-overlay mode will also delete tracked files not present in
+	the source, similar to 'rsync --delete'.
+
 [[def_pack]]pack::
 	A set of objects which have been compressed into one file (to save space
 	or to transmit them efficiently).
-- 
2.21.0.474.g541d9dca55

