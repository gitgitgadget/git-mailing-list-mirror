Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5AA1FEAA
	for <e@80x24.org>; Thu, 23 Jun 2016 07:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbcFWHcZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 03:32:25 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55927 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750839AbcFWHcY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 03:32:24 -0400
X-AuditID: 1207440f-5f7ff7000000093a-0a-576b90841fe9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id BE.85.02362.4809B675; Thu, 23 Jun 2016 03:32:23 -0400 (EDT)
Received: from [192.168.69.130] (p508EAB27.dip0.t-ipconnect.de [80.142.171.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5N7WHnj008210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 23 Jun 2016 03:32:19 -0400
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
 <576650E7.70107@alum.mit.edu> <xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com>
 <xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
 <8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, novalis@novalis.org
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <576B9081.3020405@alum.mit.edu>
Date:	Thu, 23 Jun 2016 09:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqNs+ITvcoPuIlEXXlW4mi4beK8wW
	jx8uYbU4Pusau8WSh6+ZHVg9HlzZwuixc9Zddo+u9iNsHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3x9f5X5oJTShVvnsxjaWD8Lt3FyMkhIWAiceXfXdYuRi4OIYGtjBJff65lhHDOM0ks
	+9vLDlIlLGAvsXjvbhYQW0QgSqJx5082iKIFTBKHr81mAkkwC2RKHP5yD6yBTUBXYlFPM1ic
	V0Bb4svpK2DNLAKqEou//QazRQVCJM6v28oKUSMocXLmE7A4p4CtxKPVvYwQM/Ukdlz/xQph
	y0tsfzuHeQIj/ywkLbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5q
	SukmRkg48+9g7Fovc4hRgINRiYdX4EhWuBBrYllxZe4hRkkOJiVRXiuH7HAhvqT8lMqMxOKM
	+KLSnNTiQ4wSHMxKIry/u4FyvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkO
	DiUJ3pP9QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoKiMLwbGJUiKB2gv+wSQ
	vcUFiblAUYjWU4zGHOvm3ljLxHFk/721TEIsefl5qVLivLIgmwRASjNK8+AWwRLZK0ZxoL+F
	eV/1AVXxAJMg3LxXQKuYgFbd7QdbVZKIkJJqYGR9u/xmxzIdRyZVnZvnbp7UsRa20D5t94Z1
	He/JldNM9PTushY2tqltEYh/1T41OiyHx25/XplSdaldnmWE98vZrCYaDQ5/v1nOzlrZGbcy
	/rDSHGWPLatmW+YfM3w3kaH8hP/2A+c2SVnzbGjQr0pvfWup0vYmPXeNFFeQStdmgZ4LLaon
	lFiKMxINtZiLihMBaSYkMT8DAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/20/2016 09:57 AM, Lars Schneider wrote:
> 
>> On 20 Jun 2016, at 01:51, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> According to [1], something in that test seems to have been trying to run
>>>>
>>>>    git update-ref -d git-p4-tmp/6
>>>>
>>>> Similarly in the other failed test.
>>>
>>> Ah, OK, that would try mucking with .git/git-p4-tmp/6 but that is
>>> not a place to have a ref.  It will not participate in reachability
>>> analysis and will end up losing the referents.
>>>
>>> Perhaps placing it under refs/git-p4-tmp would fix it (both in
>>> git-p4 and in tests)?

I have to say, I'm still confused about how the old code could have
worked at all. For quite some time, Git hasn't allowed references with
weird names like `git-p4-tmp/6` to be created, so how could there be any
references there that need to be deleted? It seems to me that one of the
following must be true:

* This feature (i.e., whatever needs to create the temporary
  references) has been broken for a long time, which would imply that
  there are no tests for it.

* The references are created in some bogus way, like writing files
  directly to the filesystem, rather than using `git update-ref`.
  This is broken and will be even more broken soon when we add
  support for different reference storage backends.

* Such references are never actually created and never actually
  needed. This would imply that the cleanup code is unnecessary.

* The temporary references are created using `git branch`, and are
  thus actually named like `refs/heads/git-p4-tmp/6`. In this case
  the deletion code wasn't cleaning them up right, but the feature
  might have otherwise worked correctly.

* I'm wrong about Git not allowing references like `git-p4-tmp/6` to
  be created, in which case I'd like to know what code path allows it
  so that I can fix it.

Any of these possibilities would mean that your proposed fix is wrong or
incomplete.

>> Oh, another thing.  If these refs are meant to be transient, they
>> are likely to be per worktree, if "git worktree" managed multiple
>> worktrees that share the same set of branches and tags are in use.
>>
>> I recall we carved out one hierarchy under refs/ as "not shared
>> across worktrees" (was that refs/worktree/ hierarchy?  I didn't
>> check but please do so when the patch actually is written), and
>> that hierarchy is the appropriate thing to use for this, I think.
> 
> Thanks for the hint. It looks like as if the "per worktree" decision
> is made in "ref.c:466" "is_per_worktree_ref":
> https://github.com/git/git/blob/3dc84b0c19932ec9947ca4936b6bfd6421ccb1b4/refs.c#L466-L470
> 
> In ce414b3 "refs/bisect" was added to a list of prefixes that are
> per worktree. I could easily add "refs/git-p4-tmp" to this list but
> I don't think that would be a good solution. I would prefer to go with 
> your suggestion and add "refs/worktree" to the prefix list and then use
> "refs/worktree/git-p4-tmp".
> 
> Later on we could move "refs/bisect" to "refs/worktree/bisect" and
> simplify the "is_per_worktree_ref" code, too.

The other part of making `refs/bisect` per-worktree is this horrible
hack here [1].

I'd like to request that the change for the p4 temprefs be made in two
steps:

1. Write references to `refs/git-p4-tmp` or whatever, without
   worrying about making them per-worktree.

2. Carve out a per-worktree namespace, bikeshed about its name and
   semantics, make sure it works correctly, then finally move the
   p4 temporary references and eventually the bisect references there.

The reason is that step 1 is low-risk, could be made quickly, and is
enough to unblock mh/split-under-lock and the other patch series that
depend on it. Step 2, on the other hand, could take quite a while, and
its implementation might benefit from changes to reference handling that
are in the pipeline (e.g., perhaps the horrible hack can be dispensed
with). Meanwhile, as far as I understand these references are transient,
so there are no backwards-compatibility considerations that make
renaming them twice more cumbersome than renaming them once.

Thanks,
Michael

[1]
https://github.com/git/git/blob/ab7797dbe95fff38d9265869ea367020046db118/refs/files-backend.c#L176-L192

