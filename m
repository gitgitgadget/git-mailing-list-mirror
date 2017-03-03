Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24DE420133
	for <e@80x24.org>; Fri,  3 Mar 2017 18:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdCCSw1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:52:27 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33672 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbdCCSw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 13:52:26 -0500
Received: by mail-pg0-f68.google.com with SMTP id 77so701293pgc.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 10:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RPHbgONN+n1TbgBHYU0rDfvmzR4O9NJR3kcxLgEK5/4=;
        b=RwezAwrzHEp1auKtwIJQKbN8bqHLPcX4IR/6iR+eh5nfKgXx4kdG9mKQFSzxhmUhFi
         IomG8KISuAt/7C2Xl9K1QkfXFrViODYvgiCuuR94lEul+H9a1kaB7/Du0PC49+qNMdPo
         iovNLFk0LYOSWy+fwjqILHOBTFDCXnaz3dewlBrbDlt1cwXUX4nE22iO9OuXiXWrbohh
         im3lNxPsKzUSRShTqPzlgtIdHuu/9FBo3yhiGjqHlvkV5M1dg38TzTQ0BFGgII/Nw0ZX
         znO0WG0non1ocHILdYOysYEAHl7+GBqT1avLPpqFvFAbxqG8WMlNay0o3peFjMDIgwGp
         qeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RPHbgONN+n1TbgBHYU0rDfvmzR4O9NJR3kcxLgEK5/4=;
        b=UEruaeDmaA3URComFfmRup+NZ7O+As3hXQhzjmFgVk7nJiKufnovI1khB43bdjnfkk
         423q0CkwIxl6tmpgSqnTURnQEwy36w3T6DRekj8440iO6FIlvF9sjHXY1i2YjJzOupBC
         bnEdWPAijZmXOSGve1VBfPrrvD/ORs/DpO9tfdor17lWBJ4j5Q6Se52TIdV+BD+I9zKt
         ixt8lxVrgqes9xxR2TulVxJLmO0U9Vd1G0DqGRu6aKLUzL2iKROJK6PHHzvEwlad/VNA
         LiWgDmnPpDEWlOdk86qZklTY8D9faIAj09WU2ef5mlC/hrvtc9nYrlhVV7c5IWz3l4OE
         0IHw==
X-Gm-Message-State: AMke39kwC37CtoAfKpsvaeGdxV4yC4iy8J/SNdjBsoYHk+9klkOA5AerzTwb5BHB4DhrCA==
X-Received: by 10.99.98.2 with SMTP id w2mr3169760pgb.103.1488544528898;
        Fri, 03 Mar 2017 04:35:28 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id m21sm23491313pgh.4.2017.03.03.04.35.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 04:35:28 -0800 (PST)
Date:   Fri, 3 Mar 2017 04:35:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/2] completion: add bash completion for 'git rev-list'
Message-ID: <20170303123526.GA19532@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This patch isn't strictly necessary since 'git rev-list' isn't a porcelain
command. However, it might be nice to include in case users interactively call
'git rev-list' anyway.
---
 contrib/completion/git-completion.bash | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41ee52991..412485369 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2499,6 +2499,36 @@ _git_revert ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_rev_list_options="
+ --max-count= --skip= --max-age= --min-age= --sparse --merges --no-merges
+ --min-parents= --no-min-parents --max-parents= --no-max-parents --first-parent
+ --remove-empty --full-history --not --all --branches= --tags= --remotes=
+ --glob= --ignore-missing --stdin --quiet --topo-order --parents --timestamp
+ --left-right --left-only --right-only --cherry-mark --cherry-pick --encoding=
+ --author= --committer= --grep= --regexp-ignore-case --extended-regexp
+ --fixed-strings --date= --objects --objects-edge --objects-edge-aggressive
+ --unpacked --pretty --header --bisect --bisect-vars --bisect-all --merge
+ --reverse --walk-reflogs --no-walk --do-walk --count --use-bitmap-index
+"
+
+__git_complete_rev_list_command ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_rev_list_options"
+		return 0
+		;;
+	esac
+	return 1
+}
+
+_git_rev_list ()
+{
+	__git_has_doubledash && return
+
+	__git_complete_rev_list_command || __gitcomp_nl "$(__git_refs)"
+}
+
 _git_rm ()
 {
 	case "$cur" in
-- 
2.12.0.1.g5415fdfc5.dirty

