Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CFB1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfA3U4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:56:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37692 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbfA3U4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so811739edb.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=FM/AzoudyGeHQhsiZfL4UKoTEJ3RxrAPIwEMLyiVVs6sBOOHUiWUmUUiP9d2IEM0mG
         cC0AAa/CIuw3BpCzozpFQe5AOyPNxPwcGJ01OQocLChEyUDR6EDYeEHf6kSDf/1ly86G
         eTErmuBWGO/Pm5VJdwIYfLEwvIY7At+yPJ4dkk8FLD3SogafnvORoTJwoZdPbnYlNoma
         seHtUb8vWW/nqqfhDfM8cV/kSogstiKOu/Re8XdLJ2FbsQF7XXSPAQ2mT4d3VBa9k0ia
         WbOf5GWLJiJm9tEI2OSsov6ThjPn+DV3XaUs3doOzBid49k/6Vok4RzyezLkgzBv3k/M
         Fzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=cA9qt53LUMA/6jKm58XSGmK14LtwBOE9AMZJ9xCMD/mligXlZ8oNxwyU6SUl0sqGwx
         t0u1Dev4/lrxCMGafRNVLKvlrPoytPYlhad5PiIW9V3G2PxBYLG8oD8FSup8QMAJIAwa
         BC7N53TUFkNvf8lqHrl65tv12ZB2kIGpN2tOaLTIznH6H2vRpa6a2KvDt5S1lxhEGWZv
         fYkk7tZRmYxayKW+O/pirTVvaGcK3QvgHacw7eqVy4QPLebOW/lkb2uFyHJBH60+15DQ
         NiqS8GXGvL7ujjRbH6Z67QMnKQRfMhDA4gswTNQlCGokPAB+HcTUEB2HdLMZpIPxOtpS
         FEcg==
X-Gm-Message-State: AHQUAuZ9ynpFGtNm1Yf+FSnkCPbivown9okb9NGO39nIMtepzBRW4iHD
        Z/v1KNKcSWN1xHgt0qhpUEX9DvWe
X-Google-Smtp-Source: AHgI3IaOrqymGSSYTPGYTBcl+Vs9vcESr+/F6oZdy8XitoUWEvPZ3uGjVSRSXdOSQfdWKwLY6Iyksg==
X-Received: by 2002:a17:906:1daa:: with SMTP id u10mr3508900ejh.35.1548881787994;
        Wed, 30 Jan 2019 12:56:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by5-v6sm476734ejb.7.2019.01.30.12.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:27 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:27 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:12 GMT
Message-Id: <660b83c453d416ed8c1754a2d2934abbd99d0660.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 07/14] trace2:data: add trace2 transport child
 classification
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

Add trace2 child classification for transport processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 connect.c          | 3 +++
 transport-helper.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/connect.c b/connect.c
index 24281b6082..3c6f829a05 100644
--- a/connect.c
+++ b/connect.c
@@ -1251,6 +1251,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
 		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
+		conn->trace2_child_class = "transport/git";
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
@@ -1293,9 +1294,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
+			conn->trace2_child_class = "transport/ssh";
 			fill_ssh_args(conn, ssh_host, port, version, flags);
 		} else {
 			transport_check_allowed("file");
+			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
 				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 						 version);
diff --git a/transport-helper.c b/transport-helper.c
index 6cf3bb324e..a01cc0093f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -127,6 +127,8 @@ static struct child_process *get_helper(struct transport *transport)
 		argv_array_pushf(&helper->env_array, "%s=%s",
 				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
+	helper->trace2_child_class = helper->args.argv[0]; /* "remote-<name>" */
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
-- 
gitgitgadget

