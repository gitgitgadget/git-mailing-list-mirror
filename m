Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC47201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdEQN7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:59:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64128 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753103AbdEQN7h (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 09:59:37 -0400
X-AuditID: 1207440c-9d9ff70000001412-09-591c574818ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DB.91.05138.8475C195; Wed, 17 May 2017 09:59:36 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HDxW3U006376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 09:59:34 -0400
Subject: Re: [PATCH v3 10/12] files-backend: make reflog iterator go through
 per-worktree reflog
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-11-pclouds@gmail.com>
 <d3428e5e-9ac2-0426-31fd-92d29a414b3d@alum.mit.edu>
 <20170423044420.GA28419@ash>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <00720e90-ed85-e8d8-a2e4-f42f93a33d33@alum.mit.edu>
Date:   Wed, 17 May 2017 15:59:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170423044420.GA28419@ash>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqOsRLhNpsO2IqkXXlW4mi4beK8wW
        /cu72Cy6p7xltJh51dpi8+Z2Fgc2j52z7rJ7fPgY57FgU6nHxUvKHvuXbmPz+LxJLoAtissm
        JTUnsyy1SN8ugSvj1sqTjAV3nSsunPnI2MB42KyLkZNDQsBE4s3GP+xdjFwcQgI7mCQmdt9m
        gnDOATnXXrOBVAkLJEk8urWNHcQWEVCSeNOxjRmiaDujxOHvy8EcZoEbjBLtd2cwgVSxCehK
        LOppBrN5Bewl/j8/zdjFyMHBIqAqsXm/O0hYVCBC4mHnLnaIEkGJkzOfsIDYnAKaErv+LmAF
        sZkF9CR2XP8FZctLbH87h3kCI/8sJC2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5e
        apGuoV5uZoleakrpJkZIaPPsYPy2TuYQowAHoxIPb0SATKQQa2JZcWXuIUZJDiYlUd79D6Qj
        hfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwNoYClfOmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5ak
        ZqemFqQWwWRlODiUJHjtw4AaBYtS01Mr0jJzShDSTBycIMN5gIbbgdTwFhck5hZnpkPkTzHq
        chx6/vM9kxBLXn5eqpQ4rxrIBQIgRRmleXBzYCnpFaM40FvCvK0go3iA6Qxu0iugJUxAS5pB
        vuMtLklESEk1MM4NWjttafvvv1enh264sbhsVSZ3h/hdhu0tt/v8RD1tMlczG/PcN2goXi+X
        fUGC/611TvJUt09vt4RaXlKMSNi4ad6sU7/Tzmw/wCI0Wzdqd6bFedWtptc4KibW+XDsUL4b
        qThbveqvl82WJzuX37eVtn62eX6e7eOzGYfn7DQI+bPCXdvymr4SS3FGoqEWc1FxIgBumgpO
        JAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I put off reviewing this patch, thinking that it would appear in a
re-roll, then never came back to it. :-(

On 04/23/2017 06:44 AM, Duy Nguyen wrote:
> On Sat, Apr 22, 2017 at 10:05:02AM +0200, Michael Haggerty wrote:
>> I find this implementation confusing:
>>
>> * `if (iter->worktree_dir_iterator)` sounds like it should mean
>>   that we are iterating over worktree references but it really means
>>   that we are iterating over the common references in a repository
>>   that is a linked worktree.
>> * `files_reflog_iterator_advance()` is called recursively, but only
>>   for the first worktree reference.
>> * `iter->worktree_dir_iterator` is moved over to `iter->dir_iterator`
>>   when the common refs are exhausted.
>>
>> Do you find it more readable as follows?:
> 
> It's a bit better, but while we're at it, why not take full advantage
> of iterator abstraction?
> 
> This replacement patch (with some unrelated bits removed to reduce
> distraction) adds a new meta ref-iterator that combine a per-repo and
> a per-worktree iterators together. The new iterator walks through both
> sub-iterators and drop the per-worktree results from the per-repo
> iterator, which will be replaced with results from per-worktree
> iterator.
> 
> You probably see where I'm going with this. When the new "linked
> worktree ref store" comes, it will combine two per-worktree and
> per-repo ref stores together and this iterator will come handy.
> 
> At that point, files-backend can go back to being oblivious about
> $GIT_DIR vs $GIT_COMMON_DIR and files_reflog_iterator_begin() will be
> reverted back to the version before this patch.

Yes, that's even better.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4149943a6e..817b7b5d5e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3432,23 +3423,37 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
>  	files_reflog_iterator_abort
>  };
>  
> -static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
> +static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
> +						  const char *gitdir)
>  {
> -	struct files_ref_store *refs =
> -		files_downcast(ref_store, REF_STORE_READ,
> -			       "reflog_iterator_begin");
>  	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
>  	struct ref_iterator *ref_iterator = &iter->base;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
> -	files_reflog_path(refs, &sb, NULL);
> +	strbuf_addf(&sb, "%s/logs", gitdir);
>  	iter->dir_iterator = dir_iterator_begin(sb.buf);
>  	iter->ref_store = ref_store;
>  	strbuf_release(&sb);
> +
>  	return ref_iterator;
>  }

Makes sense.

> +static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
> +{
> +	struct files_ref_store *refs =
> +		files_downcast(ref_store, REF_STORE_READ,
> +			       "reflog_iterator_begin");
> +
> +	if (!strcmp(refs->gitdir, refs->gitcommondir)) {
> +		return reflog_iterator_begin(ref_store, refs->gitcommondir);
> +	} else {
> +		return worktree_ref_iterator_begin(
> +			reflog_iterator_begin(ref_store, refs->gitcommondir),
> +			reflog_iterator_begin(ref_store, refs->gitdir));
> +	}
> +}
> +

Yes.

>  static int ref_update_reject_duplicates(struct string_list *refnames,
>  					struct strbuf *err)
>  {
> diff --git a/refs/iterator.c b/refs/iterator.c
> index bce1f192f7..93243a00c4 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -40,6 +40,14 @@ void base_ref_iterator_free(struct ref_iterator *iter)
>  	free(iter);
>  }
>  
> +static void ref_iterator_copy_result(struct ref_iterator *dst,
> +				     const struct ref_iterator *src)
> +{
> +	dst->refname = src->refname;
> +	dst->oid = src->oid;
> +	dst->flags = src->flags;
> +}
> +
>  struct empty_ref_iterator {
>  	struct ref_iterator base;
>  };
> @@ -382,3 +390,100 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
>  		return -1;
>  	return retval;
>  }
> +
> +struct worktree_ref_iterator {
> +	struct ref_iterator base;
> +	struct ref_iterator *per_repo_iterator;
> +	struct ref_iterator *per_worktree_iterator;
> +};
> +
> +static int worktree_ref_iterator_advance(struct ref_iterator *ref_iterator)
> +{
> +	struct worktree_ref_iterator *iter =
> +		(struct worktree_ref_iterator *)ref_iterator;
> +	int ok;
> +
> +	while (1) {
> +		struct ref_iterator **subiter;
> +		int normal_only;
> +
> +		if (iter->per_repo_iterator) {
> +			subiter = &iter->per_repo_iterator;
> +			/*
> +			 * If we are in a worktree, then we only
> +			 * include "normal" common references:
> +			 */
> +			normal_only = !!iter->per_worktree_iterator;
> +		} else if (iter->per_worktree_iterator) {
> +			subiter = &iter->per_worktree_iterator;
> +			normal_only = 0;
> +		} else {
> +			ok = ITER_DONE;
> +			break;
> +		}
> +
> +		ok = ref_iterator_advance(*subiter);
> +		if (ok == ITER_ERROR) {
> +			*subiter = NULL;
> +			break;
> +		} else if (ok == ITER_DONE) {
> +			*subiter = NULL;
> +			/* There might still be worktree refs left: */
> +			continue;
> +		}
> +
> +		if (normal_only &&
> +		    ref_type((*subiter)->refname) != REF_TYPE_NORMAL)
> +			continue;
> +
> +		ref_iterator_copy_result(&iter->base, *subiter);
> +		return ITER_OK;
> +	}
> +
> +	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
> +		return ITER_ERROR;
> +
> +	return ok;
> +}
> +
> +static int worktree_ref_iterator_peel(struct ref_iterator *ref_iterator,
> +					 struct object_id *peeled)
> +{
> +	die("BUG: ref_iterator_peel() called for reflog_iterator");
> +}
> +
> +static int worktree_ref_iterator_abort(struct ref_iterator *ref_iterator)
> +{
> +	struct worktree_ref_iterator *iter =
> +		(struct worktree_ref_iterator *)ref_iterator;
> +	int ok = ITER_DONE;
> +
> +	if (iter->per_repo_iterator)
> +		ok = ref_iterator_abort(iter->per_repo_iterator);
> +
> +	if (iter->per_worktree_iterator) {
> +		int ok2 = ref_iterator_abort(iter->per_worktree_iterator);
> +		if (ok2 == ITER_ERROR)
> +			ok = ok2;
> +	}
> +
> +	base_ref_iterator_free(ref_iterator);
> +	return ok;
> +}
> +
> +static struct ref_iterator_vtable worktree_ref_iterator_vtable = {
> +	worktree_ref_iterator_advance,
> +	worktree_ref_iterator_peel,
> +	worktree_ref_iterator_abort
> +};
> +
> +struct ref_iterator *worktree_ref_iterator_begin(struct ref_iterator *per_repo,
> +						 struct ref_iterator *per_worktree)
> +{
> +	struct worktree_ref_iterator *iter = xcalloc(1, sizeof(*iter));
> +
> +	base_ref_iterator_init(&iter->base, &worktree_ref_iterator_vtable);
> +	iter->per_repo_iterator = per_repo;
> +	iter->per_worktree_iterator = per_worktree;
> +	return &iter->base;
> +}
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 690498698e..dcb1f1d73d 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -387,6 +387,14 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
>  					       const char *prefix,
>  					       int trim);
>  
> +/*
> + * Wrap per_repo and per_worktree iterators. Traverse per_repo
> + * iterator, drop per-worktree refs. Then traverse per_worktree
> + * iterator.
> + */
> +struct ref_iterator *worktree_ref_iterator_begin(struct ref_iterator *per_repo,
> +						 struct ref_iterator *per_worktree);
> +
>  /* Internal implementation of reference iteration: */
>  
>  /*
> 
> 

I think `worktree_ref_iterator_begin()` could be implemented with a lot
less code via a `merge_ref_iterator`. You would need to define a
`ref_iterator_select_fn`, which could look like something like this:

enum iterator_selection worktree_iterator_select_fn(
		struct ref_iterator *iter0, struct ref_iterator *iter1,
		void *cb_data)
{
	if (iter0) {
		if (ref_type(iter0->refname) != REF_TYPE_NORMAL)
			return ITER_SKIP_0;
		return ITER_SELECT_0;
	} else if (iter1) {
		return ITER_SELECT_1;
	} else {
		return ITER_SELECT_DONE;
	}
}

Then `worktree_ref_iterator_begin()` is simply

struct ref_iterator *worktree_ref_iterator_begin(struct ref_iterator
*per_repo,
						 struct ref_iterator *per_worktree)
{
	return merge_ref_iterator_begin(per_repo, per_worktree,
					worktree_iterator_select_fn, NULL);
}

For references (as opposed to reflogs) you would want to interleave the
outputs from the two input iterators in the correct order. See
`overlay_iterator_select()` for how that can be done.

Michael

