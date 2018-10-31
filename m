Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E961F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbeKAFMb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:12:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34540 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeKAFMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:12:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so10975138qkg.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gDyZCaW+2CgYxo15InZoQLsCRotG7odMaEKP/c8xCw4=;
        b=XXj73Bn1PNSVhl26HiG4089H8eBQ9rrKpI54su4C0LdsjXJcqPEawaj/HI7L2G1Cpc
         /Oat3GFgt3q3Lp3pcfW4mRB4K2YPyo2m/GZNtc42Heg1pJ749o5vzCsABVKdXkYicRYk
         erJySp/NbPWmAj5g8JD5a3ePVM/k3AvwdK97Rvn5qJGzG53/MCjaEGFJSM9wRILs+w/K
         4viGDlpud0936p/UsRINE0D7oFhBax23pmbAwfIk1/hUmtAU77m9IhahlqHsN9ELRZtY
         J9kItvMvPLhHtkNRCKzC3J/E6Mymh8PK9EzFfa8kcNMq958tx1yp/QH0C8XBqRhTUgB6
         F0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gDyZCaW+2CgYxo15InZoQLsCRotG7odMaEKP/c8xCw4=;
        b=gtj4XcKKq1Hsq4xNu514foKTWo/tO274PlVDaThfhmjqbeJw60OBQTarAdHjIxH6Mh
         w0X1oTKCmxnQUfJxdU4w0w4GcgrXJ8IeNE72Wsz3ljE1yR2Ch5Z8AuBrpMHAbUrbz0yI
         uewVdB4M3WZVmN0aUyABfHitlD0iaIQdQVTt05q3BDM1y2cAJgrQpjOXRfG64aXTTSKK
         3gmchCCLnWo+RI1yfQfx8hLu/bqfqDVL8k5WLqsMinhNW5L/CaudkL1XMPBBZ34Lhzld
         HLZb5c2UJn5bXF5kOWH/R0CjD/wO5k/hpuaPYAvti1qpOzLfeFIPZT05fE9xUrhhMUSa
         Vgmg==
X-Gm-Message-State: AGRZ1gK9UGYGNf/T0OHlXsnwzeSp8Sed7ANw55r0Ad/uwnraI5J3wuRC
        oEDDKX4DvScnZw+Y+vv4sE0=
X-Google-Smtp-Source: AJdET5dizgMf33opEpeHrI4PA1FUO3pDpbMYdwK5b5AJAjEN5uLLScP9deN9KaC/ANanWW4nwQxIRw==
X-Received: by 2002:a37:1509:: with SMTP id f9mr3798721qkh.271.1541016775076;
        Wed, 31 Oct 2018 13:12:55 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g83-v6sm6042229qkb.57.2018.10.31.13.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:12:54 -0700 (PDT)
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <xmqqsh0nyqx9.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dbc2eb4f-842e-f49a-256f-3a140d801bb0@gmail.com>
Date:   Wed, 31 Oct 2018 16:12:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqsh0nyqx9.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/30/2018 7:07 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> diff --git a/config.c b/config.c
>> index 4051e38823..96e05ee0f1 100644
>> --- a/config.c
>> +++ b/config.c
>> ...
>> @@ -2307,6 +2311,37 @@ int git_config_get_index_threads(void)
>>   	return 0; /* auto */
>>   }
>>   
>> +int git_config_get_virtualfilesystem(void)
>> +{
>> +	if (git_config_get_pathname("core.virtualfilesystem", &core_virtualfilesystem))
>> +		core_virtualfilesystem = getenv("GIT_TEST_VIRTUALFILESYSTEM");
>> +
>> +	if (core_virtualfilesystem && !*core_virtualfilesystem)
>> +		core_virtualfilesystem = NULL;
>> +
>> +	if (core_virtualfilesystem) {
>> +		/*
>> +		 * Some git commands spawn helpers and redirect the index to a different
>> +		 * location.  These include "difftool -d" and the sequencer
>> +		 * (i.e. `git rebase -i`, `git cherry-pick` and `git revert`) and others.
>> +		 * In those instances we don't want to update their temporary index with
>> +		 * our virtualization data.
>> +		 */
>> +		char *default_index_file = xstrfmt("%s/%s", the_repository->gitdir, "index");
>> +		int should_run_hook = !strcmp(default_index_file, the_repository->index_file);
>> +
>> +		free(default_index_file);
>> +		if (should_run_hook) {
>> +			/* virtual file system relies on the sparse checkout logic so force it on */
>> +			core_apply_sparse_checkout = 1;
>> +			return 1;
>> +		}
>> +		core_virtualfilesystem = NULL;
> 
> It would be a small leak if this came from config_get_pathname(),
> but if it came from $GIT_TEST_VFS env, we cannot free it X-<.
> 
> A helper function called *_get_X() that does not return X as its
> return value or updating the location pointed by its *dst parameter,
> and instead only stores its finding in a global variable feels
> somewhat odd.  It smells more like "find out", "probe", "check",
> etc.
> 

I agree.  Frankly, I think it should just return whether it should be 
used or not (bool) and the hook name should be fixed.  I got push back 
when I did that for fsmonitor so I made this the same in an effort to 
head off that same feedback.

>> diff --git a/dir.c b/dir.c
>> index 47c2fca8dc..3097b0e446 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -21,6 +21,7 @@
>>   #include "ewah/ewok.h"
>>   #include "fsmonitor.h"
>>   #include "submodule-config.h"
>> +#include "virtualfilesystem.h"
>>   
>>   /*
>>    * Tells read_directory_recursive how a file or directory should be treated.
>> @@ -1109,6 +1110,18 @@ int is_excluded_from_list(const char *pathname,
>>   			  struct exclude_list *el, struct index_state *istate)
>>   {
>>   	struct exclude *exclude;
>> +
>> +	/*
>> +	 * The virtual file system data is used to prevent git from traversing
>> +	 * any part of the tree that is not in the virtual file system.  Return
>> +	 * 1 to exclude the entry if it is not found in the virtual file system,
>> +	 * else fall through to the regular excludes logic as it may further exclude.
>> +	 */
> 
> This comment will sit better immediately in front of the call to "is
> excluded from vfs?" helper function.
> 
>> +	if (*dtype == DT_UNKNOWN)
>> +		*dtype = get_dtype(NULL, istate, pathname, pathlen);
> 
> We try to defer paying cost to determine unknown *dtype as late as
> possible by having this call in last_exclude_matching_from_list(),
> and not here.  If we are doing this, we probably should update the
> callpaths that call last_exclude_matching_from_list() to make the
> caller responsible for doing get_dtype() and drop the lazy finding
> of dtype from the callee.  Alternatively, the new "is excluded from
> vfs" helper can learn to do the lazy get_dtype() just like the
> existing last_exclude_matching_from_list() does.  I suspect the
> latter may be simpler.

In is_excluded_from_virtualfilesystem() dtype can't be lazy because it 
is always needed (which is why I test and die if it isn't known).  I 
considered doing the test/call to get_dtype() within 
is_excluded_from_virtualfilesystem() but didn't like making it dependent 
on istate just so I could move the get_dtype() call in one level.  It is 
functionally identical so I can easily move it in if that is preferred.

> 
>> +	if (is_excluded_from_virtualfilesystem(pathname, pathlen, *dtype) > 0)
>> +		return 1;
>> +
>>   	exclude = last_exclude_matching_from_list(pathname, pathlen, basename,
>>   						  dtype, el, istate);
>>   	if (exclude)
>> @@ -1324,8 +1337,20 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
>>   int is_excluded(struct dir_struct *dir, struct index_state *istate,
>>   		const char *pathname, int *dtype_p)
>>   {
>> -	struct exclude *exclude =
>> -		last_exclude_matching(dir, istate, pathname, dtype_p);
>> +	struct exclude *exclude;
>> +
>> +	/*
>> +	 * The virtual file system data is used to prevent git from traversing
>> +	 * any part of the tree that is not in the virtual file system.  Return
>> +	 * 1 to exclude the entry if it is not found in the virtual file system,
>> +	 * else fall through to the regular excludes logic as it may further exclude.
>> +	 */
>> +	if (*dtype_p == DT_UNKNOWN)
>> +		*dtype_p = get_dtype(NULL, istate, pathname, strlen(pathname));
> 
> Exactly the same comment as above.
> 
>> +	if (is_excluded_from_virtualfilesystem(pathname, strlen(pathname), *dtype_p) > 0)
>> +		return 1;
>> +
>> +	exclude = last_exclude_matching(dir, istate, pathname, dtype_p);
>>   	if (exclude)
>>   		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
>>   	return 0;
>> @@ -1678,6 +1703,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>>   	if (dtype != DT_DIR && has_path_in_index)
>>   		return path_none;
>>   
>> +	if (is_excluded_from_virtualfilesystem(path->buf, path->len, dtype) > 0)
>> +		return path_excluded;
>> +
>>   	/*
>>   	 * When we are looking at a directory P in the working tree,
>>   	 * there are three cases:
>> @@ -2018,6 +2046,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>>   		/* add the path to the appropriate result list */
>>   		switch (state) {
>>   		case path_excluded:
>> +			if (is_excluded_from_virtualfilesystem(path.buf, path.len, DT_DIR) > 0)
>> +				break;
>>   			if (dir->flags & DIR_SHOW_IGNORED)
>>   				dir_add_name(dir, istate, path.buf, path.len);
>>   			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
> 
> I am kind-of surprised that the "damage" to dir.c need to support
> this is so isolated and small ;-)
> 

When I'm expecting to carry a patch in a fork I try to structure it to 
have as small of a footprint as possible (hence moving most of the code 
into a separate file).  Keeps the merge conflicts to a minimum. ;-)

>> ...
>> +if test "$1" != 1
>> +then
>> +	echo "Unsupported core.virtualfilesystem hook version." >&2
>> +	exit 1
>> +fi
>> +
>> +#find -type f -printf '%P\0'
>> +find -type d -printf '%P/\0'
> 
> I am not reading (hence not commenting on) tests in this review
> message yet.
> 
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 7570df481b..ee3cda2e94 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -18,6 +18,7 @@
>>   #include "fsmonitor.h"
>>   #include "object-store.h"
>>   #include "fetch-object.h"
>> +#include "virtualfilesystem.h"
>>   
>>   /*
>>    * Error messages expected by scripts out of plumbing commands such as
>> @@ -1363,6 +1364,14 @@ static int clear_ce_flags_1(struct index_state *istate,
>>   			continue;
>>   		}
>>   
>> +		/* if it's not in the virtual file system, exit early */
>> +		if (core_virtualfilesystem) {
>> +			if (is_included_in_virtualfilesystem(ce->name, ce->ce_namelen) > 0)
>> +				ce->ce_flags &= ~clear_mask;
>> +			cache++;
>> +			continue;
>> +		}
> 
> Earlier we saw "is it excluded?" and now we have "is it included?"
> They have different function signature (i.e. "included?" does not
> need to know the type of the entry), and I am guessing that for the
> purpose of this particular patch that may be sufficient, but I have
> to wonder if in the longer term we'd be better off to keep the
> interface to these two functions similar.  Also, I wonder if we need
> both---I see below that these "is included/excluded?" helpers are
> allowed to say "I dunno", so that may be the reason why we cannot
> simply say "included is the same as !excluded".
> 

Most of the logic _is_ just inverted (which is why is_excluded...() can 
call is_included...() to do most of the work) but there are differences 
as well.  The differences are mostly about how parent directories are 
handled.  I tried to write it to share as much of the logic as possible 
but there may be something I've missed.


Your comments are all feedback on the code - how it was implemented, 
style, etc.  Any thoughts on whether this is something we could/should 
merge into master (after any necessary cleanup)?  Would anyone else find 
this interesting/helpful?
