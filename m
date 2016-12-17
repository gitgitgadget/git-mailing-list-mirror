Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7201FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755784AbcLQPft (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 10:35:49 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35387 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbcLQPfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 10:35:48 -0500
Received: by mail-lf0-f68.google.com with SMTP id p100so3768149lfg.2
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 07:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4f4Jcg6SsML/xw2QGRp0FMRh5xV79r8zLyr9UykhHA=;
        b=EL7rVT3tCU+y6RR/tnhARQa/i/2tmdnZGm5o4lYiGPqHbEcEScaBQolWbTyoyrkCf0
         8Jp9f+YKoOQfP3M7wVbAXF80OAL3bowYH3eCZQqAky3UZTBn/sVFnH9igSZcr1EBqHEw
         hWff6GbpuWR3HfBJZFCvHItB6Dco1CzxIll8Ja7sQo2b2zPBpHA4qOGmTO473dnw2k4O
         FX0W9o1xK1+sNO17Xu8+lh9G480fEL0Aa6ZNqTU7/yfI0r3oIStIsDjAJ24KQJVCLQrt
         HF7lvPCfMWV1YkTPSKw2l3lD1vR1AUvMbQiRM9PdcyzLZ452d5Jud17/I5NP0HR4pZ4T
         Y0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4f4Jcg6SsML/xw2QGRp0FMRh5xV79r8zLyr9UykhHA=;
        b=dtcJ+HelJiiRh8jY8UnSFgL0t3YwjCgcSgSVMK+vMkrYjyjygcrLYjb6Gv5EuN+j4m
         PibUAKeqYesQzkFhjucG7eZdIzwAVWvY6T2Gj+eXhUZPpwvMDFeNr9PdqV4WtTmtmZUM
         NFqkvyyH3j2nzj3cufnoYN9Z7Sl1WShbHJHA21y9yTkpuLP7tXGXiarq1mk3BBy4Gtga
         M8RN5MRx1jftXjJKfO7OqNJS+NlozIU7Mej05rlG8X4Jc9hDdSDcopYlu1ZOPtgdCOtO
         MLWQOKOV/wEgdpHMYvDsSvQL/6widp+Iu/mnaaAu1J9esD8MhlJC95RN59BVuteLe78U
         5ZhA==
X-Gm-Message-State: AIkVDXJie2EfQnl8JpHSkRCJkfsa45AEaw3nxoFe4TKFmv4AxIUsfrlwPd+IlmK03sEQSni1k5XFkI09JAbRSg==
X-Received: by 10.46.7.18 with SMTP id 18mr3447672ljh.30.1481988946261; Sat,
 17 Dec 2016 07:35:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Sat, 17 Dec 2016 07:35:45 -0800 (PST)
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Dec 2016 16:35:45 +0100
Message-ID: <CAP8UFD0Z7UquU0qiGq9y5AXtR-BiMEme9i=MnKRRzD_zyDpdzA@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Add configuration options for split-index
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The previous versions were:
>
>   RFC: https://github.com/chriscool/git/commits/config-split-index7
>   v1:  https://github.com/chriscool/git/commits/config-split-index72

The diff since v1 is:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8fbef25cb1..52a3cac4ff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2782,9 +2782,9 @@ splitIndex.sharedIndexExpire::
     index file is created. The value "now" expires all entries
     immediately, and "never" suppresses expiration altogether.
     The default value is "one.week.ago".
-    Note that each time a new split-index file is created, the
-    mtime of the related shared index file is updated to the
-    current time.
+    Note that each time a split index based on a shared index file
+    is either created or read from, the mtime of the shared index
+    file is updated to the current time.
     See linkgit:git-update-index[1].

 status.relativePaths::
diff --git a/Documentation/git-update-index.txt
b/Documentation/git-update-index.txt
index 635d1574b2..46c953b2f2 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -407,10 +407,14 @@ specified by the splitIndex.maxPercentChange
config variable (see
 linkgit:git-config[1]).

 Each time a new shared index file is created, the old shared index
-files are deleted if they are older than what is specified by the
-splitIndex.sharedIndexExpire config variable (see
+files are deleted if their mtime is older than what is specified by
+the splitIndex.sharedIndexExpire config variable (see
 linkgit:git-config[1]).

+To avoid deleting a shared index file that is still used, its mtime is
+updated to the current time everytime a new split index based on the
+shared index file is either created or read from.
+
 Untracked cache
 ---------------

diff --git a/builtin/gc.c b/builtin/gc.c
index c1e9602892..1e40d45aa2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -100,8 +100,8 @@ static void gc_config(void)
     git_config_get_int("gc.auto", &gc_auto_threshold);
     git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
     git_config_get_bool("gc.autodetach", &detach_auto);
-    git_config_get_date_string("gc.pruneexpire", &prune_expire);
-    git_config_get_date_string("gc.worktreepruneexpire",
&prune_worktrees_expire);
+    git_config_get_expiry("gc.pruneexpire", &prune_expire);
+    git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
     git_config(git_default_config, NULL);
 }

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a14dbf2612..dc1fd0d44d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1099,18 +1099,18 @@ int cmd_update_index(int argc, const char
**argv, const char *prefix)

     if (split_index > 0) {
         if (git_config_get_split_index() == 0)
-            warning("core.splitIndex is set to false; "
-                "remove or change it, if you really want to "
-                "enable split index");
+            warning(_("core.splitIndex is set to false; "
+                  "remove or change it, if you really want to "
+                  "enable split index"));
         if (the_index.split_index)
             the_index.cache_changed |= SPLIT_INDEX_ORDERED;
         else
             add_split_index(&the_index);
     } else if (!split_index) {
         if (git_config_get_split_index() == 1)
-            warning("core.splitIndex is set to true; "
-                "remove or change it, if you really want to "
-                "disable split index");
+            warning(_("core.splitIndex is set to true; "
+                  "remove or change it, if you really want to "
+                  "disable split index"));
         remove_split_index(&the_index);
     }

diff --git a/cache.h b/cache.h
index 8e26aaf05e..279415afbd 100644
--- a/cache.h
+++ b/cache.h
@@ -1823,11 +1823,13 @@ extern int git_config_get_bool(const char
*key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool,
int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
-extern int git_config_get_date_string(const char *key, const char **output);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);

+/* This dies if the configured or default date is in the future */
+extern int git_config_get_expiry(const char *key, const char **output);
+
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/config.c b/config.c
index f88c61bb30..5c52cefd78 100644
--- a/config.c
+++ b/config.c
@@ -1685,7 +1685,7 @@ int git_config_get_pathname(const char *key,
const char **dest)
     return ret;
 }

-int git_config_get_date_string(const char *key, const char **output)
+int git_config_get_expiry(const char *key, const char **output)
 {
     int ret = git_config_get_string_const(key, output);
     if (ret)
@@ -1714,8 +1714,8 @@ int git_config_get_untracked_cache(void)
         if (!strcasecmp(v, "keep"))
             return -1;

-        error("unknown core.untrackedCache value '%s'; "
-              "using 'keep' default value", v);
+        error(_("unknown core.untrackedCache value '%s'; "
+            "using 'keep' default value"), v);
         return -1;
     }

@@ -1740,9 +1740,8 @@ int git_config_get_max_percent_split_change(void)
         if (0 <= val && val <= 100)
             return val;

-        error("splitindex.maxpercentchange value '%d' "
-              "should be between 0 and 100", val);
-        return -1;
+        return error(_("splitIndex.maxPercentChange value '%d' "
+                   "should be between 0 and 100"), val);
     }

     return -1; /* default value */
diff --git a/read-cache.c b/read-cache.c
index 9727efcb5b..35377f0a3e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1685,10 +1685,25 @@ int do_read_index(struct index_state *istate,
const char *path, int must_exist)
     die("index file corrupt");
 }

+/*
+ * Signal that the shared index is used by updating its mtime.
+ *
+ * This way, shared index can be removed if they have not been used
+ * for some time. It's ok to fail to update the mtime if we are on a
+ * read only file system.
+ */
+void freshen_shared_index(char *base_sha1_hex)
+{
+    const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+    check_and_freshen_file(shared_index, 1);
+}
+
 int read_index_from(struct index_state *istate, const char *path)
 {
     struct split_index *split_index;
     int ret;
+    char *base_sha1_hex;
+    const char *base_path;

     /* istate->initialized covers both .git/index and .git/sharedindex.xxx */
     if (istate->initialized)
@@ -1706,15 +1721,16 @@ int read_index_from(struct index_state
*istate, const char *path)
         discard_index(split_index->base);
     else
         split_index->base = xcalloc(1, sizeof(*split_index->base));
-    ret = do_read_index(split_index->base,
-                git_path("sharedindex.%s",
-                     sha1_to_hex(split_index->base_sha1)), 1);
+
+    base_sha1_hex = sha1_to_hex(split_index->base_sha1);
+    base_path = git_path("sharedindex.%s", base_sha1_hex);
+    ret = do_read_index(split_index->base, base_path, 1);
     if (hashcmp(split_index->base_sha1, split_index->base->sha1))
         die("broken index, expect %s in %s, got %s",
-            sha1_to_hex(split_index->base_sha1),
-            git_path("sharedindex.%s",
-                 sha1_to_hex(split_index->base_sha1)),
+            base_sha1_hex, base_path,
             sha1_to_hex(split_index->base->sha1));
+
+    freshen_shared_index(base_sha1_hex);
     merge_base_index(istate);
     post_read_index_from(istate);
     return ret;
@@ -2205,8 +2221,8 @@ static unsigned long get_shared_index_expire_date(void)
     static int shared_index_expire_date_prepared;

     if (!shared_index_expire_date_prepared) {
-        git_config_get_date_string("splitindex.sharedindexexpire",
-                       &shared_index_expire);
+        git_config_get_expiry("splitindex.sharedindexexpire",
+                      &shared_index_expire);
         shared_index_expire_date = approxidate(shared_index_expire);
         shared_index_expire_date_prepared = 1;
     }
@@ -2225,22 +2241,20 @@ static int can_delete_shared_index(const char
*shared_sha1_hex)
     if (!expiration)
         return 0;
     if (stat(shared_index, &st))
-        return error_errno("could not stat '%s", shared_index);
+        return error_errno(_("could not stat '%s"), shared_index);
     if (st.st_mtime > expiration)
         return 0;

     return 1;
 }

-static void clean_shared_index_files(const char *current_hex)
+static int clean_shared_index_files(const char *current_hex)
 {
     struct dirent *de;
     DIR *dir = opendir(get_git_dir());

-    if (!dir) {
-        error_errno("unable to open git dir: %s", get_git_dir());
-        return;
-    }
+    if (!dir)
+        return error_errno(_("unable to open git dir: %s"), get_git_dir());

     while ((de = readdir(dir)) != NULL) {
         const char *sha1_hex;
@@ -2250,9 +2264,11 @@ static void clean_shared_index_files(const char
*current_hex)
             continue;
         if (can_delete_shared_index(sha1_hex) > 0 &&
             unlink(git_path("%s", de->d_name)))
-            error_errno("unable to unlink: %s", git_path("%s", de->d_name));
+            error_errno(_("unable to unlink: %s"), git_path("%s", de->d_name));
     }
     closedir(dir);
+
+    return 0;
 }

 static struct tempfile temporary_sharedindex;
@@ -2286,7 +2302,7 @@ static int write_shared_index(struct index_state *istate,

 static const int default_max_percent_split_change = 20;

-int too_many_not_shared_entries(struct index_state *istate)
+static int too_many_not_shared_entries(struct index_state *istate)
 {
     int i, not_shared = 0;
     int max_split = git_config_get_max_percent_split_change();
@@ -2331,17 +2347,14 @@ int write_locked_index(struct index_state
*istate, struct lock_file *lock,
         if ((v & 15) < 6)
             istate->cache_changed |= SPLIT_INDEX_ORDERED;
     }
-    if (istate->cache_changed & SPLIT_INDEX_ORDERED ||
-        too_many_not_shared_entries(istate)) {
+    if (too_many_not_shared_entries(istate))
+        istate->cache_changed |= SPLIT_INDEX_ORDERED;
+    if (istate->cache_changed & SPLIT_INDEX_ORDERED) {
         int ret = write_shared_index(istate, lock, flags);
         if (ret)
             return ret;
     } else {
-        /* Signal that the shared index is used */
-        const char *shared_index = git_path("sharedindex.%s",
-                            sha1_to_hex(si->base_sha1));
-        if (!check_and_freshen_file(shared_index, 1))
-            warning("could not freshen '%s'", shared_index);
+        freshen_shared_index(sha1_to_hex(si->base_sha1));
     }

     return write_split_index(istate, lock, flags);
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f448fc13cd..800f84a593 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -313,17 +313,17 @@ EOF
 test_expect_success 'shared index files expire after 7 days by default' '
     : >ten &&
     git update-index --add ten &&
-    test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+    test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
     just_under_7_days_ago=$((1-7*86400)) &&
     test-chmtime =$just_under_7_days_ago .git/sharedindex.* &&
     : >eleven &&
     git update-index --add eleven &&
-    test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+    test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
     just_over_7_days_ago=$((-1-7*86400)) &&
     test-chmtime =$just_over_7_days_ago .git/sharedindex.* &&
     : >twelve &&
     git update-index --add twelve &&
-    test $(ls .git/sharedindex.* | wc -l) = 1
+    test $(ls .git/sharedindex.* | wc -l) -le 2
 '

 test_expect_success 'check splitIndex.sharedIndexExpire set to 8 days' '
@@ -331,12 +331,12 @@ test_expect_success 'check
splitIndex.sharedIndexExpire set to 8 days' '
     test-chmtime =$just_over_7_days_ago .git/sharedindex.* &&
     : >thirteen &&
     git update-index --add thirteen &&
-    test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+    test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
     just_over_8_days_ago=$((-1-8*86400)) &&
     test-chmtime =$just_over_8_days_ago .git/sharedindex.* &&
     : >fourteen &&
     git update-index --add fourteen &&
-    test $(ls .git/sharedindex.* | wc -l) = 1
+    test $(ls .git/sharedindex.* | wc -l) -le 2
 '

 test_expect_success 'check splitIndex.sharedIndexExpire set to
"never" and "now"' '
@@ -345,13 +345,13 @@ test_expect_success 'check
splitIndex.sharedIndexExpire set to "never" and "now"
     test-chmtime =$just_10_years_ago .git/sharedindex.* &&
     : >fifteen &&
     git update-index --add fifteen &&
-    test $(ls .git/sharedindex.* | wc -l) -gt 1 &&
+    test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
     git config splitIndex.sharedIndexExpire now &&
     just_1_second_ago=-1 &&
     test-chmtime =$just_1_second_ago .git/sharedindex.* &&
     : >sixteen &&
     git update-index --add sixteen &&
-    test $(ls .git/sharedindex.* | wc -l) = 1
+    test $(ls .git/sharedindex.* | wc -l) -le 2
 '

 test_done
