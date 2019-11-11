Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349551F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 00:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfKKAUO (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 19:20:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36092 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKKAUN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 19:20:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id f7so10567910edq.3
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hl4LssjykR9R5iv5d0f6xYk8m+5WbfsrkRZ4Eo6omtI=;
        b=ZHSHbbAsVzUkrAd8NVG6MVuIrXB2suJXjPUZgtFRFvScIfUbeZe3+2eAg2V4VH6Cdc
         0cJqgfK9kz6d/+SaDz/oP1U1BaT749ELsK8v4jNj15d/Vti1+BflPYnD3WWGl7HmUWQS
         XCp8/BuIYnZIfTRz0mj32SuVzNVmfWcDwUIXr+6rWghcaddXeR+UcG3yf+xvByDV4jVn
         pMQtJLAN/KaLjABF5AWMnam78dM9Kcxtxg/RSvsC7fa/lrVEEa2AO0xKjxZ/0DKvK4oP
         xpDHa5rgt8nrAdBXStrsnB3B/dhn9qe5s7aPmRrBiLynGD1pBFmY93tSvyHiaj/sZ/03
         Es+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl4LssjykR9R5iv5d0f6xYk8m+5WbfsrkRZ4Eo6omtI=;
        b=BB2ZoMHVAMOCRkWAKbDX4HLcsdMKB9wPa4vKf0Fo9lfMi2FMDvOrO/zt58BGwFW9S8
         T8fQIF7JDugh6plP3x+jkt42+ABG6bafo9MJlWzQDgbwUOLt1XufogeV7+mHK5U7Salm
         mxBSpIUwEOQK1q8uzBn1vUMShHJCck+IuzZlVez9N8wyRQ0CiotE+ajFrgreEvSan9Zq
         QNTGGVddEBb+JKrxnf3PtwHXIEjI2JdCd24SkzyBDhbuHX1TjEEN9LaKH4cSwDcUxYTp
         +iXaWn/qYkqWOy8ojDYzRV6WSD0HzXTm8UMJZXzj4PSQNig/pMA6Ptsr4hlDFjgCLVng
         PkRQ==
X-Gm-Message-State: APjAAAVS/k8bmE1TZiPPpxiYY+w0TsOb3NIW+P8x81/LA32dpcc0/6mL
        0379d71TrJkvdmtHBcLylj4P7tiUoO0NVeW7nNc=
X-Google-Smtp-Source: APXvYqzvq6f5EkbhaW9A/51TsulQmmT0Em+O2TTrQBU+SIet/HyGolfLzZ9FS/KTnIn73AjbFHSOiunp0n26NB1noRo=
X-Received: by 2002:a50:fc18:: with SMTP id i24mr23418026edr.41.1573431611338;
 Sun, 10 Nov 2019 16:20:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com> <cdb32c159a05675d8151c32c71617c6f4070c158.1573034387.git.gitgitgadget@gmail.com>
 <20191107011620.GF229589@google.com>
In-Reply-To: <20191107011620.GF229589@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 11 Nov 2019 13:20:00 +1300
Message-ID: <CACg5j25fv3Yjc1Hrucbq1hqxAcdAVsYYPtodtkzhBaXx3M0=xQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] dir: move doc to dir.h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 7, 2019 at 2:16 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Nov 06, 2019 at 09:59:29AM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Move the documentation from Documentation/technical/api-directory-listing.txt
> > to dir.h as it's easier for the developers to find the usage information
> > beside the code instead of looking for it in another doc file.
> >
> > Also documentation/technical/api-directory-listing.txt is removed because
> > the information it has is now redundant and it'll be hard to keep it up to
> > date and synchronized with the documentation in the header files.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  .../technical/api-directory-listing.txt       | 130 ------------------
> >  dir.h                                         | 118 +++++++++++++++-
> >  2 files changed, 113 insertions(+), 135 deletions(-)
> >  delete mode 100644 Documentation/technical/api-directory-listing.txt
> >
> > diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
> > deleted file mode 100644
> > index 76b6e4f71b..0000000000
> > --- a/Documentation/technical/api-directory-listing.txt
> > +++ /dev/null
> > @@ -1,130 +0,0 @@
> > -directory listing API
> > -=====================
> > -
> > -The directory listing API is used to enumerate paths in the work tree,
> > -optionally taking `.git/info/exclude` and `.gitignore` files per
> > -directory into account.
> > -
> > -Data structure
> > ---------------
> > -
> > -`struct dir_struct` structure is used to pass directory traversal
> > -options to the library and to record the paths discovered.  A single
> > -`struct dir_struct` is used regardless of whether or not the traversal
> > -recursively descends into subdirectories.
> > -
> > -The notable options are:
> > -
> > -`exclude_per_dir`::
> > -
> > -     The name of the file to be read in each directory for excluded
> > -     files (typically `.gitignore`).
> > -
> > -`flags`::
> > -
> > -     A bit-field of options:
> > -
> > -`DIR_SHOW_IGNORED`:::
> > -
> > -     Return just ignored files in `entries[]`, not untracked
> > -     files. This flag is mutually exclusive with
> > -     `DIR_SHOW_IGNORED_TOO`.
> > -
> > -`DIR_SHOW_IGNORED_TOO`:::
> > -
> > -     Similar to `DIR_SHOW_IGNORED`, but return ignored files in
> > -     `ignored[]` in addition to untracked files in
> > -     `entries[]`. This flag is mutually exclusive with
> > -     `DIR_SHOW_IGNORED`.
> > -
> > -`DIR_KEEP_UNTRACKED_CONTENTS`:::
> > -
> > -     Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is set, the
> > -     untracked contents of untracked directories are also returned in
> > -     `entries[]`.
> > -
> > -`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
> > -
> > -     Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
> > -     this is set, returns ignored files and directories that match
> > -     an exclude pattern. If a directory matches an exclude pattern,
> > -     then the directory is returned and the contained paths are
> > -     not. A directory that does not match an exclude pattern will
> > -     not be returned even if all of its contents are ignored. In
> > -     this case, the contents are returned as individual entries.
> > -+
> > -If this is set, files and directories that explicitly match an ignore
> > -pattern are reported. Implicitly ignored directories (directories that
> > -do not match an ignore pattern, but whose contents are all ignored)
> > -are not reported, instead all of the contents are reported.
> > -
> > -`DIR_COLLECT_IGNORED`:::
> > -
> > -     Special mode for git-add. Return ignored files in `ignored[]` and
> > -     untracked files in `entries[]`. Only returns ignored files that match
> > -     pathspec exactly (no wildcards). Does not recurse into ignored
> > -     directories.
> > -
> > -`DIR_SHOW_OTHER_DIRECTORIES`:::
> > -
> > -     Include a directory that is not tracked.
> > -
> > -`DIR_HIDE_EMPTY_DIRECTORIES`:::
> > -
> > -     Do not include a directory that is not tracked and is empty.
> > -
> > -`DIR_NO_GITLINKS`:::
> > -
> > -     If set, recurse into a directory that looks like a Git
> > -     directory.  Otherwise it is shown as a directory.
> > -
> > -The result of the enumeration is left in these fields:
> > -
> > -`entries[]`::
> > -
> > -     An array of `struct dir_entry`, each element of which describes
> > -     a path.
> > -
> > -`nr`::
> > -
> > -     The number of members in `entries[]` array.
> > -
> > -`alloc`::
> > -
> > -     Internal use; keeps track of allocation of `entries[]` array.
> > -
> > -`ignored[]`::
> > -
> > -     An array of `struct dir_entry`, used for ignored paths with the
> > -     `DIR_SHOW_IGNORED_TOO` and `DIR_COLLECT_IGNORED` flags.
> > -
> > -`ignored_nr`::
> > -
> > -     The number of members in `ignored[]` array.
> > -
> > -Calling sequence
> > -----------------
> > -
> > -Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
> > -marked. If you to exclude files, make sure you have loaded index first.
> > -
> > -* Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
> > -  sizeof(dir))`.
> > -
> > -* To add single exclude pattern, call `add_pattern_list()` and then
> > -  `add_pattern()`.
> > -
> > -* To add patterns from a file (e.g. `.git/info/exclude`), call
> > -  `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
> > -  short-hand function `setup_standard_excludes()` can be used to set
> > -  up the standard set of exclude settings.
> > -
> > -* Set options described in the Data Structure section above.
> > -
> > -* Call `read_directory()`.
> > -
> > -* Use `dir.entries[]`.
> > -
> > -* Call `clear_directory()` when none of the contained elements are no longer in use.
> > -
> > -(JC)
> > diff --git a/dir.h b/dir.h
> > index 2fbdef014f..1b41d29c07 100644
> > --- a/dir.h
> > +++ b/dir.h
> > @@ -1,11 +1,43 @@
> >  #ifndef DIR_H
> >  #define DIR_H
> >
> > -/* See Documentation/technical/api-directory-listing.txt */
> > -
> >  #include "cache.h"
> >  #include "strbuf.h"
> >
> > +/**
> > + * The directory listing API is used to enumerate paths in the work tree,
> > + * optionally taking `.git/info/exclude` and `.gitignore` files per directory
> > + * into account.
> > + */
> > +
> > +/**
> > + * Calling sequence
> > + * ----------------
> > + *
> > + * Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
> > + * marked. If you to exclude files, make sure you have loaded index first.
>
> I know this is verbatim from the old doc, but the grammar is a little
> off. Might be a good chance to fix it up (or add another patch on top
> doing so?)
>

Yes, will fix it up.

> > + *
> > + * - Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
> > + * sizeof(dir))`.
> > + *
> > + * - To add single exclude pattern, call `add_pattern_list()` and then
> > + *   `add_pattern()`.
> > + *
> > + * - To add patterns from a file (e.g. `.git/info/exclude`), call
> > + *   `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
> > + *   short-hand function `setup_standard_excludes()` can be used to set
> > + *   up the standard set of exclude settings.
> > + *
> > + * - Set options described in the Data Structure section above.
> > + *
> > + * - Call `read_directory()`.
> > + *
> > + * - Use `dir.entries[]`.
> > + *
> > + * - Call `clear_directory()` when none of the contained elements are no longer in use.
> > + *
> > + */
> > +
> >  struct dir_entry {
> >       unsigned int len;
> >       char name[FLEX_ARRAY]; /* more */
> > @@ -144,25 +176,101 @@ struct untracked_cache {
> >       unsigned int use_fsmonitor : 1;
> >  };
> >
> > +/**
> > + * pass directory traversal options to the library and to record the paths
> > + * discovered. A single `struct dir_struct` is used regardless of whether or
> > + * not the traversal recursively descends into subdirectories.
>
> I wouldn't mind seeing some minor rewording to make the language here
> agree with itself, since it's no longer being led with a subject noun.
> Or, you could still tack "This struct is used to" or even "Used to" onto
> the front so that the language makes sense again.
>
> The way the language is now with the subject cropped out, it sounds like
> you're describing a function which does the pass + record for you (to
> me).

I agree.

> > + */
> >  struct dir_struct {
> > -     int nr, alloc;
> > -     int ignored_nr, ignored_alloc;
> > +
> > +    /* The number of members in `entries[]` array. */
> > +    int nr;
> > +
> > +    /* Internal use; keeps track of allocation of `entries[]` array.*/
> > +    int alloc;
> > +
> > +    /* The number of members in `ignored[]` array. */
> > +     int ignored_nr;
> > +
> > +     int ignored_alloc;
> > +
> > +     /* bit-field of options */
> >       enum {
> > +
> > +         /**
> > +          * Return just ignored files in `entries[]`, not untracked files.
> > +          * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
> > +          */
>
> I think something went wrong with the whitespace on this section (most of
> the rest looks OK).

Oh, thank you, my new editor needed some settings adjustments, will go
through all changes to make sure nothing was missed.

> >               DIR_SHOW_IGNORED = 1<<0,
> > +
> > +             /* Include a directory that is not tracked. */
> >               DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
> > +
> > +             /* Do not include a directory that is not tracked and is empty. */
> >               DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
> > +
> > +             /**
> > +              * If set, recurse into a directory that looks like a Git directory.
> > +              * Otherwise it is shown as a directory.
> > +              */
> >               DIR_NO_GITLINKS = 1<<3,
> > +
> > +             /**
> > +              * Special mode for git-add. Return ignored files in `ignored[]` and
> > +          * untracked files in `entries[]`. Only returns ignored files that match
> > +          * pathspec exactly (no wildcards). Does not recurse into ignored
> > +          * directories.
> > +              */
> >               DIR_COLLECT_IGNORED = 1<<4,
> > +
> > +             /**
> > +              * Similar to `DIR_SHOW_IGNORED`, but return ignored files in
> > +              * `ignored[]` in addition to untracked files in `entries[]`.
> > +              * This flag is mutually exclusive with `DIR_SHOW_IGNORED`.
> > +              */
> >               DIR_SHOW_IGNORED_TOO = 1<<5,
> > +
> >               DIR_COLLECT_KILLED_ONLY = 1<<6,
> > +
> > +        /**
> > +         * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
> > +         * set, the untracked contents of untracked directories are also
> > +         * returned in `entries[]`.
> > +         */
> >               DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
> > +
> > +             /**
> > +              * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
> > +              * set, returns ignored files and directories that match an exclude
> > +              * pattern. If a directory matches an exclude pattern, then the
> > +              * directory is returned and the contained paths are not. A directory
> > +              * that does not match an exclude pattern will not be returned even if
> > +              * all of its contents are ignored. In this case, the contents are
> > +              * returned as individual entries.
> > +              *
> > +              * If this is set, files and directories that explicitly match an ignore
> > +         * pattern are reported. Implicitly ignored directories (directories that
> > +         * do not match an ignore pattern, but whose contents are all ignored)
> > +         * are not reported, instead all of the contents are reported.
> > +              */
> >               DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8,
> > +
> >               DIR_SKIP_NESTED_GIT = 1<<9
> >       } flags;
> > +
> > +     /* An array of `struct dir_entry`, each element of which describes a path. */
> >       struct dir_entry **entries;
> > +
> > +     /**
> > +      * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
> > +      * `DIR_COLLECT_IGNORED` flags.
> > +      */
> >       struct dir_entry **ignored;
> >
> > -     /* Exclude info */
> > +     /**
> > +      * The name of the file to be read in each directory for excluded files
> > +      * (typically `.gitignore`).
> > +      */
> >       const char *exclude_per_dir;
> >
> >       /*
> > --
> > gitgitgadget
> >

Thanks,
Heba
