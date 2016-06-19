Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE67F1FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 08:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbcFSIPa (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 04:15:30 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48931 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386AbcFSIP0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 04:15:26 -0400
X-AuditID: 1207440e-f07ff700000008c5-fc-5766549904ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 7E.5B.02245.99456675; Sun, 19 Jun 2016 04:15:21 -0400 (EDT)
Received: from [192.168.69.130] (p4FEEA82D.dip0.t-ipconnect.de [79.238.168.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5J8FJmL006211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 19 Jun 2016 04:15:20 -0400
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Junio C Hamano <gitster@pobox.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <5764CBA8.5070303@alum.mit.edu>
 <xmqqziqixsti.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <57665497.3060100@alum.mit.edu>
Date:	Sun, 19 Jun 2016 10:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqziqixsti.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1J0ZkhZu0PGdz6LrSjeTRUPvFWYH
	Jo+Ll5Q9Pm+SC2CK4rZJSiwpC85Mz9O3S+DO6Di6lqXguWDFhgXbmRsY5/F1MXJySAiYSPzY
	NZWli5GLQ0hgK6PE5b/TmSGc80wS+5ZMZQepEhawl1i8dzcLiC0ioCYxse0QVEcvo8TC+7/B
	EswC4hLr5p4Ha2AT0JVY1NPMBGLzCmhLvDmwBKyGRUBVYuPjpWwgtqhAiMT5dVtZIWoEJU7O
	fAJWwylgLTHh7w92iJl6Ejuu/2KFsOUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3
	MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkJPl2MLavlznEKMDBqMTDu2JHargQa2JZcWXu
	IUZJDiYlUd493UAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrx1wWnhQrwpiZVVqUX5MClpDhYl
	cV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd7JII2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmp
	RYmlJRnxoKiMLwbGJUiKB2jvPrC9xQWJuUBRiNZTjLoc6+beWMskxJKXn5cqJc47AaRIAKQo
	ozQPbgUsAb1iFAf6WJh3L0gVDzB5wU16BbSECWiJ5rxkkCUliQgpqQZG3sZXj25E/XLOiely
	+1a1dvqfya9ucDSzfZ6hZl23bOKpqfMW5eW4sJv/uWzvKm+g+mNp+Zv7N9a9quYXaHSr8npm
	+uTPte456dkng/29L7xSYGuL09p5/kXjiUlawU9v5y+b3asazHfyUS1365Ebmc/URe6dzmeI
	5sqqFn2iXlc4c+dan9DjSizFGYmGWsxFxYkAwrz6PBsDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/18/2016 08:20 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 06/17/2016 05:20 AM, Junio C Hamano wrote:
>>> [...]
>>> * mh/ref-iterators (2016-06-03) 13 commits
>>>   (merged to 'next' on 2016-06-06 at c8e79dc)
>>>  + ...
>>>  (this branch is used by mh/ref-store; uses mh/split-under-lock; is tangled with mh/update-ref-errors.)
>>>
>>>  The API to iterate over all the refs (i.e. for_each_ref(), etc.)
>>>  has been revamped.
>>>
>>>  Will merge to 'master'.
>>
>> It would be preferable (though not critical) to use the promised v3,
>> which I just sent [1]. This includes some minor improvements, described
>> here [2]. This is also available from my GitHub fork [3] as branch
>> "ref-iterators".
>>
>>> * mh/split-under-lock (2016-05-13) 33 commits
>>>   (merged to 'next' on 2016-06-03 at 2e71330)
>>>  + lock_ref_sha1_basic(): only handle REF_NODEREF mode
>>>  + ...
>>>  Will merge to 'master'.
>>
>> Please make sure to pick up the important bugfix discussed here [4],
>> which is integrated into branch "split-under-lock" on my GitHub fork [3].
> 
> Good timing. I was planning to kick split-under-lock and any of its
> dependents temporarily out of 'next', so that fixes can choose not
> to be incremental, and dependent topics can be rebased on top of the
> fixed fondation.  Even if we do incremental, [4] is not sufficient
> material for me to write a log message for.
> 
> So people who reviewed what has been in 'next' can revisit [4] and
> give review comments, while I could just pick up the history
> mentioned there, i.e.
> 
>     git checkout pu
>     git pull git://github.com/mhagger/git +split-under-lock:mh/split-under-lock
> 
> and we can start from there?

Sure. The branches in my GitHub fork already include all of the
improvements and fixes that I know of, and the only outstanding issue is
the one that Lars mentioned in this thread (which I believe to be a
problem in git-p4).

BTW, there are still no conflicts between these branches
(split-under-lock, update-ref-errors, ref-iterators, and ref-store) and
current master. Therefore, I don't see a need to rebase them onto
master. But if you would prefer that I do so, just let me know.

Michael

