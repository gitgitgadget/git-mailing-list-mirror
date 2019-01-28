Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7763C1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 08:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfA1IBW (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 03:01:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:44737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfA1IBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 03:01:22 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh9cj-1gb9o43qq1-00MN6X; Mon, 28
 Jan 2019 09:01:18 +0100
Date:   Mon, 28 Jan 2019 09:01:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Xenos <sxenos@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/8] evolve: Add the change-table structure
In-Reply-To: <20190127194415.171035-5-sxenos@google.com>
Message-ID: <nycvar.QRO.7.76.6.1901280858060.41@tvgsbejvaqbjf.bet>
References: <20190127194415.171035-1-sxenos@google.com> <20190127194415.171035-5-sxenos@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yz4xHfQrQ+i+vE74HCfkb61yUfxr7tq/GZfcPgNkhg0nMl4E7QA
 cepkuHJy4vZo/e+AvoWSwZzgedpuGZF+nwXBgMAP83GiXvCNebTmsTHEZokzmOZxxgkrugA
 wCH4y/GydQdvnKoABPwzYdgFUDnjDq/HuXei1cQsMqbi2InLvj34ds50cDz/kqY8cyZfh1D
 XTbfEr0jZ2cLlKYUUeexQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ON1xWluvzck=:mAnpv5yDpXH92r+DfWfyu6
 K6LYsEDKsEtwnNSJAFiymLq3E7vkkEJGFgTsEXoH2iVBLgWsYGcoD2XY+BRWe3DzC3a+EGBpo
 kty5pfVRm1XAeI6CJ+0nIjU0Yz45vpqqNslVkk0FPAZvXDJVL8rORLhuiGpIxCvMBVOkK/JHs
 91MQOGBtd85UWQARDxfn5/x0JCVshYjnRtUsErc6XZIP6U7YaurSfP7gH38U1wIEwgmu6CEMq
 eeyQmCFJ9Dq2u+S4OHQtAoYFV+xraaa3wYkVuvfYCmt7Anh3i6ZCAQPii9137pS0uau8z1bTK
 3KwZrSRsisgw4zQxXCIWcviINmX3B+7JzwPYz0Mzno7qIebn09qCvs579sIB1Dg3pHcx3jgZa
 CGRdq9BKqcHAvmf98kB6b11QJDsgngGNy3g5IboVOaJ21uq++2CYjt0DkoyPoqkOAWxsrxwXW
 OoLb116AleJGas7zCHWPmxKrpflKdzap51h60eDy1ZihLr7sv5VLa1g+iN1xxm+ff7A7QFW+o
 oJH1wHDFZYo7hekGL3Cs6Md/iCu2rxjQiAPSO7w401AyglAcbkrSV9Ouw/ttZkLfyxivjx94v
 2kO4c5ptYOTngotkIw90vFQYCWvajlWT8SDRhEQkXxLD04/taqND021mfY9t1Dd5zaMUCUSvg
 bzl3yEbMsN630zHwTlUstT6FRjEn5dKYsojKHywfSg7FZQGvSzxALpYdvnp4Q/drYktkDnmfd
 0AErHaYsvsUUu7V2n+jrdVTqRQTgajnj72RemfNsQer9IOU1DqF9AETJlmjY/B5/kz+bF7YsZ
 oDI665XDJW5nZhN1idKS4n3lpypyxVR36A2fzDkwmLC72O+iu7blpTvCsvd6VysyA5wlsqwEz
 sp23TD2QG93usr7mz0LRr5iyzJrPGBEoRMZDAlKSQOd2qY6Yx2FG8nGDQJWg7o770XE7nkQJm
 ygA9H/1yRVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

I did not yet have time to study your proposal in detail, but hope to do
so before the Contributor Summit so that I can have an informed opinion.

Just one thing:

On Sun, 27 Jan 2019, sxenos@google.com wrote:

> From: Stefan Xenos <sxenos@google.com>
> 
> A change table stores a list of changes, and supports efficient lookup
> from a commit hash to the list of changes that reference that commit
> directly.
> 
> It can be used to look up content commits or metacommits at the head
> of a change, but does not support lookup of commits referenced as part
> of the commit history.
> 
> Signed-off-by: Stefan Xenos <sxenos@google.com>
> ---
>  Makefile       |   1 +
>  change-table.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++
>  change-table.h | 138 +++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 change-table.c
>  create mode 100644 change-table.h
> 
> diff --git a/Makefile b/Makefile
> index 7ffc383f2b..09cfd3ef1b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -844,6 +844,7 @@ LIB_OBJS += branch.o
>  LIB_OBJS += bulk-checkin.o
>  LIB_OBJS += bundle.o
>  LIB_OBJS += cache-tree.o
> +LIB_OBJS += change-table.o
>  LIB_OBJS += chdir-notify.o
>  LIB_OBJS += checkout.o
>  LIB_OBJS += color.o
> diff --git a/change-table.c b/change-table.c
> new file mode 100644
> index 0000000000..6daff5f58c
> --- /dev/null
> +++ b/change-table.c
> @@ -0,0 +1,207 @@
> +#include "cache.h"
> +#include "change-table.h"
> +#include "commit.h"
> +#include "ref-filter.h"
> +#include "metacommit-parser.h"
> +
> +void change_table_init(struct change_table *to_initialize)
> +{
> +	memset(to_initialize, 0, sizeof(*to_initialize));
> +	mem_pool_init(&(to_initialize->memory_pool), 0);
> +	to_initialize->memory_pool->block_alloc = 4*1024 - sizeof(struct mp_block);
> +	oidmap_init(&(to_initialize->oid_to_metadata_index), 0);
> +	string_list_init(&(to_initialize->refname_to_change_head), 1);
> +}
> +
> +static void change_list_clear(struct change_list *to_clear) {
> +	string_list_clear(&to_clear->additional_refnames, 0);
> +}
> +
> +static void commit_change_list_entry_clear(
> +	struct commit_change_list_entry *to_clear) {
> +	change_list_clear(&(to_clear->changes));
> +}
> +
> +static void change_head_array_clear(struct change_head_array *to_clear)
> +{
> +	FREE_AND_NULL(to_clear->array);
> +}
> +
> +void change_table_clear(struct change_table *to_clear)
> +{
> +	struct oidmap_iter iter;
> +	struct commit_change_list_entry *next;
> +	for (next = oidmap_iter_first(&to_clear->oid_to_metadata_index, &iter);
> +		next;
> +		next = oidmap_iter_next(&iter)) {
> +
> +		commit_change_list_entry_clear(next);
> +	}
> +
> +	oidmap_free(&to_clear->oid_to_metadata_index, 0);
> +	string_list_clear(&(to_clear->refname_to_change_head), 0);
> +	change_head_array_clear(&to_clear->heads);
> +	mem_pool_discard(to_clear->memory_pool, 0);
> +}
> +
> +/*
> + * Appends a new, empty, change_head struct to the end of the given array.
> + * Returns the index of the newly-added struct.
> + */
> +static int change_head_array_append(struct change_head_array *to_add)
> +{
> +	int index = to_add->nr++;
> +	struct change_head *new_head;
> +	ALLOC_GROW(to_add->array, to_add->nr, to_add->alloc);
> +	new_head = &(to_add->array[index]);
> +	memset(new_head, 0, sizeof(*new_head));
> +	return index;
> +}
> +
> +static void add_head_to_commit(struct change_table *to_modify,
> +	const struct object_id *to_add, const char *refname)
> +{
> +	struct commit_change_list_entry *entry;
> +
> +	// Note: the indices in the map are 1-based. 0 is used to indicate a missing
> +	// element.
> +	entry = oidmap_get(&(to_modify->oid_to_metadata_index), to_add);
> +	if (!entry) {
> +		entry = mem_pool_calloc(to_modify->memory_pool, 1,
> +			sizeof(*entry));
> +		oidcpy(&entry->entry.oid, to_add);
> +		oidmap_put(&(to_modify->oid_to_metadata_index), entry);
> +		string_list_init(&(entry->changes.additional_refnames), 0);
> +	}
> +
> +	if (entry->changes.first_refname == NULL) {
> +		entry->changes.first_refname = refname;
> +	} else {
> +		string_list_insert(&entry->changes.additional_refnames, refname);
> +	}
> +}
> +
> +void change_table_add(struct change_table *to_modify, const char *refname,
> +	struct commit *to_add)
> +{
> +	struct change_head *new_head;
> +	struct string_list_item *new_item;
> +	long index;
> +	int metacommit_type;
> +
> +	index = change_head_array_append(&to_modify->heads);
> +	new_head = &(to_modify->heads.array[index]);
> +
> +	oidcpy(&new_head->head, &(to_add->object.oid));
> +
> +	metacommit_type = get_metacommit_content(to_add, &new_head->content);
> +	if (metacommit_type == METACOMMIT_TYPE_NONE) {
> +		oidcpy(&new_head->content, &(to_add->object.oid));
> +	}
> +	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
> +	new_head->remote = starts_with(refname, "refs/remote/");
> +	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
> +
> +	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
> +	new_item->util = (void*)index;

This is not good. You are using a `long` here. The 80s called and want
their now-obsolete data types back.

If you want a data type that can take an integer but also a pointer, use
`intptr_t` instead.

But even that is not good practice. What you really want here is to use a
union of the data types that you want to store in that `util` field.

This is not merely academic, your code causes compile errors on Windows:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=400&view=logs&jobId=fd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=ce91d5d6-0c55-50f5-8ab9-6695c03ab102&lineStart=430&lineEnd=440&colStart=1&colEnd=1

Ciao,
Johannes

> +	// Use pointers to the copy of the string we're retaining locally
> +	refname = new_item->string;
> +
> +	if (!oideq(&new_head->content, &new_head->head)) {
> +		add_head_to_commit(to_modify, &(new_head->content), refname);
> +	}
> +	add_head_to_commit(to_modify, &(new_head->head), refname);
> +}
> +
> +void change_table_add_all_visible(struct change_table *to_modify,
> +	struct repository* repo)
> +{
> +	struct ref_filter filter;
> +	const char *name_patterns[] = {NULL};
> +	memset(&filter, 0, sizeof(filter));
> +	filter.kind = FILTER_REFS_CHANGES;
> +	filter.name_patterns = name_patterns;
> +
> +	change_table_add_matching_filter(to_modify, repo, &filter);
> +}
> +
> +void change_table_add_matching_filter(struct change_table *to_modify,
> +	struct repository* repo, struct ref_filter *filter)
> +{
> +	struct ref_array matching_refs;
> +	int i;
> +
> +	memset(&matching_refs, 0, sizeof(matching_refs));
> +	filter_refs(&matching_refs, filter, filter->kind);
> +
> +	// Determine the object id for the latest content commit for each change.
> +	// Fetch the commit at the head of each change ref. If it's a normal commit,
> +	// that's the commit we want. If it's a metacommit, locate its content parent
> +	// and use that.
> +
> +	for (i = 0; i < matching_refs.nr; i++) {
> +		struct ref_array_item *item = matching_refs.items[i];
> +		struct commit *commit = item->commit;
> +
> +		commit = lookup_commit_reference_gently(repo, &(item->objectname), 1);
> +
> +		if (commit != NULL) {
> +			change_table_add(to_modify, item->refname, commit);
> +		}
> +	}
> +
> +	ref_array_clear(&matching_refs);
> +}
> +
> +static int return_true_callback(const char *refname, void *cb_data)
> +{
> +	return 1;
> +}
> +
> +int change_table_has_change_referencing(struct change_table *changes,
> +	const struct object_id *referenced_commit_id)
> +{
> +	return for_each_change_referencing(changes, referenced_commit_id,
> +		return_true_callback, NULL);
> +}
> +
> +int for_each_change_referencing(struct change_table *table,
> +	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
> +{
> +	const struct change_list *changes;
> +	int i;
> +	int retvalue;
> +	struct commit_change_list_entry *entry;
> +
> +	entry = oidmap_get(&table->oid_to_metadata_index,
> +		referenced_commit_id);
> +	// If this commit isn't referenced by any changes, it won't be in the map
> +	if (!entry) {
> +		return 0;
> +	}
> +	changes = &(entry->changes);
> +	if (changes->first_refname == NULL) {
> +		return 0;
> +	}
> +	retvalue = fn(changes->first_refname, cb_data);
> +	for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++) {
> +		retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
> +	}
> +	return retvalue;
> +}
> +
> +struct change_head* get_change_head(struct change_table *heads,
> +	const char* refname)
> +{
> +	struct string_list_item *item = string_list_lookup(
> +		&heads->refname_to_change_head, refname);
> +	long index;
> +
> +	if (!item) {
> +		return NULL;
> +	}
> +
> +	index = (long)item->util;
> +	return &(heads->heads.array[index]);
> +}
> +
> diff --git a/change-table.h b/change-table.h
> new file mode 100644
> index 0000000000..85bb19c3bf
> --- /dev/null
> +++ b/change-table.h
> @@ -0,0 +1,138 @@
> +#ifndef CHANGE_TABLE_H
> +#define CHANGE_TABLE_H
> +
> +#include "oidmap.h"
> +
> +struct commit;
> +struct ref_filter;
> +
> +/*
> + * This struct holds a list of change refs. The first element is stored inline,
> + * to optimize for small lists.
> + */
> +struct change_list {
> +	/* Ref name for the first change in the list, or null if none.
> +	 *
> +	 * This field is private. Use for_each_change_in to read.
> +	 */
> +	const char* first_refname;
> +	/* List of additional change refs. Note that this is empty if the list
> +	 * contains 0 or 1 elements.
> +	 *
> +	 * This field is private. Use for_each_change_in to read.
> +	 */
> +	struct string_list additional_refnames;
> +};
> +
> +/*
> + * Holds information about the head of a single change.
> + */
> +struct change_head {
> +	/*
> +	 * The location pointed to by the head of the change. May be a commit or a
> +	 * metacommit.
> +	 */
> +	struct object_id head;
> +	/*
> +	 * The content commit for the latest commit in the change. Always points to a
> +	 * real commit, never a metacommit.
> +	 */
> +	struct object_id content;
> +	/*
> +	 * Abandoned: indicates that the content commit should be removed from the
> +	 * history.
> +	 *
> +	 * Hidden: indicates that the change is an inactive change from the
> +	 * hiddenmetas namespace. Such changes will be hidden from the user by
> +	 * default.
> +	 *
> +	 * Deleted: indicates that the change has been removed from the repository.
> +	 * That is the ref was deleted since the time this struct was created. Such
> +	 * entries should be ignored.
> +	 */
> +	int abandoned:1,
> +		hidden:1,
> +		remote:1,
> +		deleted:1;
> +};
> +
> +/*
> + * An array of change_head.
> + */
> +struct change_head_array {
> +	struct change_head* array;
> +	int nr;
> +	int alloc;
> +};
> +
> +/*
> + * Holds the list of change refs whose content points to a particular content
> + * commit.
> + */
> +struct commit_change_list_entry {
> +	struct oidmap_entry entry;
> +	struct change_list changes;
> +};
> +
> +/*
> + * Holds information about the heads of each change, and permits effecient
> + * lookup from a commit to the changes that reference it directly.
> + *
> + * All fields should be considered private. Use the change_table functions
> + * to interact with this struct.
> + */
> +struct change_table {
> +	/**
> +	 * Memory pool for the objects allocated by the change table.
> +	 */
> +	struct mem_pool *memory_pool;
> +	/* Map object_id to commit_change_list_entry structs. */
> +	struct oidmap oid_to_metadata_index;
> +	/* List of ref names. The util value is an int index into change_metadata
> +	 * array.
> +	 */
> +	struct string_list refname_to_change_head;
> +	/* change_head structures for each head */
> +	struct change_head_array heads;
> +};
> +
> +extern void change_table_init(struct change_table *to_initialize);
> +extern void change_table_clear(struct change_table *to_clear);
> +
> +/* Adds the given change head to the change_table struct */
> +extern void change_table_add(struct change_table *to_modify,
> +	const char *refname, struct commit *target);
> +
> +/* Adds the non-hidden local changes to the given change_table struct.
> + */
> +extern void change_table_add_all_visible(struct change_table *to_modify,
> +	struct repository *repo);
> +
> +/*
> + * Adds all changes matching the given ref filter to the given change_table
> + * struct.
> + */
> +extern void change_table_add_matching_filter(struct change_table *to_modify,
> +	struct repository* repo, struct ref_filter *filter);
> +
> +typedef int each_change_fn(const char *refname, void *cb_data);
> +
> +extern int change_table_has_change_referencing(struct change_table *changes,
> +	const struct object_id *referenced_commit_id);
> +
> +/* Iterates over all changes that reference the given commit. For metacommits,
> + * this is the list of changes that point directly to that metacommit.
> + * For normal commits, this is the list of changes that have this commit as
> + * their latest content.
> + */
> +extern int for_each_change_referencing(struct change_table *heads,
> +	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data);
> +
> +/**
> + * Returns the change head for the given refname. Returns NULL if no such change
> + * exists.
> + */
> +extern struct change_head* get_change_head(struct change_table *heads,
> +	const char* refname);
> +
> +#endif
> -- 
> 2.20.1.495.gaa96b0ce6b-goog
> 
> 
> 
