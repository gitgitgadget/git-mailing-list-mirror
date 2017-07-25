Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AA62089A
	for <e@80x24.org>; Tue, 25 Jul 2017 20:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdGYUTE (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 16:19:04 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33410 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdGYUTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 16:19:01 -0400
Received: by mail-pg0-f53.google.com with SMTP id g14so25704289pgu.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+vr2ImCLuBzGhKQLJewY8WpgqebzrcitEGRENNSNVmk=;
        b=nzEw98MJCC2kYkMFk7PXBIOHGpYzrdpHPABqX36JpyfPp8kIV3+v1GXA9Qem/7Ev0h
         bFZ4zzT8jPK5A/a68ZRSwzv45AxD/gymxcgmY0sMmF5z1HsATUWQCewH3Ri7kodZ6E6Q
         reTFEQkFxCq1e6IAho4ciEQscBhOdiPXfZ5srWTkrEM/qkOV9aUu8Qv6R+fgO/iqRop2
         Koa2aj+tLmUmG7BXOOQ7qY27Ffzr9xU7iFfZJ1Mqekfy4d8bgjVIvixh7e0yvG0NIjWC
         W20fkz8T1yewlImKRpQpqNAgMhhYHLKf34G5TaFOXY5rocKlnhjx04zBM0LbWO9FHLMX
         ZkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+vr2ImCLuBzGhKQLJewY8WpgqebzrcitEGRENNSNVmk=;
        b=asqZMg051VbZQfGLJBAUbPRkkVKJnopOSmd1h9Fv57FDOMGxojM6dbBEiCe1e0Yt6a
         f52ZbvZToofu+aOznhoKPUe4Jh57+KZsHx6EsdLfzWlorArMPeqtUDFzo9j7ltzpo8fo
         riIEcZ85oF2kQ2rF9HxjrSxSM0YvvneV3DP24FXuvLiSOFxIechMO+dHM0WExXyaGte0
         1mowWllALHIduyLwqdgO4iE12uZxq4qhoxSp780lQLKSasSq9X0nRhWl/H7cLnv3OSW/
         8asgOR9EQ+q+LWC96g8xCcJCsaQG/Co/iPQgI8oCtMqCHjKZB7Cs7nG8ESpxLQBth+hh
         kZAQ==
X-Gm-Message-State: AIVw113pvKmJpFzDR0exmiBUVPwVmuBBmLBVGdCyEQJx9uwqoWWWlNPS
        D1gQ1HX6T2PU+32z
X-Received: by 10.84.232.141 with SMTP id i13mr23214769plk.139.1501013940844;
        Tue, 25 Jul 2017 13:19:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cccf:9961:8336:68b3])
        by smtp.gmail.com with ESMTPSA id 64sm16934909pfp.103.2017.07.25.13.18.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 13:18:59 -0700 (PDT)
Date:   Tue, 25 Jul 2017 13:18:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peartben@gmail.com
Subject: Re: [PATCH v2 1/2] Documentation: migrate sub-process docs to header
Message-ID: <20170725201858.GJ92874@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com>
 <cover.1501007300.git.jonathantanmy@google.com>
 <2d97d07a4977048a8147292ac13db48f5202d52f.1501007300.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d97d07a4977048a8147292ac13db48f5202d52f.1501007300.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Jonathan Tan wrote:
> Move the documentation for the sub-process API from a separate txt file
> to its header file.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

I really like this change!

> ---
>  Documentation/technical/api-sub-process.txt | 59 -----------------------------
>  sub-process.h                               | 25 +++++++++++-
>  2 files changed, 23 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/technical/api-sub-process.txt
> 
> diff --git a/Documentation/technical/api-sub-process.txt b/Documentation/technical/api-sub-process.txt
> deleted file mode 100644
> index 793508cf3..000000000
> --- a/Documentation/technical/api-sub-process.txt
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -sub-process API
> -===============
> -
> -The sub-process API makes it possible to run background sub-processes
> -for the entire lifetime of a Git invocation. If Git needs to communicate
> -with an external process multiple times, then this can reduces the process
> -invocation overhead. Git and the sub-process communicate through stdin and
> -stdout.
> -
> -The sub-processes are kept in a hashmap by command name and looked up
> -via the subprocess_find_entry function.  If an existing instance can not
> -be found then a new process should be created and started.  When the
> -parent git command terminates, all sub-processes are also terminated.
> -
> -This API is based on the run-command API.
> -
> -Data structures
> ----------------
> -
> -* `struct subprocess_entry`
> -
> -The sub-process structure.  Members should not be accessed directly.
> -
> -Types
> ------
> -
> -'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
> -
> -	User-supplied function to initialize the sub-process.  This is
> -	typically used to negotiate the interface version and capabilities.
> -
> -
> -Functions
> ----------
> -
> -`cmd2process_cmp`::
> -
> -	Function to test two subprocess hashmap entries for equality.
> -
> -`subprocess_start`::
> -
> -	Start a subprocess and add it to the subprocess hashmap.
> -
> -`subprocess_stop`::
> -
> -	Kill a subprocess and remove it from the subprocess hashmap.
> -
> -`subprocess_find_entry`::
> -
> -	Find a subprocess in the subprocess hashmap.
> -
> -`subprocess_get_child_process`::
> -
> -	Get the underlying `struct child_process` from a subprocess.
> -
> -`subprocess_read_status`::
> -
> -	Helper function to read packets looking for the last "status=<foo>"
> -	key/value pair.
> diff --git a/sub-process.h b/sub-process.h
> index 96a2cca36..9e6975b5e 100644
> --- a/sub-process.h
> +++ b/sub-process.h
> @@ -6,12 +6,23 @@
>  #include "run-command.h"
>  
>  /*
> - * Generic implementation of background process infrastructure.
> - * See: Documentation/technical/api-sub-process.txt
> + * The sub-process API makes it possible to run background sub-processes
> + * for the entire lifetime of a Git invocation. If Git needs to communicate
> + * with an external process multiple times, then this can reduces the process
> + * invocation overhead. Git and the sub-process communicate through stdin and
> + * stdout.
> + *
> + * The sub-processes are kept in a hashmap by command name and looked up
> + * via the subprocess_find_entry function.  If an existing instance can not
> + * be found then a new process should be created and started.  When the
> + * parent git command terminates, all sub-processes are also terminated.
> + * 
> + * This API is based on the run-command API.
>   */
>  
>   /* data structures */
>  
> +/* Members should not be accessed directly. */
>  struct subprocess_entry {
>  	struct hashmap_entry ent; /* must be the first member! */
>  	const char *cmd;
> @@ -20,21 +31,31 @@ struct subprocess_entry {
>  
>  /* subprocess functions */
>  
> +/* Function to test two subprocess hashmap entries for equality. */
>  extern int cmd2process_cmp(const void *unused_cmp_data,
>  			   const struct subprocess_entry *e1,
>  			   const struct subprocess_entry *e2,
>  			   const void *unused_keydata);
>  
> +/*
> + * User-supplied function to initialize the sub-process.  This is
> + * typically used to negotiate the interface version and capabilities.
> + */
>  typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
> +
> +/* Start a subprocess and add it to the subprocess hashmap. */
>  int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
>  		subprocess_start_fn startfn);
>  
> +/* Kill a subprocess and remove it from the subprocess hashmap. */
>  void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry);
>  
> +/* Find a subprocess in the subprocess hashmap. */
>  struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const char *cmd);
>  
>  /* subprocess helper functions */
>  
> +/* Get the underlying `struct child_process` from a subprocess. */
>  static inline struct child_process *subprocess_get_child_process(
>  		struct subprocess_entry *entry)
>  {
> -- 
> 2.14.0.rc0.400.g1c36432dff-goog
> 

-- 
Brandon Williams
