Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99ED207BD
	for <e@80x24.org>; Sat, 22 Apr 2017 08:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1042519AbdDVIFO (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 04:05:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45677 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1041270AbdDVIFJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Apr 2017 04:05:09 -0400
X-AuditID: 12074413-0e1ff70000001dc3-9c-58fb0eb3378e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B4.88.07619.3BE0BF85; Sat, 22 Apr 2017 04:05:08 -0400 (EDT)
Received: from [192.168.69.190] (p57907D7C.dip0.t-ipconnect.de [87.144.125.124])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3M852Yn004731
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 22 Apr 2017 04:05:04 -0400
Subject: Re: [PATCH v3 10/12] files-backend: make reflog iterator go through
 per-worktree reflog
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-11-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d3428e5e-9ac2-0426-31fd-92d29a414b3d@alum.mit.edu>
Date:   Sat, 22 Apr 2017 10:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-11-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1N3C9zvCYOsJTouuK91MFg29V5gt
        +pd3sVl0T3nLaDHzqrXF5s3tLA5sHjtn3WX3+PAxzmPBplKPi5eUPfYv3cbm8XmTXABbFJdN
        SmpOZllqkb5dAlfG1MVX2ApuqlfcfvOBrYHxh1wXIyeHhICJxOH+pcxdjFwcQgI7mCSmnHvC
        AuFcYJKY2nyfFaRKWCBJ4tGtbewgtohAmsTiye+ZQWwhoPjiiWcYQRqYBXYxSpx5fgcswSag
        K7Gop5kJxOYVsJf4+WYhUBEHB4uAqsSl93kgYVGBEIk5Cx8wQpQISpycCbKYk4NTwFxi0tY+
        NhCbWUBd4s+8S8wQtrxE89bZzBMY+WchaZmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT
        8/JSi3TN9XIzS/RSU0o3MUICW3gH466TcocYBTgYlXh4V7D8ihBiTSwrrsw9xCjJwaQkyhvy
        +2eEEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeSf+AynlTEiurUovyYVLSHCxK4rxqS9T9hATS
        E0tSs1NTC1KLYLIyHBxKErybeH9HCAkWpaanVqRl5pQgpJk4OEGG8wANTwWp4S0uSMwtzkyH
        yJ9iVJQS5w0FSQiAJDJK8+B6YYnnFaM40CvCvO0gVTzApAXX/QpoMBPQ4LN+P0AGlyQipKQa
        GBkzXzwI8y5OtX5mFBLytWqzxgaxf9sfrWUKufqVQ/hvsZT/Qs8nHzye7Ug6x88x76ky7+9r
        56NvnT3/7KBZD1+lQ5fumtvPPPXTe9J1fDUn7V6/TT7+iNg+k4brjAaTky4H737B+lpr5pOd
        5S7Ohz1OTPJbVsl/tUz7X5b71qBD6Y18ar9ra5RYijMSDbWYi4oTAeTSScwXAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/19/2017 01:01 PM, Nguyễn Thái Ngọc Duy wrote:
> refs/bisect is unfortunately per-worktree, so we need to look in
> per-worktree logs/refs/bisect in addition to per-repo logs/refs. The
> current iterator only goes through per-repo logs/refs.
> 
> Ideally we should have something like merge_ref_iterator_begin (and
> maybe with a predicate), but for dir_iterator. Since there's only one
> use case for this pattern, let's not add a bunch more code for
> merge_dir_iterator_begin just yet.
> 
> PS. Note the unsorted order of for_each_reflog in the test. This is
> supposed to be OK, for now. If we enforce order on for_each_reflog()
> then some more work will be required.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c          | 46 ++++++++++++++++++++++++++++++++-----------
>  t/t1407-worktree-ref-store.sh | 30 ++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4149943a6e..fce380679c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1171,15 +1171,6 @@ static void files_reflog_path(struct files_ref_store *refs,
>  			      struct strbuf *sb,
>  			      const char *refname)
>  {
> -	if (!refname) {
> -		/*
> -		 * FIXME: of course this is wrong in multi worktree
> -		 * setting. To be fixed real soon.
> -		 */
> -		strbuf_addf(sb, "%s/logs", refs->gitcommondir);
> -		return;
> -	}
> -
>  	switch (ref_type(refname)) {
>  	case REF_TYPE_PER_WORKTREE:
>  	case REF_TYPE_PSEUDOREF:
> @@ -3368,6 +3359,7 @@ struct files_reflog_iterator {
>  
>  	struct ref_store *ref_store;
>  	struct dir_iterator *dir_iterator;
> +	struct dir_iterator *worktree_dir_iterator;
>  	struct object_id oid;
>  };
>  
> @@ -3388,6 +3380,21 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
>  		if (ends_with(diter->basename, ".lock"))
>  			continue;
>  
> +		if (iter->worktree_dir_iterator) {
> +			const char *refname = diter->relative_path;
> +
> +			switch (ref_type(refname)) {
> +			case REF_TYPE_PER_WORKTREE:
> +			case REF_TYPE_PSEUDOREF:
> +				continue;
> +			case REF_TYPE_NORMAL:
> +				break;
> +			default:
> +				die("BUG: unknown ref type %d of ref %s",
> +				    ref_type(refname), refname);
> +			}
> +		}
> +
>  		if (refs_read_ref_full(iter->ref_store,
>  				       diter->relative_path, 0,
>  				       iter->oid.hash, &flags)) {
> @@ -3401,7 +3408,11 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
>  		return ITER_OK;
>  	}
>  
> -	iter->dir_iterator = NULL;
> +	iter->dir_iterator = iter->worktree_dir_iterator;
> +	if (iter->worktree_dir_iterator) {
> +		iter->worktree_dir_iterator = NULL;
> +		return files_reflog_iterator_advance(ref_iterator);
> +	}

I find this implementation confusing:

* `if (iter->worktree_dir_iterator)` sounds like it should mean
  that we are iterating over worktree references but it really means
  that we are iterating over the common references in a repository
  that is a linked worktree.
* `files_reflog_iterator_advance()` is called recursively, but only
  for the first worktree reference.
* `iter->worktree_dir_iterator` is moved over to `iter->dir_iterator`
  when the common refs are exhausted.

Do you find it more readable as follows?:

static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
{
	struct files_reflog_iterator *iter =
		(struct files_reflog_iterator *)ref_iterator;
	int ok;

	while (1) {
		struct dir_iterator **diter;
		int normal_only, flags;

		if (iter->dir_iterator) {
			diter = &iter->dir_iterator;
			/*
			 * If we are in a worktree, then we only
			 * include "normal" common references:
			 */
			normal_only = !!iter->worktree_dir_iterator;
		} else if (iter->worktree_dir_iterator) {
			diter = &iter->worktree_dir_iterator;
			normal_only = 0;
		} else {
			ok = ITER_DONE;
			break;
		}

		ok = dir_iterator_advance(*diter);
		if (ok == ITER_ERROR) {
			*diter = NULL;
			break;
		} else if (ok == ITER_DONE) {
			*diter = NULL;
			/* There might still be worktree refs left: */
			continue;
		}

		if (!S_ISREG((*diter)->st.st_mode))
			continue;
		if ((*diter)->basename[0] == '.')
			continue;
		if (ends_with((*diter)->basename, ".lock"))
			continue;

		iter->base.refname = (*diter)->relative_path;

		if (normal_only &&
		    ref_type(iter->base.refname) != REF_TYPE_NORMAL)
			continue;

		if (refs_read_ref_full(iter->ref_store,
				       iter->base.refname, 0,
				       iter->oid.hash, &flags)) {
			error("bad ref for %s", (*diter)->path.buf);
			continue;
		}

		iter->base.oid = &iter->oid;
		iter->base.flags = flags;
		return ITER_OK;
	}

	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
		return ITER_ERROR;

	return ok;
}

>  	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
>  		ok = ITER_ERROR;
>  	return ok;
> [...]

Michael

