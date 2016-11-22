Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AAB1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbcKVTeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:34:09 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36103 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754804AbcKVTeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:34:03 -0500
Received: by mail-pg0-f53.google.com with SMTP id f188so10512982pgc.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 11:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tzamSR0dm2RJK3Rj56QIlPTzg9d2fvhZYteyXMr0ME=;
        b=b7x3uixY4iwqZizm1a54QmTHD7LOABkuauFTwCq715ar9nkm3s6hn0RUKJNnNUIca3
         UT2UHDdpx6yCAt4cpHKAEqgQT/XvUUunvPEgLYaMx9i4s8yyy7iQotak7QdWdtisA50k
         kzsSOTOqavC+umV7h35hxem5h0G5BN00+sucMpI9FkKcRAL8mj+OLIlB/ioyyycR2npr
         6vh/PC5I+uGvtswf1H8ML2UO/mZEvAwv4nclEKPn5+tppi0CZoV9AQUcQTmFH24cvd4s
         ky99BzARmHSSwg2ZePm1SEVUMlYZV5bB14isJn7/5L2gQRiRjtoqGVZG72dGddv4f2mh
         5FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6tzamSR0dm2RJK3Rj56QIlPTzg9d2fvhZYteyXMr0ME=;
        b=g9200VlUOeCBchK00FUSq/7WigHak7+8BxOROcFraIOAGfmb/cV2F8g6t+CZZ/Q2Gn
         VVEx6dvs323siXhGOTu4uVPhSeFgma4jGqbv6gdZh9jnfirEM3cqeccpUyJBSeutQm9k
         GvGwYr+dSvL/LtCuw/CFzH1QanHhDwBWOWdviyCfWNInEMPkzYi+Nxi6Za5Gzh0hJ8Pr
         7UzFTEOW0WsHL7oV6+tw4XSpLLQYw1Fj6MfsLMKTihfgXHH8AXBRipgrww9kmJAH3m1q
         tayvyUqjLVEiFJkoXEQw76jjcrYoUBzOxNcBV9WsFm5hyaSmhE62dKmLbtQaEhdFkIYj
         8xpg==
X-Gm-Message-State: AKaTC00BtmK9uQan2Tq/UbFTuqug4u15fqw3bkrbFBuYoi+Fk1owWBTe5+LbelE6El4wvkbK
X-Received: by 10.99.244.17 with SMTP id g17mr46716099pgi.80.1479843199390;
        Tue, 22 Nov 2016 11:33:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id c2sm46998308pfl.66.2016.11.22.11.33.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 11:33:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH] SQUASH
Date:   Tue, 22 Nov 2016 11:33:05 -0800
Message-Id: <20161122193305.7985-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122192235.6055-5-sbeller@google.com>
References: <20161122192235.6055-5-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

On Tue, Nov 22, 2016 at 11:22 AM, Stefan Beller <sbeller@google.com> wrote:
> When a submodule has its git dir inside the working dir, the submodule
> support for checkout that we plan to add in a later patch will fail.
>
> Add functionality to migrate the git directory to be embedded
> into the superprojects git directory.
>

I spoke too early, this needs to be squashed. :(

Stefan

 builtin/submodule--helper.c | 3 +++
 git-submodule.sh            | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e94dd68a0e..75cdbf45b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1083,6 +1083,9 @@ static int embed_git_dir(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option embed_gitdir_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
 		OPT_END()
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 2178248287..b7e124f340 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1133,7 +1133,7 @@ cmd_sync()
 
 cmd_embedgitdirs()
 {
-	git submodule--helper --prefix "$wt_prefix" embed-git-dirs "$@"
+	git submodule--helper embed-git-dirs --prefix "$wt_prefix" "$@"
 }
 
 # This loop parses the command line arguments to find the
-- 
2.11.0.rc2.4.g3396b6f.dirty

