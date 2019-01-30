Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4C01F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfA3U5Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:57:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35714 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387896AbfA3U42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so822233edx.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=EhlduErOtyEy7Kh0PvpGyk+yaA3XE/xT+8G5St7+LiD81OcR5GxV8hVyrIU9PblIdU
         GS38J+CXw9wqZT6rcjTbTErRcIavmKxXupfyOCyq++CheaFHNBVodWLcK0ABxMBmAq1y
         ZT4sJBCXBB6ORlYfb0JGswH2kjkgdEm/pctCKlGnyKm6haeJfSGZy+fPIOj52I2DvRao
         OdHyFEX/XMRcPUG7yiAo2j3IJgVbjk6ryWP1pzRnnbmByH5Sw9GmtekTWRCbtYw/pzHc
         ujgs6c4XV8lPxK/0VDPK8EHw2+laVnfOZ7ojmm7qXCJvJD8b2mL0DD7MsfAkBTi+WPL+
         BNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=cz8dI9oEA2A6Ih/9qw8x51SqXgVySBuWmddEqMzQYmZOG4Ra5hx4/qGkFxnR+M3iFk
         hX8tmX5HMQFaxSwNfnHkDgSEzQGGbbaKUUZFn5sRyzi6NfeaxwYNSm01zlEv7+GJ5WMW
         Py+P1H1Uki/x2cKzfvWptgiV/4I37f5vL01AmsNIHGPAdS9U8B+5QM/WpWSWtn//cnh0
         TiBHNkm4K3GpS8KSuOuK5VppxuAxBf3tIf27T7xnPIE6acIIxWsWeoyQ0zh1YuGH3fk3
         6qNrbwI7bLoj0O+xOh7Q8/sXGdLEOMS4p41Ecn3JO/G56cWyDGjMoqUF+BX7MfgeBbqS
         EVHg==
X-Gm-Message-State: AJcUukeCvEDeKaYnFAs2NVWHxFA8utiT3X3He6zrjC+MansaGckUsXe+
        dGybKQefbqH3J3h8502+pWj2JKkL
X-Google-Smtp-Source: ALg8bN6MFx1/yR44Lcryjx9nbJjHeo4+JXsYOrTTUH6nVQPihrERKKjEiyfXX3S8McX6exln3GGmxQ==
X-Received: by 2002:a17:906:e096:: with SMTP id gh22mr15752555ejb.30.1548881786372;
        Wed, 30 Jan 2019 12:56:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l51sm772998edb.36.2019.01.30.12.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:25 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:25 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:10 GMT
Message-Id: <638fdb294f46001de15006a49e919519c7555465.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 05/14] trace2:data: add editor/pager child classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 process classification for editor and pager
child processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 editor.c | 1 +
 pager.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/editor.c b/editor.c
index c985eee1f9..71547674ab 100644
--- a/editor.c
+++ b/editor.c
@@ -78,6 +78,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
+		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0)
 			return error("unable to start editor '%s'", editor);
 
diff --git a/pager.c b/pager.c
index a768797fcf..4168460ae9 100644
--- a/pager.c
+++ b/pager.c
@@ -100,6 +100,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	argv_array_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
+	pager_process->trace2_child_class = "pager";
 }
 
 void setup_pager(void)
-- 
gitgitgadget

