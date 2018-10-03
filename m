Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC33E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJDABc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:01:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDABc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:01:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id r9-v6so1839349pff.11
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+ObyjYGMtisr5p74rCw99n2iZ61MrUFzEK4uzreI/b4=;
        b=SJV9hwgDU2jZNW6ZJYbo5J2mBYSY5BDvV1jRng/Ze7Y0N8IKS21EFOYd4fIvCf9Z23
         MX/ekryrsLR4MxBeQ59E/kO6izsJPiTFjHyl7YlAx7Qld/4RbipVUOG1NhuyJTNW4m/k
         nlrjhzCJoLVq0gZQocUuedmwdIf/+dfl3SXK1p6TA6Z3BrHdALOUQ1lRK5VeVbkWBrez
         qOvH9795E4v7+XZrOL54JvYf5vfqBjQFNG035p35tLamsxyJkr9inIEGw5FQRO1yKrhK
         ldVY631IZ5lUEzmBb1t90QVQ4/Gb28XTCV9HL/Y2RYrbeh+2weD0tfvk121s4YqMFAQP
         NwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ObyjYGMtisr5p74rCw99n2iZ61MrUFzEK4uzreI/b4=;
        b=cGXCNJmeiEZ/Oz/7CKH5Mn3UpZh568CYIt4GP8yZf/AhdEbnNO2M153N/A9jb0JdOI
         BN4CElEUFpMeWYbxu5MRaJw3dToOdTYnx1JfvciU+NkhpsHtwWOwYVbHaXjcHcrLK8HX
         Dh6KKQqQUjOwgMmYZrsHa1U2+ingOaT5yA29Js7ZxB7Y/m7v1GDdskZMNgQgqjsXDCwT
         E/FBHxwuz7V49+QKhI3n6G4FDwHkrfqZK9chhT4jsWL8sEO/WdRSZOzk5etTcc0CGYpC
         ud3D4gq+Q5dz4bQfkpwQZJP4LYNRnJ3JNhaiKI9pKu9F/za/YqlKFNAKYE29Mw1Q0jOl
         S6Rw==
X-Gm-Message-State: ABuFfohEyCu6crFhjsn9X0GyCV/DwQH4iTTS23F9wUqLESoEAQscEgiP
        f5ImEWSfakRsJkRQLBfniBQ7Nr3I
X-Google-Smtp-Source: ACcGV62XL5s6ShHLNi6KRBZEdJiE0THHWso4MFCz3C1BVex1bjErD4gOqVtZ2iQBsOFmF+8ApAU74A==
X-Received: by 2002:a63:6d83:: with SMTP id i125-v6mr2144419pgc.215.1538586735130;
        Wed, 03 Oct 2018 10:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 64-v6sm3784468pgb.74.2018.10.03.10.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:12:14 -0700 (PDT)
Date:   Wed, 03 Oct 2018 10:12:14 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 17:12:09 GMT
Message-Id: <pull.42.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.42.git.gitgitgadget@gmail.com>
References: <pull.42.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Clean up leaks in commit-graph.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at the commit-graph code, I noticed some memory leaks. These
can be found by running

valgrind --leak-check=full ./git commit-graph write --reachable

The impact of these leaks are small, as we never call write_commit_graph
_reachable in a loop, but it is best to be diligent here.

While looking at memory consumption within write_commit_graph(), I noticed
that we initialize our oid list with "object count / 4", which seems to be a
huge over-count. I reduce this by a factor of eight.

I built off of ab/commit-graph-progress, because my patch involves lines
close to those changes.

V2 includes feedback from V1 along with Martin's additional patches.

Thanks, -Stolee

Derrick Stolee (2):
  commit-graph: clean up leaked memory during write
  commit-graph: reduce initial oid allocation

Martin Ågren (1):
  builtin/commit-graph.c: UNLEAK variables

 builtin/commit-graph.c | 11 ++++++-----
 commit-graph.c         | 16 ++++++++++------
 2 files changed, 16 insertions(+), 11 deletions(-)


base-commit: 6b89a34c89fc763292f06012318b852b74825619
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-42%2Fderrickstolee%2Fcommit-graph-leak-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-42/derrickstolee/commit-graph-leak-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/42

Range-diff vs v1:

 1:  6906c25415 ! 1:  ba65680b3d commit-graph: clean up leaked memory during write
     @@ -7,17 +7,29 @@
          leaked in write_commit_graph_reachable(). Clean these up so our
          memory checking is cleaner.
      
     -    Running 'valgrind --leak-check=full git commit-graph write
     -    --reachable' demonstrates these leaks and how they are fixed after
     -    this change.
     +    Further, if we use a list of pack-files to find the commits, we
     +    can leak the packed_git structs after scanning them for commits.
      
     +    Running the following commands demonstrates the leak before and
     +    the fix after:
     +
     +    * valgrind --leak-check=full ./git commit-graph write --reachable
     +    * valgrind --leak-check=full ./git commit-graph write --stdin-packs
     +
     +    Signed-off-by: Martin Ågren <martin.agren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
      +++ b/commit-graph.c
      @@
     - 	string_list_init(&list, 1);
     + void write_commit_graph_reachable(const char *obj_dir, int append,
     + 				  int report_progress)
     + {
     +-	struct string_list list;
     ++	struct string_list list = STRING_LIST_INIT_DUP;
     + 
     +-	string_list_init(&list, 1);
       	for_each_ref(add_ref_to_list, &list);
       	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
      +
     @@ -25,6 +37,14 @@
       }
       
       void write_commit_graph(const char *obj_dir,
     +@@
     + 				die(_("error opening index for %s"), packname.buf);
     + 			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
     + 			close_pack(p);
     ++			free(p);
     + 		}
     + 		stop_progress(&oids.progress);
     + 		strbuf_release(&packname);
      @@
       	compute_generation_numbers(&commits, report_progress);
       
     @@ -45,5 +65,8 @@
      +	free(graph_name);
      +	free(commits.list);
       	free(oids.list);
     - 	oids.alloc = 0;
     - 	oids.nr = 0;
     +-	oids.alloc = 0;
     +-	oids.nr = 0;
     + }
     + 
     + #define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
 -:  ---------- > 2:  13032d8475 builtin/commit-graph.c: UNLEAK variables
 2:  e29a0eaf03 = 3:  1002fd34fc commit-graph: reduce initial oid allocation

-- 
gitgitgadget
