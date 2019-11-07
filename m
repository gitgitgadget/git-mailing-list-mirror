Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF3E1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 01:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbfKGBQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 20:16:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36208 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 20:16:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so239341plp.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 17:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkpQtb0y3TUtDDQmc48M7WCOanQq2C2OapzEGnKv91A=;
        b=n37A3YAy/YPeZK3KTywe+zPFRPZ23oDmGs2H4xFteN6RJAGiCgQx4+jsVT1nqsquXn
         Gfoe/xLmZPz0sZc/aRIZV/d+oOMPR9ZBY53eqse1afrrPyRdUtmcZZLXcJoz1hzlCyeA
         PlRyRE2hXenEiUA8UZHlxxBPD1WjHHaYZLHQ0H5Ncyiw8GMVlBjTwjt7w/LGG8PBwApO
         JGPC0gMWYYRiK5nxZZUfjTTvfhpG0taCNINqd1xJGNi1yPOjKKhP8O8+TKNT9MA7bUVz
         VVHVDwpFpmuydkYknk2sAcdUjOT/MoUAgAfpfiih4+A1MEUgvCDQXL7Lvp3OVfHVld4h
         LkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkpQtb0y3TUtDDQmc48M7WCOanQq2C2OapzEGnKv91A=;
        b=nzQbccKxVtu3o5i8aa7EUieJ30RpQSmMFLhRTWStssWN13IWybzjnkc1XbIF/VJG6A
         SNoBpzKIemK3nL2K9GesQ4TXtAxp5dRpzdvVrvyCWgmja69e5M+tKFLkkkK8anbHL7vA
         zuxjO6eB3GaWcCtrbdPopqEkt8ueOv4t59aT/Vw8x6boMexiZV80gJUj4BzRLM559ivm
         Rd1bR7LcB3QcOUSK2B6I4PQFgOiNL7Ia/drGjA3OGcSusxzqpTkETL5TIOAJpOKCrdF+
         +TXKPY6yTahgim5U87ZyDtNMfoLwaojlaQPgetHT0wKxX1NDLyiyegg6/6PQVUenZx+l
         S/FA==
X-Gm-Message-State: APjAAAW6zJW1WweBvI1vYP/+fPiZzrssoNuTSqBWCJfxnIpjLYJSXSJ4
        cH4wf2Hmq3NRQJMAio9/SDq+Dw==
X-Google-Smtp-Source: APXvYqx4wTlEaXOK/Pqj39ZZxrlEDA/OB3bkVNrcr8RTXxBjqDQ6bAIMsfNMmRhIFQ128zjnB3wBQQ==
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr743676pln.232.1573089386084;
        Wed, 06 Nov 2019 17:16:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id v14sm224940pfe.94.2019.11.06.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:16:25 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:16:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/20] dir: move doc to dir.h
Message-ID: <20191107011620.GF229589@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <cdb32c159a05675d8151c32c71617c6f4070c158.1573034387.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb32c159a05675d8151c32c71617c6f4070c158.1573034387.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 09:59:29AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-directory-listing.txt
> to dir.h as it's easier for the developers to find the usage information
> beside the code instead of looking for it in another doc file.
> 
> Also documentation/technical/api-directory-listing.txt is removed because
> the information it has is now redundant and it'll be hard to keep it up to
> date and synchronized with the documentation in the header files.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  .../technical/api-directory-listing.txt       | 130 ------------------
>  dir.h                                         | 118 +++++++++++++++-
>  2 files changed, 113 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/technical/api-directory-listing.txt
> 
> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
> deleted file mode 100644
> index 76b6e4f71b..0000000000
> --- a/Documentation/technical/api-directory-listing.txt
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -directory listing API
> -=====================
> -
> -The directory listing API is used to enumerate paths in the work tree,
> -optionally taking `.git/info/exclude` and `.gitignore` files per
> -directory into account.
> -
> -Data structure
> ---------------
> -
> -`struct dir_struct` structure is used to pass directory traversal
> -options to the library and to record the paths discovered.  A single
> -`struct dir_struct` is used regardless of whether or not the traversal
> -recursively descends into subdirectories.
> -
> -The notable options are:
> -
> -`exclude_per_dir`::
> -
> -	The name of the file to be read in each directory for excluded
> -	files (typically `.gitignore`).
> -
> -`flags`::
> -
> -	A bit-field of options:
> -
> -`DIR_SHOW_IGNORED`:::
> -
> -	Return just ignored files in `entries[]`, not untracked
> -	files. This flag is mutually exclusive with
> -	`DIR_SHOW_IGNORED_TOO`.
> -
> -`DIR_SHOW_IGNORED_TOO`:::
> -
> -	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
> -	`ignored[]` in addition to untracked files in
> -	`entries[]`. This flag is mutually exclusive with
> -	`DIR_SHOW_IGNORED`.
> -
> -`DIR_KEEP_UNTRACKED_CONTENTS`:::
> -
> -	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is set, the
> -	untracked contents of untracked directories are also returned in
> -	`entries[]`.
> -
> -`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
> -
> -	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
> -	this is set, returns ignored files and directories that match
> -	an exclude pattern. If a directory matches an exclude pattern,
> -	then the directory is returned and the contained paths are
> -	not. A directory that does not match an exclude pattern will
> -	not be returned even if all of its contents are ignored. In
> -	this case, the contents are returned as individual entries.
> -+
> -If this is set, files and directories that explicitly match an ignore
> -pattern are reported. Implicitly ignored directories (directories that
> -do not match an ignore pattern, but whose contents are all ignored)
> -are not reported, instead all of the contents are reported.
> -
> -`DIR_COLLECT_IGNORED`:::
> -
> -	Special mode for git-add. Return ignored files in `ignored[]` and
> -	untracked files in `entries[]`. Only returns ignored files that match
> -	pathspec exactly (no wildcards). Does not recurse into ignored
> -	directories.
> -
> -`DIR_SHOW_OTHER_DIRECTORIES`:::
> -
> -	Include a directory that is not tracked.
> -
> -`DIR_HIDE_EMPTY_DIRECTORIES`:::
> -
> -	Do not include a directory that is not tracked and is empty.
> -
> -`DIR_NO_GITLINKS`:::
> -
> -	If set, recurse into a directory that looks like a Git
> -	directory.  Otherwise it is shown as a directory.
> -
> -The result of the enumeration is left in these fields:
> -
> -`entries[]`::
> -
> -	An array of `struct dir_entry`, each element of which describes
> -	a path.
> -
> -`nr`::
> -
> -	The number of members in `entries[]` array.
> -
> -`alloc`::
> -
> -	Internal use; keeps track of allocation of `entries[]` array.
> -
> -`ignored[]`::
> -
> -	An array of `struct dir_entry`, used for ignored paths with the
> -	`DIR_SHOW_IGNORED_TOO` and `DIR_COLLECT_IGNORED` flags.
> -
> -`ignored_nr`::
> -
> -	The number of members in `ignored[]` array.
> -
> -Calling sequence
> -----------------
> -
> -Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
> -marked. If you to exclude files, make sure you have loaded index first.
> -
> -* Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
> -  sizeof(dir))`.
> -
> -* To add single exclude pattern, call `add_pattern_list()` and then
> -  `add_pattern()`.
> -
> -* To add patterns from a file (e.g. `.git/info/exclude`), call
> -  `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
> -  short-hand function `setup_standard_excludes()` can be used to set
> -  up the standard set of exclude settings.
> -
> -* Set options described in the Data Structure section above.
> -
> -* Call `read_directory()`.
> -
> -* Use `dir.entries[]`.
> -
> -* Call `clear_directory()` when none of the contained elements are no longer in use.
> -
> -(JC)
> diff --git a/dir.h b/dir.h
> index 2fbdef014f..1b41d29c07 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -1,11 +1,43 @@
>  #ifndef DIR_H
>  #define DIR_H
>  
> -/* See Documentation/technical/api-directory-listing.txt */
> -
>  #include "cache.h"
>  #include "strbuf.h"
>  
> +/**
> + * The directory listing API is used to enumerate paths in the work tree,
> + * optionally taking `.git/info/exclude` and `.gitignore` files per directory
> + * into account.
> + */
> +
> +/**
> + * Calling sequence
> + * ----------------
> + *
> + * Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
> + * marked. If you to exclude files, make sure you have loaded index first.

I know this is verbatim from the old doc, but the grammar is a little
off. Might be a good chance to fix it up (or add another patch on top
doing so?)

> + *
> + * - Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
> + * sizeof(dir))`.
> + *
> + * - To add single exclude pattern, call `add_pattern_list()` and then
> + *   `add_pattern()`.
> + *
> + * - To add patterns from a file (e.g. `.git/info/exclude`), call
> + *   `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
> + *   short-hand function `setup_standard_excludes()` can be used to set
> + *   up the standard set of exclude settings.
> + *
> + * - Set options described in the Data Structure section above.
> + *
> + * - Call `read_directory()`.
> + *
> + * - Use `dir.entries[]`.
> + *
> + * - Call `clear_directory()` when none of the contained elements are no longer in use.
> + *
> + */
> +
>  struct dir_entry {
>  	unsigned int len;
>  	char name[FLEX_ARRAY]; /* more */
> @@ -144,25 +176,101 @@ struct untracked_cache {
>  	unsigned int use_fsmonitor : 1;
>  };
>  
> +/**
> + * pass directory traversal options to the library and to record the paths
> + * discovered. A single `struct dir_struct` is used regardless of whether or
> + * not the traversal recursively descends into subdirectories.

I wouldn't mind seeing some minor rewording to make the language here
agree with itself, since it's no longer being led with a subject noun.
Or, you could still tack "This struct is used to" or even "Used to" onto
the front so that the language makes sense again.

The way the language is now with the subject cropped out, it sounds like
you're describing a function which does the pass + record for you (to
me).

> + */
>  struct dir_struct {
> -	int nr, alloc;
> -	int ignored_nr, ignored_alloc;
> +
> +    /* The number of members in `entries[]` array. */
> +    int nr;
> +
> +    /* Internal use; keeps track of allocation of `entries[]` array.*/
> +    int alloc;
> +
> +    /* The number of members in `ignored[]` array. */
> +	int ignored_nr;
> +
> +	int ignored_alloc;
> +
> +	/* bit-field of options */
>  	enum {
> +
> +	    /**
> +	     * Return just ignored files in `entries[]`, not untracked files.
> +	     * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
> +	     */

I think something went wrong with the whitespace on this section (most of
the rest looks OK).

>  		DIR_SHOW_IGNORED = 1<<0,
> +
> +		/* Include a directory that is not tracked. */
>  		DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
> +
> +		/* Do not include a directory that is not tracked and is empty. */
>  		DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
> +
> +		/**
> +		 * If set, recurse into a directory that looks like a Git directory.
> +		 * Otherwise it is shown as a directory.
> +		 */
>  		DIR_NO_GITLINKS = 1<<3,
> +
> +		/**
> +		 * Special mode for git-add. Return ignored files in `ignored[]` and
> +	     * untracked files in `entries[]`. Only returns ignored files that match
> +	     * pathspec exactly (no wildcards). Does not recurse into ignored
> +	     * directories.
> +		 */
>  		DIR_COLLECT_IGNORED = 1<<4,
> +
> +		/**
> +		 * Similar to `DIR_SHOW_IGNORED`, but return ignored files in
> +		 * `ignored[]` in addition to untracked files in `entries[]`.
> +		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED`.
> +		 */
>  		DIR_SHOW_IGNORED_TOO = 1<<5,
> +
>  		DIR_COLLECT_KILLED_ONLY = 1<<6,
> +
> +        /**
> +         * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
> +         * set, the untracked contents of untracked directories are also
> +         * returned in `entries[]`.
> +         */
>  		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
> +
> +		/**
> +		 * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
> +		 * set, returns ignored files and directories that match an exclude
> +		 * pattern. If a directory matches an exclude pattern, then the
> +		 * directory is returned and the contained paths are not. A directory
> +		 * that does not match an exclude pattern will not be returned even if
> +		 * all of its contents are ignored. In this case, the contents are
> +		 * returned as individual entries.
> +		 *
> +		 * If this is set, files and directories that explicitly match an ignore
> +         * pattern are reported. Implicitly ignored directories (directories that
> +         * do not match an ignore pattern, but whose contents are all ignored)
> +         * are not reported, instead all of the contents are reported.
> +		 */
>  		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8,
> +
>  		DIR_SKIP_NESTED_GIT = 1<<9
>  	} flags;
> +
> +	/* An array of `struct dir_entry`, each element of which describes a path. */
>  	struct dir_entry **entries;
> +
> +	/**
> +	 * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
> +	 * `DIR_COLLECT_IGNORED` flags.
> +	 */
>  	struct dir_entry **ignored;
>  
> -	/* Exclude info */
> +	/**
> +	 * The name of the file to be read in each directory for excluded files
> +	 * (typically `.gitignore`).
> +	 */
>  	const char *exclude_per_dir;
>  
>  	/*
> -- 
> gitgitgadget
> 
