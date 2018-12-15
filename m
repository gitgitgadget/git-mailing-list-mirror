Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8B020A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeLOAJq (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:09:46 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37889 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:09:46 -0500
Received: by mail-pf1-f201.google.com with SMTP id f69so5731851pff.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AUsSTBQUfFBY/uyowRGTSo8W8Wd7+iPi+FRz/a1RIW0=;
        b=SXXTvZPEVO52m3cpZbX18/HV/bILQSE6C6YyYv7+rQU6qUjFOZZd840P05/prD9cKq
         hucgZ7LfW9/q1OGtNIdgEQZtxOmb3Qlik3Oi5dv2AfTqNoaBi02rkAlaF1PhdydVjoaj
         40Flg2hDIjD7lM47XwR8VcD28gVWpUks8MXE4edJRGP5y4EQEFW+n4tShszWpUfPiy/Y
         MDxK56TF7UJ7r+NrFZsIEuNWOE80U3Hi6Vp6dHoJjfw7DtTWiSkFdkTkaPeomfCwMSCb
         p04R61sw4OB7OgqQllaK0MuSNX4akZr3TALTyZfL+/B7VNU5TGiOvK1X9H58uRy4IhzC
         dkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AUsSTBQUfFBY/uyowRGTSo8W8Wd7+iPi+FRz/a1RIW0=;
        b=PR+l0xC0aTVSKaJpCUuAud8w3BD5LiLhR7r05puk5THFTmjrNHycC8SlMbJWzir+Ja
         VYTpwUg00K0tARe8gy7wTOGluQB4eXZVAqskX70cn5Yn2oSnZc9QoQKyc9908tlUbNVk
         9DMnS/n/8MBgaDnrqr9qThLgsScECya6BGfXbKiL4gr3vNyc1f4DYBo+bRhdqeP/TeUv
         pzy9/THzMZbMSxVAIvyuS0KfctMjSSCtGvfSCXDg3YCI5kbMivRWKZJJEjEz3JL4JnAz
         7Fq+br0tsJzkgieFmwUEyyWhF+pwLVDisVnH80Uy4kxwEOyB/p4NIyAfrxC7Dl/GS36U
         7j8A==
X-Gm-Message-State: AA+aEWbUvaZ03BpiGP8ItvoK24n2UR0d4OfM/+HwJRjdBe0b3enlJFsF
        mPQH9VGQhwSXpSBIyIzHZfmvLb63JSpYPE6++3+ghGJYBU+dzY+nHZaDigmnwHuv8KZNWgBtmKx
        j6pGNaMDefiFppL3sm8eBXkQkSsYixGQB4vXkFb/EAC5KzOiD72arGNlSaRF+
X-Google-Smtp-Source: AFSGD/WNvkaj8Dc+1m6ZC0yzBAwC+l6Ve1/lgbVRtsfDROnQa00lxUq4MroWMgTkIMNEsk+JHcDuU6gYG2AV
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr2219157pld.53.1544832585442;
 Fri, 14 Dec 2018 16:09:45 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:19 -0800
Message-Id: <20181215000942.46033-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 00/23] sb/more-repo-in-api
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I realized next has not been rewound, so I can resend sb/more-repo-in-api,
which I hereby do. The changes are minimal and address the only comment
by Jonathan so far.

Thanks,
Stefan

Stefan Beller (23):
  sha1_file: allow read_object to read objects in arbitrary repositories
  packfile: allow has_packed_and_bad to handle arbitrary repositories
  object-store: allow read_object_file_extended to read from any repo
  object-store: prepare read_object_file to deal with any repo
  object-store: prepare has_{sha1, object}_file to handle any repo
  object: parse_object to honor its repository argument
  commit: allow parse_commit* to handle any repo
  commit-reach.c: allow paint_down_to_common to handle any repo
  commit-reach.c: allow merge_bases_many to handle any repo
  commit-reach.c: allow remove_redundant to handle any repo
  commit-reach.c: allow get_merge_bases_many_0 to handle any repo
  commit-reach: prepare get_merge_bases to handle any repo
  commit-reach: prepare in_merge_bases[_many] to handle any repo
  commit: prepare get_commit_buffer to handle any repo
  commit: prepare repo_unuse_commit_buffer to handle any repo
  commit: prepare logmsg_reencode to handle arbitrary repositories
  pretty: prepare format_commit_message to handle arbitrary repositories
  submodule: use submodule repos for object lookup
  submodule: don't add submodule as odb for push
  commit-graph: convert remaining functions to handle any repo
  commit: prepare free_commit_buffer and release_commit_memory for any
    repo
  path.h: make REPO_GIT_PATH_FUNC repository agnostic
  t/helper/test-repository: celebrate independence from the_repository

 builtin/fsck.c                                |   3 +-
 builtin/log.c                                 |   6 +-
 builtin/rev-list.c                            |   3 +-
 cache.h                                       |   2 +
 commit-graph.c                                |  40 +++--
 commit-reach.c                                |  73 +++++----
 commit-reach.h                                |  38 +++--
 commit.c                                      |  41 ++---
 commit.h                                      |  43 +++++-
 .../coccinelle/the_repository.pending.cocci   | 144 ++++++++++++++++++
 object-store.h                                |  35 ++++-
 object.c                                      |   8 +-
 packfile.c                                    |   5 +-
 packfile.h                                    |   2 +-
 path.h                                        |   2 +-
 pretty.c                                      |  28 ++--
 pretty.h                                      |   7 +-
 sha1-file.c                                   |  34 +++--
 streaming.c                                   |   2 +-
 submodule.c                                   |  78 +++++++---
 t/helper/test-repository.c                    |  10 ++
 21 files changed, 454 insertions(+), 150 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.pending.cocci

 git range-diff origin/sb/more-repo-in-api... >>0000-cover-letter.patch
 
1:  99017ffac8 ! 1:  f24b120287 submodule: use submodule repos for object lookup
    @@ -40,12 +40,13 @@
     - * attempt to lookup both the left and right commits and put them into the
     - * left and right pointers.
     +/*
    -+ * Initialize 'out' based on the provided submodule path.
    ++ * Initialize a repository struct for a submodule based on the provided 'path'.
     + *
     + * Unlike repo_submodule_init, this tolerates submodules not present
     + * in .gitmodules. This function exists only to preserve historical behavior,
     + *
    -+ * Returns 0 on success, -1 when the submodule is not present.
    ++ * Returns the repository struct on success,
    ++ * NULL when the submodule is not present.
       */
     -static void show_submodule_header(struct diff_options *o, const char *path,
     +static struct repository *open_submodule(const char *path)
    @@ -59,6 +60,7 @@
     +		return NULL;
     +	}
     +
    ++	/* Mark it as a submodule */
     +	out->submodule_prefix = xstrdup(path);
     +
     +	strbuf_release(&sb);
2:  809765861c = 2:  25190d6174 submodule: don't add submodule as odb for push
3:  4a7735da72 = 3:  965421aab2 commit-graph: convert remaining functions to handle any repo
4:  aeeb1ba49e = 4:  bf31f32723 commit: prepare free_commit_buffer and release_commit_memory for any repo
5:  5ffebe9463 = 5:  c4e54e6b0d path.h: make REPO_GIT_PATH_FUNC repository agnostic
6:  9c89920c46 = 6:  a7ed0c57ba t/helper/test-repository: celebrate independence from the_repository
