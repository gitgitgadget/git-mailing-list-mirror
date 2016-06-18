Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7831D1FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbcFRESw (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:18:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44181 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738AbcFRESv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:18:51 -0400
X-AuditID: 1207440f-8a7ff700000008e4-56-5764cbaa0bd8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2B.64.02276.AABC4675; Sat, 18 Jun 2016 00:18:50 -0400 (EDT)
Received: from [192.168.69.130] (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4Inwd029559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:18:50 -0400
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5764CBA8.5070303@alum.mit.edu>
Date:	Sat, 18 Jun 2016 06:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLvqdEq4wfEFmhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xtc3F5gKpspVXG88ytzA+F2ii5GTQ0LAROLH
	1cPMILaQwFZGiUfbdLsYuYDsC0wS21vfgSWEBewlFu/dzQJiiwhYS/z++Z0JosFKovPeIVYQ
	m01AV2JRTzNYnFdAW2LDu+OMXYwcHCwCqhLr30iBhEUFQiTOr9vKClEiKHFy5hMWkBJOoJFT
	vimAhJkF9CR2XP/FCmHLS2x/O4d5AiPfLCQds5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrolebmaJXmpK6SZGSMjx72DsWi9ziFGAg1GJhzfAPiVciDWxrLgy9xCjJAeTkijv
	lUqgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeLSeAcrwpiZVVqUX5MClpDhYlcV71Jep+QgLp
	iSWp2ampBalFMFkZDg4lCd6lJ4EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFR
	F18MjDuQFA/QXvlTIHuLCxJzgaIQracYdTnWzb2xlkmIJS8/L1VKnPcZyA4BkKKM0jy4FbAE
	84pRHOhjYd4EkFE8wOQEN+kV0BImoCWa85JBlpQkIqSkGhh52AoXX35a7jmp/9UX6cop5xTn
	X737aGL8rdlbalc+2mclu40/qEtrL9uN1de5t1d2ihyYozLtJ1s7kz2/pOfz7bsFd3Uu9FfN
	rTrC9Kp6luK2tNKWpI8zPa6/2vrtTaeJ9X/m7rMLFNWfZB+KdE69s2YO15eun0bLt7bc3bt3
	76qHM+1sJPTzlFiKMxINtZiLihMBg9ULmQsDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/17/2016 05:20 AM, Junio C Hamano wrote:
> [...]
> * mh/ref-iterators (2016-06-03) 13 commits
>   (merged to 'next' on 2016-06-06 at c8e79dc)
>  + for_each_reflog(): reimplement using iterators
>  + dir_iterator: new API for iterating over a directory tree
>  + for_each_reflog(): don't abort for bad references
>  + do_for_each_ref(): reimplement using reference iteration
>  + refs: introduce an iterator interface
>  + ref_resolves_to_object(): new function
>  + entry_resolves_to_object(): rename function from ref_resolves_to_object()
>  + get_ref_cache(): only create an instance if there is a submodule
>  + remote rm: handle symbolic refs correctly
>  + delete_refs(): add a flags argument
>  + refs: use name "prefix" consistently
>  + do_for_each_ref(): move docstring to the header file
>  + refs: remove unnecessary "extern" keywords
>  (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)
> 
>  The API to iterate over all the refs (i.e. for_each_ref(), etc.)
>  has been revamped.
> 
>  Will merge to 'master'.

It would be preferable (though not critical) to use the promised v3,
which I just sent [1]. This includes some minor improvements, described
here [2]. This is also available from my GitHub fork [3] as branch
"ref-iterators".

> * mh/split-under-lock (2016-05-13) 33 commits
>   (merged to 'next' on 2016-06-03 at 2e71330)
>  + lock_ref_sha1_basic(): only handle REF_NODEREF mode
>  + commit_ref_update(): remove the flags parameter
>  + lock_ref_for_update(): don't resolve symrefs
>  + lock_ref_for_update(): don't re-read non-symbolic references
>  + refs: resolve symbolic refs first
>  + ref_transaction_update(): check refname_is_safe() at a minimum
>  + unlock_ref(): move definition higher in the file
>  + lock_ref_for_update(): new function
>  + add_update(): initialize the whole ref_update
>  + verify_refname_available(): adjust constness in declaration
>  + refs: don't dereference on rename
>  + refs: allow log-only updates
>  + delete_branches(): use resolve_refdup()
>  + ref_transaction_commit(): correctly report close_ref() failure
>  + ref_transaction_create(): disallow recursive pruning
>  + refs: make error messages more consistent
>  + lock_ref_sha1_basic(): remove unneeded local variable
>  + read_raw_ref(): move docstring to header file
>  + read_raw_ref(): improve docstring
>  + read_raw_ref(): rename symref argument to referent
>  + read_raw_ref(): clear *type at start of function
>  + read_raw_ref(): rename flags argument to type
>  + ref_transaction_commit(): remove local variable n
>  + rename_ref(): remove unneeded local variable
>  + commit_ref_update(): write error message to *err, not stderr
>  + refname_is_safe(): insist that the refname already be normalized
>  + refname_is_safe(): don't allow the empty string
>  + refname_is_safe(): use skip_prefix()
>  + remove_dir_recursively(): add docstring
>  + safe_create_leading_directories(): improve docstring
>  + read_raw_ref(): don't get confused by an empty directory
>  + commit_ref(): if there is an empty dir in the way, delete it
>  + t1404: demonstrate a bug resolving references
>  (this branch is used by mh/ref-iterators, mh/ref-store and mh/update-ref-errors.)
> 
>  Further preparatory work on the refs API before the pluggable
>  backend series can land.
> 
>  Will merge to 'master'.

Please make sure to pick up the important bugfix discussed here [4],
which is integrated into branch "split-under-lock" on my GitHub fork [3].

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/297625
[2]
http://thread.gmane.org/gmane.comp.version-control.git/296322/focus=296883
[3] https://github.com/mhagger/git
[4] http://article.gmane.org/gmane.comp.version-control.git/297174

