Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C3120FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 00:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcF3A4V (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 20:56:21 -0400
Received: from avasout08.plus.net ([212.159.14.20]:55155 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbcF3A4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 20:56:19 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout08 with smtp
	id CowF1t00123PrXV01owGJg; Thu, 30 Jun 2016 01:56:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=M8UPEG4s c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=N659UExz7-8A:10 a=TSbVqHtbAAAA:8 a=v2D0MMyssgImnUeeI0UA:9
 a=NJcUIoPEKLAEIzHnl83t:22
X-AUTH:	ramsayjones@:2500
Subject: Re: What's cooking in git.git (Jun 2016, #10; Wed, 29)
To:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd1mz1sxd.fsf@gitster.mtv.corp.google.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <57746E2B.4000303@ramsayjones.plus.com>
Date:	Thu, 30 Jun 2016 01:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1mz1sxd.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 30/06/16 00:22, Junio C Hamano wrote:
[snip]
> 
> * mh/ref-store (2016-06-20) 38 commits
>  - refs: implement iteration over only per-worktree refs
>  - refs: make lock generic
>  - refs: add method to rename refs
>  - refs: add methods to init refs db
>  - refs: make delete_refs() virtual
>  - refs: add method for initial ref transaction commit
>  - refs: add methods for reflog
>  - refs: add method iterator_begin
>  - files_ref_iterator_begin(): take a ref_store argument
>  - split_symref_update(): add a files_ref_store argument
>  - lock_ref_sha1_basic(): add a files_ref_store argument
>  - lock_ref_for_update(): add a files_ref_store argument
>  - commit_ref_update(): add a files_ref_store argument
>  - lock_raw_ref(): add a files_ref_store argument
>  - repack_without_refs(): add a files_ref_store argument
>  - refs: make peel_ref() virtual
>  - refs: make create_symref() virtual
>  - refs: make pack_refs() virtual
>  - refs: make verify_refname_available() virtual
>  - refs: make read_raw_ref() virtual
>  - resolve_gitlink_ref(): rename path parameter to submodule
>  - resolve_gitlink_ref(): avoid memory allocation in many cases
>  - resolve_gitlink_ref(): implement using resolve_ref_recursively()
>  - resolve_ref_recursively(): new function
>  - read_raw_ref(): take a (struct ref_store *) argument
>  - resolve_gitlink_packed_ref(): remove function
>  - resolve_packed_ref(): rename function from resolve_missing_loose_ref()
>  - refs: reorder definitions
>  - refs: add a transaction_commit() method
>  - {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
>  - resolve_missing_loose_ref(): add a files_ref_store argument
>  - get_packed_ref(): add a files_ref_store argument
>  - add_packed_ref(): add a files_ref_store argument
>  - refs: create a base class "ref_store" for files_ref_store
>  - refs: add a backend method structure
>  - refs: rename struct ref_cache to files_ref_store
>  - rename_ref_available(): add docstring
>  - resolve_gitlink_ref(): eliminate temporary variable
>  (this branch uses mh/ref-iterators and mh/split-under-lock; is tangled with mh/update-ref-errors.)
> 
>  The ref-store abstraction was introduced to the refs API so that we
>  can plug in different backends to store references.
> 
>  Is everybody happy with this version?
>  If so, will merge to 'next'.

A small fixup required for this one.

see http://thread.gmane.org/gmane.comp.version-control.git/298137

ATB,
Ramsay Jones



