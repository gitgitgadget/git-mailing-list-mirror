Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RDNS_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (unknown [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE7020248
	for <e@80x24.org>; Sat,  9 Mar 2019 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCIQMb (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 11:12:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35967 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfCIQMb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 11:12:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so507588wmj.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZW+nJZUKu/kn9rdzsMf6SUVZ0gHS5SbX8xZHN4zvR8c=;
        b=uQQWMTwlNd98ZMEk41M4Qg7zeRdUb/OBvVHMAXKV9QvXbOguXbWCR8lVYE0v6UteIU
         XF3JAyXvFZGriSGhFtYumZKbqz5pximeq882YuiQZB1iNG8KKWfNsOBUUQjmhLThqbUJ
         yqBY+xrkylBlkHf4YvW7KrYIM5PwqU4gwSFO/UMUOQlXGr193rBZ/M2CRczKNYas+rJs
         7kADdIYd5j5oVfgvQonqUMZqlrxBJgyrMoh/3ch0l1/Nwbz6SVtWfQTLFTWxGkXB5Ou6
         Q+efMSOACbQSF7TI0oZj94UvtsrrOrYxzWyI67JtFgJYETBrtkJV4F26x5VZossWrNY/
         Ud9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZW+nJZUKu/kn9rdzsMf6SUVZ0gHS5SbX8xZHN4zvR8c=;
        b=TfY6X40/jGpb1eSqCcqkePZdFLOV+jvEWKGHnzmRxEpQeuhJgjvcy+1Wh8xXhSYK9U
         vHMsipLkqECMyQMKJ93wIckeGs8La5Yfyk27Cpg+gIe/0bIdM5xeuS4pNRrubZMLm1dq
         Jhvrt0NsL7aNOpu23Q38c7HEoBhUiZV9BCjuFX+3VWXaRmTkcx1Z0nZCQgVRT9VA5+c6
         KP69e1Mv9p/EjcBQCYemuMRMGIOLUTYm/j/kuerGzrY9U8uBMZZVlSV48JKjjwtrqKcO
         bVl9k5LO+9vif/UMfboeHQWWlYsEys1ANqAOhXrLpFBHP0EeIR0ghLBs35l0Q+AN1QQP
         HkYQ==
X-Gm-Message-State: APjAAAViTdzsOjqGAwkFfiDpZOZrBQHv7NVaLqN088c+rhnTqtYHIQsu
        O7OatBuS3P/cy0LLbXeYqn7bj6G3
X-Google-Smtp-Source: APXvYqy7ExCRLra07aglWVpJGv68GOEfcumataH4pqdBhjD9u5NtyewjxSApfEDX/DlDj/iu9h71Xg==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr11858028wmi.62.1552147948679;
        Sat, 09 Mar 2019 08:12:28 -0800 (PST)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id u14sm3017222wrr.42.2019.03.09.08.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 08:12:27 -0800 (PST)
Date:   Sat, 9 Mar 2019 16:12:26 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     sushmaunnibhavi <sushmaunnibhavi425@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC][PATCH 1/2] modified dir-iterator.c
Message-ID: <20190309161226.GA31533@hank.intra.tgummerer.com>
References: <20190308140307.GA22661@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308140307.GA22661@hacker-queen>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thanks for the patch!

Subject: [GSOC][PATCH 1/2] modified dir-iterator.c

Commit messages should be written in the imperative mood, e.g. "modify
dir-iterator.c", see also "Documentation/SubmittingPatches.  Also they
are generally in the format "<area>: <description>".  So the subject
here could be something like "dir-iterator: replace closedir with
cast".  Note that the description briefly describes what the patch
does, in more detail than just "modify".  Every patch modifies
something, so that word by itself is somewhat meaningless.

Also you are using 1/2 in the subject, but I can't find a second patch
on the mailing list.  Did you forget to send that?

On 03/08, sushmaunnibhavi wrote:
> ---
> Some places in git use raw API opendir/readdir/closedir to traverse a directory recursively, which usually involves function recursion. Now that we have struct dir_iterator,we have to convert these to use the dir-iterator to simplify the code.

This is a plain copy from the microprojects page, but doesn't explain
what this change is about.  The commit message should explain why a
certain change is made, so reviewers can easily understand why the
patch would be worth including.

Note that this explaination should also be part of the commit message
(before the --- marker above), so it is included in the project
history.  The space after the --- marker can be useful for giving
additional information to reviewers, that should not be included in
the projects commit history.

> Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>

The Signed-off-by: line should be part of the commit message (before
the ---).  Also it should match the author name used in the commit.
Right now you are using two different names.  We generally prefer real
names over nicknames, so the author of the commit should be updated to
be "Sushma Unnibhavi".

>  dir-iterator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index f2dcd82fde..a3b5b8929c 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -169,7 +169,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  		struct dir_iterator_level *level =
>  			&iter->levels[iter->levels_nr - 1];
>  
> -		if (level->dir && closedir(level->dir)) {
> +		if (level->dir && (struct dir_iterator_int *)(level->dir)) {//changed closedir to (struct dir_iterator_int *)

The 'closedir' call is changed to a cast here, which will always
evaluate to true as long as level->dir is not a NULL pointer, which we
already check in the first condition.

After this change we no longer close the directory in
'dir_iterator_abort', which we should still do.  Also the warning
message below is now no longer correct, if this would be the change
that is really desired.

The comment that's added here tells us what has been done in this
particular commit, but is not very useful in the longer term (someone
reading this line tomorrow or in a year would not care that this has
been changed in some previous commit).  The actual change is already
easily understandable from the diff, so the comment adds no additional
benefit.  If it would add some benefit to the reader, it would be
better to describe that in the commit message rather than in a
comment.

Additionally we don't use C++ style comments in this project, but
rather prefer C style comments using /* */ to wrap it.

>  			strbuf_setlen(&iter->base.path, level->prefix_len);
>  			warning("error closing directory %s: %s",
>  				iter->base.path.buf, strerror(errno));
> -- 
> 2.17.1
> 
