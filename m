Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41426201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbdB1Rwh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:52:37 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53934 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751243AbdB1Rwe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 12:52:34 -0500
X-AuditID: 12074412-4bbff70000000b04-1e-58b5b8541397
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 93.03.02820.458B5B85; Tue, 28 Feb 2017 12:50:12 -0500 (EST)
Received: from [192.168.69.190] (p5B10410E.dip0.t-ipconnect.de [91.16.65.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1SHo9Ja016506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 28 Feb 2017 12:50:10 -0500
Subject: Re: [PATCH v5 08/24] files-backend: remove the use of git_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-9-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5c4a292e-ab86-ffe0-ba8d-c0fe1b527ec1@alum.mit.edu>
Date:   Tue, 28 Feb 2017 18:50:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170222140450.30886-9-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqBuyY2uEwcaPphZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyniy4DZTwQHpilsPTjE2MH4W7WLk5JAQMJHYvHQ2Sxcj
        F4eQwA4mib6rF5ggnLNMEk8v9zOBVAkLeEo8ezaZGcQWEUiTWDz5PTNEUT+jxJ725WDtzAI3
        GCUuTfwI1sEmoCuxqKcZzOYVsJe4134KrJtFQFXi3ZEn7CC2qECIxJyFDxghagQlTs58wgJi
        cwqYS6xp+sUKYjMLqEv8mXeJGcKWl2jeOpt5AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJm
        TnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSMAL7WBcf1LuEKMAB6MSD++B7q0RQqyJZcWVuYcY
        JTmYlER5g2YAhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw7igGyvGmJFZWpRblw6SkOViUxHl/
        Llb3ExJITyxJzU5NLUgtgsnKcHAoSfDabAdqFCxKTU+tSMvMKUFIM3FwggznARruBlLDW1yQ
        mFucmQ6RP8Woy7Hj6JE3TEIsefl5qVLivMXbgIoEQIoySvPg5sAS1StGcaC3hHmLQEbxAJMc
        3KRXQEuYgJa8UAFbUpKIkJJqYGxraLy2KYeteOJk0UiXV/0fd0ku3PP/vaJBHuuaJ+c7znIl
        7v8p3OuY33b4u4JeSmfl3S1e++8yvLz5zHOu98xtuYtPb1AXWx9dWmV1zKdptphHPPP13uzz
        TK+v+JkoJmzq7ntY4yVUrrMsKbzNRvjH+oiJn1STRQ+zzdp+SbxEdMuReRl3Q5RYijMSDbWY
        i4oTAQF572IvAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
> Given $GIT_DIR and $GIT_COMMON_DIR, files-backend is now in charge of
> deciding what goes where (*). The end goal is to pass $GIT_DIR only. A
> refs "view" of a linked worktree is a logical ref store that combines
> two files backends together.
> 
> (*) Not entirely true since strbuf_git_path_submodule() still does path
> translation underneath. But that's for another patch.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 72f4e1746..a390eaadf 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -923,7 +923,8 @@ struct files_ref_store {
>  	 * store:
>  	 */
>  	const char *submodule;
> -
> +	char *gitdir;
> +	char *gitcommondir;
>  	char *packed_refs_path;
>  
>  	struct ref_entry *loose;
> @@ -985,6 +986,8 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>  {
>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *gitdir = get_git_dir();
>  
>  	base_ref_store_init(ref_store, &refs_be_files);
>  
> @@ -995,7 +998,11 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>  		return ref_store;
>  	}
>  
> -	refs->packed_refs_path = git_pathdup("packed-refs");
> +	refs->gitdir = xstrdup(gitdir);
> +	get_common_dir_noenv(&sb, gitdir);
> +	refs->gitcommondir = strbuf_detach(&sb, NULL);
> +	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
> +	refs->packed_refs_path = strbuf_detach(&sb, NULL);

`git_path()` and friends avoid adding an extra `/` if `git_dir()`
already ends in a slash or if it is the empty string. Here you don't
have that functionality. Is that intentional?

Same thing below, too.

>  
>  	return ref_store;
>  }
> @@ -1173,11 +1180,26 @@ static void files_reflog_path(struct files_ref_store *refs,
>  			      const char *refname)
>  {
>  	if (!refname) {
> -		strbuf_git_path(sb, "logs");
> +		/*
> +		 * FIXME: of course this is wrong in multi worktree
> +		 * setting. To be fixed real soon.
> +		 */
> +		strbuf_addf(sb, "%s/logs", refs->gitcommondir);
>  		return;
>  	}
>  
> -	strbuf_git_path(sb, "logs/%s", refname);
> +	switch (ref_type(refname)) {
> +	case REF_TYPE_PER_WORKTREE:
> +	case REF_TYPE_PSEUDOREF:
> +		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
> +		break;
> +	case REF_TYPE_NORMAL:
> +		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
> +		break;
> +	default:
> +		die("BUG: unknown ref type %d of ref %s",
> +		    ref_type(refname), refname);
> +	}
>  }
>  
>  static void files_refname_path(struct files_ref_store *refs,
> @@ -1189,7 +1211,18 @@ static void files_refname_path(struct files_ref_store *refs,
>  		return;
>  	}
>  
> -	strbuf_git_path(sb, "%s", refname);
> +	switch (ref_type(refname)) {
> +	case REF_TYPE_PER_WORKTREE:
> +	case REF_TYPE_PSEUDOREF:
> +		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
> +		break;
> +	case REF_TYPE_NORMAL:
> +		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
> +		break;
> +	default:
> +		die("BUG: unknown ref type %d of ref %s",
> +		    ref_type(refname), refname);
> +	}
>  }
>  
>  /*
> 

Michael

