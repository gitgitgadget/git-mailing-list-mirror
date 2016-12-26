Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DBD4200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbcLZK3G (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:29:06 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35216 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbcLZK3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:29:05 -0500
Received: by mail-lf0-f68.google.com with SMTP id x140so10745800lfa.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1F9wyZAFE83G3/fyewyfODhG0lj6wBXN+CN8BK847I8=;
        b=pSGKmRFU9LSk/+qgZ2KNj2QQc9OiucSaFglhNPsVlcbYk74CAHe6bOBxd46uXKQVKE
         wMCOIInDi+NRBlKqUO2ZzctDH/NgGXIboog4Ml6HOqvtIqVGRP0Dzwmqjoy6Lz54zD5r
         BKXRiFfltlAnmf7OUxVcJFIRaa0OmbQGmkWrVmLQGV2sN9cNgJSfdLj/8CDOwKZksXMT
         oBbjCSbi2LL3AoT6SoCPnRw17TsEU+b3ngdCaoiZQBZMhqqFRhBeYgiEuhJR8uMPf374
         RSkau24yC2DXkXZzo9DumRq8VdHR6V8vlJjGGXbeLj8iRBhSkxkwrpQYl1fjizWpH2Ll
         IOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1F9wyZAFE83G3/fyewyfODhG0lj6wBXN+CN8BK847I8=;
        b=NIJlV0Mu65FWiDsRgkOsCbtdJTnS7GIB/ZfgIkU0OgtREnexGqmRHfn+zR7gh2pJHq
         WglNqRKOjzKzm8hW8mW7CRhdtCD90Yfm1eI1QCNVArT8/U4izt3jU2B7uy9jhu6nC7HW
         fPt6iHG/JNpQd6WeO7yztUQOpMxxSHRidi90NebdJ2aBQuoM2sWpx0oIr/ZjaSfwy13f
         g/YIc58Vb5kSUfwLaDX9U2NsEZ0W9nU1ArAuXzbx5UzT3twPvF5fj4L7UVcsl90L4P+C
         hn3AqlJfHTsrmawftoYWsjMGd7LE61sr9kSkGDxSF7P1gmSU1vZ3O/zLpKH+6DvYl+fT
         xu9A==
X-Gm-Message-State: AIkVDXLiWAbgn9Mjh7PBe263xEbOzHVNXe1gCdz6rbv7S6NmWYLetRgTFuZW6F8dz3p3i23Y4hLTdI5008ZS+w==
X-Received: by 10.46.7.1 with SMTP id 1mr11192568ljh.76.1482748141785; Mon, 26
 Dec 2016 02:29:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.152.13 with HTTP; Mon, 26 Dec 2016 02:29:01 -0800 (PST)
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Dec 2016 11:29:01 +0100
Message-ID: <CAP8UFD3dam_tfV7J61Oqqtna-LiGAnZARzSG4CkyEk6nKDWsWg@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] Add configuration options for split-index
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

On Mon, Dec 26, 2016 at 11:22 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Highlevel view of the patches in the series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Except for patch 1/21, there are 3 big steps, one for each new
> configuration variable introduced.
>
> There only a few small differences between this patch series and the
> v2 patch series sent a few weeks ago. Only two commits have been
> changed a little, as suggested by Duy.

Here is the diff compared to v2:

diff --git a/config.c b/config.c
index 5c52cefd78..d6c8f8f3ba 100644
--- a/config.c
+++ b/config.c
@@ -1724,7 +1724,7 @@ int git_config_get_untracked_cache(void)

 int git_config_get_split_index(void)
 {
-       int val = -1;
+       int val;

        if (!git_config_get_maybe_bool("core.splitindex", &val))
                return val;
diff --git a/read-cache.c b/read-cache.c
index 772343ab25..bf0ac1ce61 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2227,18 +2227,17 @@ static unsigned long get_shared_index_expire_date(void)
        return shared_index_expire_date;
 }

-static int can_delete_shared_index(const char *shared_sha1_hex)
+static int can_delete_shared_index(const char *shared_index_path)
 {
        struct stat st;
        unsigned long expiration;
-       const char *shared_index = git_path("sharedindex.%s", shared_sha1_hex);

        /* Check timestamp */
        expiration = get_shared_index_expire_date();
        if (!expiration)
                return 0;
-       if (stat(shared_index, &st))
-               return error_errno(_("could not stat '%s"), shared_index);
+       if (stat(shared_index_path, &st))
+               return error_errno(_("could not stat '%s"), shared_index_path);
        if (st.st_mtime > expiration)
                return 0;

@@ -2255,13 +2254,15 @@ static int clean_shared_index_files(const char
*current_hex)

        while ((de = readdir(dir)) != NULL) {
                const char *sha1_hex;
+               const char *shared_index_path;
                if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
                        continue;
                if (!strcmp(sha1_hex, current_hex))
                        continue;
-               if (can_delete_shared_index(sha1_hex) > 0 &&
-                   unlink(git_path("%s", de->d_name)))
-                       error_errno(_("unable to unlink: %s"),
git_path("%s", de->d_name));
+               shared_index_path = git_path("%s", de->d_name);
+               if (can_delete_shared_index(shared_index_path) > 0 &&
+                   unlink(shared_index_path))
+                       error_errno(_("unable to unlink: %s"),
shared_index_path);
        }
        closedir(dir);
