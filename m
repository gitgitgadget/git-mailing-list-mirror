Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE14E1FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 08:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbcFSH7w (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 03:59:52 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47962 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751613AbcFSH7l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 03:59:41 -0400
X-AuditID: 12074411-e2bff70000000955-d5-576650eb113e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 44.BE.02389.BE056675; Sun, 19 Jun 2016 03:59:39 -0400 (EDT)
Received: from [192.168.69.130] (p4FEEA82D.dip0.t-ipconnect.de [79.238.168.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5J7xaXr005433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 19 Jun 2016 03:59:38 -0400
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <576650E7.70107@alum.mit.edu>
Date:	Sun, 19 Jun 2016 09:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqPs6IC3coHO2skXXlW4mi4beK8wW
	jx8uYbU4PusauwOLx4MrWxg9ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGe2/HjIV
	LFauODb3PHsD417ZLkZODgkBE4krR3eydjFycQgJbGWUOHr5KJRznknie+tFRpAqYQF7icV7
	d7OA2CICURKNO3+ygdhCArkST06sAarh4GAW8JY491kEJMwmoCuxqKeZCcTmFdCU+PlgGzOI
	zSKgKvHrzw12EFtUIETi/LqtrBA1ghInZz4BG88pYCvx5OpGsDizgJ7Ejuu/oGx5ie1v5zBP
	YOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQICVvB
	HYwzTsodYhTgYFTi4V2xIzVciDWxrLgy9xCjJAeTkijvnm6gEF9SfkplRmJxRnxRaU5q8SFG
	CQ5mJRHe035p4UK8KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4OJQleTmB8
	CgkWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIjK+GBiTICkeoL1H/EH2Fhck5gJF
	IVpPMepyrJt7Yy2TEEtefl6qlDjvHJAiAZCijNI8uBWwJPWKURzoY2HevSBVPMAEBzfpFdAS
	JqAlmvOSQZaUJCKkpBoYtSRlHYUcjqp4/j5zQOfkvDKnE7GKEbzfOUNemR/ysLRS+sf6yczj
	a8bUp/NFdafcSWP9+dRF+tm9mEOsrhoqDiu+NBfw/elhCjXc2qnq2at0eeLsRP8bbgK9cTUi
	ATmW0/gbw37P/3zhzqaZNdOFPs18vlLrud3CFX//P1l23Pb05SgWxRtWSizFGYmGWsxFxYkA
	cR/7BC0DAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/18/2016 12:05 AM, Lars Schneider wrote:
> 
>> On 17 Jun 2016, at 05:20, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> ...
>>
>> * mh/split-under-lock (2016-05-13) 33 commits
>>  (merged to 'next' on 2016-06-03 at 2e71330)
>> + lock_ref_sha1_basic(): only handle REF_NODEREF mode
>> + commit_ref_update(): remove the flags parameter
>> + lock_ref_for_update(): don't resolve symrefs
>> + lock_ref_for_update(): don't re-read non-symbolic references
>> + refs: resolve symbolic refs first
>> + ref_transaction_update(): check refname_is_safe() at a minimum
>> + unlock_ref(): move definition higher in the file
>> + lock_ref_for_update(): new function
>> + add_update(): initialize the whole ref_update
>> + verify_refname_available(): adjust constness in declaration
>> + refs: don't dereference on rename
>> + refs: allow log-only updates
>> + delete_branches(): use resolve_refdup()
>> + ref_transaction_commit(): correctly report close_ref() failure
>> + ref_transaction_create(): disallow recursive pruning
>> + refs: make error messages more consistent
>> + lock_ref_sha1_basic(): remove unneeded local variable
>> + read_raw_ref(): move docstring to header file
>> + read_raw_ref(): improve docstring
>> + read_raw_ref(): rename symref argument to referent
>> + read_raw_ref(): clear *type at start of function
>> + read_raw_ref(): rename flags argument to type
>> + ref_transaction_commit(): remove local variable n
>> + rename_ref(): remove unneeded local variable
>> + commit_ref_update(): write error message to *err, not stderr
>> + refname_is_safe(): insist that the refname already be normalized
>> + refname_is_safe(): don't allow the empty string
>> + refname_is_safe(): use skip_prefix()
>> + remove_dir_recursively(): add docstring
>> + safe_create_leading_directories(): improve docstring
>> + read_raw_ref(): don't get confused by an empty directory
>> + commit_ref(): if there is an empty dir in the way, delete it
>> + t1404: demonstrate a bug resolving references
>> (this branch is used by mh/ref-iterators, mh/ref-store and mh/update-ref-errors.)
>>
>> Further preparatory work on the refs API before the pluggable
>> backend series can land.
>>
>> Will merge to 'master'.
> 
> This topic seems break two git-p4 tests (t9801 and t9803) on next:
> https://travis-ci.org/git/git/jobs/137333785
> 
> According to git bisect the commit "ref_transaction_update(): 
> check refname_is_safe() at a minimum" (3da1f3) introduces the problem: 
> https://s3.amazonaws.com/archive.travis-ci.org/jobs/138457628/log.txt
> (scroll all the way down to see the bisecting)
> 
> - Lars
> 

Lars,

According to [1], something in that test seems to have been trying to run

    git update-ref -d git-p4-tmp/6

Similarly in the other failed test.

Because `update-ref` doesn't do DWIM for reference names, this is *not*
expanded to `refs/heads/git-p4-tmp/6` or something. Previously this
command would have quietly failed to do anything. But after
"ref_transaction_update(): check refname_is_safe() at a minimum", `git
update-ref` notices that `git/p4/tmp/6` is not a safe refname (according
to `refname_is_safe()` [2]), and correctly fails with an error message.

Even before this change, Git didn't allow such references to be created
or updated. So I think this test failure is revealing an error in `git
p4 clone` that went undetected before this change.

Please let me know whether you agree. If so, it is realistic to fix
`git-p4` promptly? This failure is currently blocking
mh/split-under-lock, so if `git-p4` can't be fixed, then I'd have to
either disable t9801 and t9803 in this patch series, or omit the
`refname_is_safe()` check.

In the interest of backwards compatibility, I considered making `git
update-ref -d` continue to fail silently for NOOP operations with unsafe
refnames (one of the requirements being that no old_oid is specified).
But I think that would be giving the wrong signal to scripts that are
doing something that is invalid but pausible, like trying to delete the
reference `../$(basename $PWD)/refs/heads/foo`. Such scripts would be
misled into thinking the deletion was successful. And yet treating
plausibly-sensible requests differently than obviously bogus requests
seems like a path to madness.

Michael

[1] https://travis-ci.org/git/git/jobs/137333785#L2025-L2026
[2]
https://github.com/mhagger/git/blob/7a418f3a17b95746eb94cfd55f4fe0385d058777/refs.c#L121-L151

