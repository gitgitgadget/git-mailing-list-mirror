Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC75C20248
	for <e@80x24.org>; Sat,  6 Apr 2019 14:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDFOld (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 10:41:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfDFOld (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 10:41:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so11277124wrp.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F3Uq1Obsz4zbzsor7xGAyxIN9hLidzYedghl2QLpYOs=;
        b=TVGXWOVU927rSnVEvvObmgzRyzU5stPoZDl/Dd6+YzUFrbPEDwr0Zaee1BawAvRUIu
         V8p03zqPIjrBodwP3ZEYr5UGxN3yGbMv7Ze2AtSn12GO3QJ+vN94luuKUyi+FU/iLwow
         Ni0IWx1QElVIQpCeFcqxg/+vcusr5BTppj/HqTA4gvk1GUoAIUlSU/vxaf/QvdvaITKA
         o4/rNIpAQWh4/mO7XOPUKF10vqWYEj0z6Ga8U8PbxAD/xnR2/rQOp42qS/Qe3+fP8Nj7
         knw2yK+xoe1vDFN3cgrmyrmKQ8RmUgQBlT6qNHxrF2e2Z8v25x6xT/qCetvUGgkPdIGe
         oSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F3Uq1Obsz4zbzsor7xGAyxIN9hLidzYedghl2QLpYOs=;
        b=k+vA0HPQE+P3h6v+NzKH05LF4cdwqdT1lHJ6WFFJmsI3OsKnih+OnX0r1yfLFS72Fs
         kqx2rhGDZofLZ4Zuulaphp0XDG8JAlXvqH6+cdDdlnlyOuR+QgKcCsOoQtO3O4Mt2Vzm
         VWZvW/5YP79E7ELZ1V6PtLW0McCN/P8mJ/ugFhxRk/Ray5O3eitghJo/YA7fseBotLGH
         /r7rf0pmsbeP57IyJCtd8RGlgq8sRkqL2tBNeth1Z5XR58s0lzjXDKYCgRKQdjXV+S0d
         pAWpBw5A4M7xRHMJjXG0/xt9UWm+s1tGPFjQS21741TLkBJwuhw9Y8QQSHKFuo59qoAo
         kxjg==
X-Gm-Message-State: APjAAAW2FuGj4QHghZcRR6PaArW2W1DYom7xXqy+xroWhirLmlh3MiXW
        mdaBOuW1xhMcF5MKsZA2p/w=
X-Google-Smtp-Source: APXvYqw2HaHou1yNJNnjYnoA32QD4EvXZ7V8l5QPsXP/zr/vjmhrlZMb4hhMDm9eBwYeuHDc0jTvbQ==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr12806081wrv.281.1554561690773;
        Sat, 06 Apr 2019 07:41:30 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id 84sm12007779wme.43.2019.04.06.07.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 07:41:28 -0700 (PDT)
Date:   Sat, 6 Apr 2019 15:41:27 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     UTKARSH RAI <utkarsh.rai60@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [[GSoC][PATCH =?utf-8?B?4oCmXQ==?= =?utf-8?Q?=5D?= In
 notes-merge.c updated notes_merge_commit()
Message-ID: <20190406144127.GZ32487@hank.intra.tgummerer.com>
References: <01020169ee702e51-e9c8d564-10f5-49e9-a411-fd7ceaef7afc-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01020169ee702e51-e9c8d564-10f5-49e9-a411-fd7ceaef7afc-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [[GSoC][PATCH …]] In notes-merge.c updated notes_merge_commit()

Commit messages are usually in the format "<area>: <short
description>".  So a better title might be "notes-merge: use
dir-iterator in notes_merge_commit".  It would also be beneficial for
you to have a look at the mailing list archives at
https://public-inbox.org/git/, and search for similar patches, to see
how they have been done.

On 04/05, UTKARSH RAI wrote:
> Updated notes_merge_commit() by replacing readdir() ,opendir() apis by replacing them with dir_iterator_advance() and dir_iterator_begin() respectively.

Please wrap commit messages at around 72 characters or less.  Also the
commit message should be written in the imperative mood, see also
Documentation/SubmittingPatches.

> Signed-off-by: ur10 <utkarsh.rai60@gmail.com>

The name in the Signed-off-by line should match the author of the
commit.  Also there should be a blank line between the commit message
and the Signed-off-by line.

> ---
>  notes-merge.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/notes-merge.c b/notes-merge.c
> index 280aa8e6c1b04..dc4e2cce7151a 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -13,6 +13,8 @@
>  #include "strbuf.h"
>  #include "notes-utils.h"
>  #include "commit-reach.h"
> +#include "dir-iterator.h"
> +#include "iterator.h"
>  
>  struct notes_merge_pair {
>  	struct object_id obj, base, local, remote;
> @@ -673,8 +675,8 @@ int notes_merge_commit(struct notes_merge_options *o,
>  	 * commit message and parents from 'partial_commit'.
>  	 * Finally store the new commit object OID into 'result_oid'.
>  	 */
> -	DIR *dir;
> -	struct dirent *e;
> +	struct dir_iterator *iter;
> +	int ok;
>  	struct strbuf path = STRBUF_INIT;
>  	const char *buffer = get_commit_buffer(partial_commit, NULL);
>  	const char *msg = strstr(buffer, "\n\n");
> @@ -689,27 +691,27 @@ int notes_merge_commit(struct notes_merge_options *o,
>  		die("partial notes commit has empty message");
>  	msg += 2;
>  
> -	dir = opendir(path.buf);
> -	if (!dir)
> +	iter = dir_iterator_begin(path.buf);
> +	if (!iter)
>  		die_errno("could not open %s", path.buf);
>  
>  	strbuf_addch(&path, '/');
>  	baselen = path.len;
> -	while ((e = readdir(dir)) != NULL) {
> +	while ((ok = dir_iterator_advance(iter) )== ITER_OK) {

Style: please don't leave a space between the closing braces, but
there should be a space before the ==.

But more importantly, there's a change in behaviour here, previously
we wouldn't recurse into any subdirectories if there are any, while
now we do.  It looks like there cannot be any subdirectories in this
directory, so this might be fine, but I didn't check in detail.  This
is something that you should investigate and describe in the commit
message.

>  		struct stat st;
>  		struct object_id obj_oid, blob_oid;
>  
> -		if (is_dot_or_dotdot(e->d_name))
> +		if (is_dot_or_dotdot(iter->basename))
>  			continue;

The above condition is no longer necessary, as dir-iterator already
skips these directories by default.

>  
> -		if (get_oid_hex(e->d_name, &obj_oid)) {
> +		if (get_oid_hex(iter->basename, &obj_oid)) {
>  			if (o->verbosity >= 3)
>  				printf("Skipping non-SHA1 entry '%s%s'\n",
> -					path.buf, e->d_name);
> +					path.buf, iter->basename);
>  			continue;
>  		}
>  
> -		strbuf_addstr(&path, e->d_name);
> +		strbuf_addstr(&path,iter->basename);

Style: missing space after the comma.

>  		/* write file as blob, and add to partial_tree */
>  		if (stat(path.buf, &st))
>  			die_errno("Failed to stat '%s'", path.buf);
> @@ -731,7 +733,7 @@ int notes_merge_commit(struct notes_merge_options *o,
>  		printf("Finalized notes merge commit: %s\n",
>  			oid_to_hex(result_oid));
>  	strbuf_release(&path);
> -	closedir(dir);
> +	

Please remove trailing spaces/tabs.  You can check for this using 'git
diff --check [base]...HEAD', and fix it with 'git rebase --whitespace=fix'.

>  	return 0;
>  }
>  
> 
> --
> https://github.com/git/git/pull/594
