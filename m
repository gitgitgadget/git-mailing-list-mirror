Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE85D1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 09:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfAUJNs (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 04:13:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45934 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfAUJNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 04:13:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so15918319edb.12
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a60PDB/sFGZbiveurPxw6uMN1zI85wNCHnWFU/k8O74=;
        b=XfNPR+IBWfE1Hq5vIs0cylQM37vOJ3njUrMFL4rI0m773VHUQrXzxsJswuxTQeHe5N
         rLQ5yBHM51d2KYFsXUxgX5OQau8JdCPeGLGUbWtfQ1WCvAIjSzGzi7hSWU5EDXgXXtf2
         ggpBiWQAbpwX5EW+yxjDFiLG1E5+gF19UobneYcaDHyKa0abS37xkbKrmQS8fl5vg76W
         fnSQwrvJoI37asSP11BMgyc7OVbKfQniNlRd7MI0bYXPlJqZpa0UrcA/AgXKZGCVKMnf
         5KZtAJGDLCemPQbXRVZUWNRIZ1raxOGzYnlRRxL/azqE+Y2rL94KNg8JUtpv3D5FQrxv
         zB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a60PDB/sFGZbiveurPxw6uMN1zI85wNCHnWFU/k8O74=;
        b=q7e2kLGiyOk34sGWRBGYxAwGSeRxFtDfMcFQpSuOI3+E2cOCsgyphMRUynEPz8SbLr
         zBoi+sFDmYbpSv0qIwlwMY/BvOVuqmPmWEvrQuELsbvY3mBzEREOOrMrp/fareqSlTZe
         IPTkMSzdmpwQFAkkz6v6L+PrCelwOQzkNxZTbbwfhTMJde/7khhM0nUkQapPhnNkNh5z
         FyufBjyvuab8hLRORKfXiwRs3Nd4G1v7BFV8HWbVCOYteovTKkp6TpZYn8Kpgxjz0VGJ
         /fKxrj+soa/9i+ErsazrtqVMQN3qeOG4l2aOgHNb5TeEG43Vsi0e7o1EVUrG4AJp2H0t
         SHSw==
X-Gm-Message-State: AJcUukcwIoHKU04g/pS5XyAItL1zbCgDkVQeMfOH/Tid45sZMxjqKyoH
        cbZtMvK1hVBBckC+vccnJ1vHelvu
X-Google-Smtp-Source: ALg8bN5LGXHJGdFyB6e8yb6Etpy4eSb0bFTJHigmra3vYAfH3XxnbJHZYizyadC/WnrGbGIFRFKljw==
X-Received: by 2002:a50:b32f:: with SMTP id q44mr26174027edd.70.1548062024259;
        Mon, 21 Jan 2019 01:13:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c30sm8952587edc.70.2019.01.21.01.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 01:13:43 -0800 (PST)
Date:   Mon, 21 Jan 2019 01:13:43 -0800 (PST)
X-Google-Original-Date: Mon, 21 Jan 2019 09:13:36 GMT
Message-Id: <4950c889aacd869a8f4fd30b8d5cde4b43957347.1548062019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v3.git.gitgitgadget@gmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
        <pull.103.v3.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/7] add--interactive.perl: use add--helper --status for
 status_cmd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Call the newly introduced add--helper builtin on
status_cmd() instead of relying on add--interactive's Perl
functions to build print the numstat.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-add--interactive.perl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..a6536f9cf3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -597,9 +597,7 @@ sub prompt_help_cmd {
 }
 
 sub status_cmd {
-	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
-			list_modified());
-	print "\n";
+	system(qw(git add--helper --status));
 }
 
 sub say_n_paths {
-- 
gitgitgadget

