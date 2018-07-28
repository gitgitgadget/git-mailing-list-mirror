Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99F71F597
	for <e@80x24.org>; Sat, 28 Jul 2018 04:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeG1GBF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 02:01:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39938 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeG1GBE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 02:01:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19-v6so6073111ljc.7
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 21:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nslKXmlNSHP8Pms1ZrTcJEenP6rJBbDbBweptJ2sws4=;
        b=NY/46Vvt5PF7i5mFLRGH/0GfsdAaOziNZdCVHFsL7E6z3Xnthrsq03RQuIfizQSaIM
         TwkrHNP5LwRgpDhuJRQNdsNsOWKqU2KGh/tK8GfP6yn1pzE1zkNw2lgfsL6wcmk+rl0P
         A2cb+Ar2Q+SHad9UuepQn8UuSg2es8YdvE6zSWAquIcM+0Uw2X0+v5H4G4OFh+69auz3
         grLhouMkuhgSvu3nOiThqYUeTzt0z+U4mtIw3p8A9MrbPJGMvKYm64hO3mrigcQWTfnC
         2P7Q+EeZX5MhFfoXCCNRfgISNLs7sfkqxy/cnD1IuJ/XL2cF7F/LQxGh1zw+WCLiEe66
         YngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nslKXmlNSHP8Pms1ZrTcJEenP6rJBbDbBweptJ2sws4=;
        b=pTBWw1ugvU+b1IzvlI62aAN2mi19rdDpCGgY+rjozuWPSRv527tYGdu9DE00MOIjaV
         8x19cZnWjsCcFnbVEqcBC1XpNoumx5IWMQii7woWLAe2I3DOOq0SJb3xnoetFQG6ilcD
         5VnfRrihY8gNNH8eRuSgcxSZxQ7vu/C7nj5daj9O9To6qWgnCEBB8TNuwZoUxLBdcPAh
         TrmZWiPbXoymSuR+ek+3JL9H55QBOciFNT767gQ1ivecTuYlxpmuKc93JMKUptbUsgQY
         NRQ8laFn6cX9d/DX3yR9r5QuJjNSW6/66JexPhcUY/G6hP5q2C1//LYa4JrrX4S+NNbj
         iC5A==
X-Gm-Message-State: AOUpUlFOTCC/yOadb7eEmb1Mj8Yh3REC86S+3Oyz3C3MmcxRIp2brZeb
        SeTluvlXKLgtsqDtxuw0h6g=
X-Google-Smtp-Source: AAOMgpc7H1QO92xTuMDYeKgBsC9QrU2bi5FTLKvA8qqtlL/3jTU36e+mLVG5/m9EmT4EtMUaJ9Xevw==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr6983284ljf.79.1532752562896;
        Fri, 27 Jul 2018 21:36:02 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r22-v6sm963881ljh.22.2018.07.27.21.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 21:36:01 -0700 (PDT)
Date:   Sat, 28 Jul 2018 06:36:00 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git clone and case sensitivity
Message-ID: <20180728043559.GA29185@duynguyen.home>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727205909.GC376343@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 08:59:09PM +0000, brian m. carlson wrote:
> On Fri, Jul 27, 2018 at 11:59:33AM +0200, Paweł Paruzel wrote:
> > Hi,
> > 
> > Lately, I have been wondering why my test files in repo are modified
> > after I clone it. It turned out to be two files: boolStyle_t_f and
> > boolStyle_T_F.
> > The system that pushed those files was case sensitive while my mac
> > after High Sierra update had APFS which is by default
> > case-insensitive. I highly suggest that git clone threw an exception
> > when files are case sensitive and being cloned to a case insensitive
> > system. This has caused problems with overriding files for test cases
> > without any warning.
> 
> If we did what you proposed, it would be impossible to clone such a
> repository on a case-insensitive system.

I agree throwing a real exception would be bad. But how about detecting
the problem and trying our best to keep the repo in somewhat usable
state like this?

This patch uses sparse checkout to hide all those paths that we fail
to checkout, so you can still have a clean worktree to do things, as
long as you don't touch those paths.

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 1d939af9d8..a6b5e2c948 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -711,6 +711,30 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	}
 }
 
+static int enable_sparse_checkout_on_icase_fs(struct index_state *istate)
+{
+	int i;
+	int skip_count = 0;
+	FILE *fp = fopen(git_path("info/sparse"), "a+");
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (!ce_skip_worktree(ce))
+			continue;
+		if (!skip_count) {
+			git_config_set_multivar_gently("core.sparseCheckout",
+						       "true",
+						       CONFIG_REGEX_NONE, 0);
+			fprintf(fp, "# List of paths hidden by 'git clone'\n");
+		}
+		fprintf(fp, "/%s\n", ce->name);
+		skip_count++;
+	}
+	fclose(fp);
+
+	return skip_count;
+}
+
 static int checkout(int submodule_progress)
 {
 	struct object_id oid;
@@ -751,6 +775,7 @@ static int checkout(int submodule_progress)
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.clone_checkout = 1;
 
 	tree = parse_tree_indirect(&oid);
 	parse_tree(tree);
@@ -761,6 +786,12 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
+	if (enable_sparse_checkout_on_icase_fs(&the_index))
+		warning("Paths that differ only in case are detected "
+			"and will not work correctly on this case-insensitive "
+			"filesystem. Sparse checkout has been enabled to hide "
+			"these paths.");
+
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   oid_to_hex(&oid), "1", NULL);
 
diff --git a/cache.h b/cache.h
index 8b447652a7..9ecf7ad952 100644
--- a/cache.h
+++ b/cache.h
@@ -1455,6 +1455,7 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 set_skipworktree_on_updated:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/entry.c b/entry.c
index b5d1d3cf23..ba21db63e7 100644
--- a/entry.c
+++ b/entry.c
@@ -447,6 +447,11 @@ int checkout_entry(struct cache_entry *ce,
 
 		if (!changed)
 			return 0;
+		if (state->set_skipworktree_on_updated) {
+			ce->ce_flags |= CE_SKIP_WORKTREE;
+			state->istate->cache_changed |= CE_ENTRY_CHANGED;
+			return 0;
+		}
 		if (!state->force) {
 			if (!state->quiet)
 				fprintf(stderr,
diff --git a/unpack-trees.c b/unpack-trees.c
index 66741130ae..a8a24e0b13 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -358,6 +358,7 @@ static int check_updates(struct unpack_trees_options *o)
 	state.quiet = 1;
 	state.refresh_cache = 1;
 	state.istate = index;
+	state.set_skipworktree_on_updated = o->clone_checkout;
 
 	progress = get_progress(o);
 
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..8ebe2e2ec5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -49,6 +49,7 @@ struct unpack_trees_options {
 		     aggressive,
 		     skip_unmerged,
 		     initial_checkout,
+		     clone_checkout,
 		     diff_index_cached,
 		     debug_unpack,
 		     skip_sparse_checkout,
-- 8< --

> While this might be fine for a closed system such as inside a
> company, this would make many open source repositories unusable,
> even when the files differing in case are nonfunctional (like README
> and readme).
> 
> This is actually one of a few ways people can make repositories that
> will show as modified on Windows or macOS systems, due to limitations in
> those OSes.  If you want to be sure that your repository is unmodified
> after clone, you can ensure that the output of git status --porcelain is
> empty, such as by checking for a zero exit from
> "test $(git status --porcelain | wc -l) -eq 0".
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


