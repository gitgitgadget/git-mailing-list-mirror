Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6DC20189
	for <e@80x24.org>; Sun, 19 Jun 2016 15:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbcFSPLb (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 11:11:31 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38910 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbcFSPLa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 11:11:30 -0400
Received: by mail-wm0-f48.google.com with SMTP id r201so30092775wme.1
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 08:11:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EUrkZWvr6omHJDtkevCoDNW8accmJmlrDLVVnekQ02M=;
        b=O3q8K+o8mdwq5Z4teFSy/2NWt5C4mHTMf8uAHIy0kLgGyXp7TuDlXdP9O30qY4Mh+G
         AykVcW5B8xBpFwgOlUa/sVz4jRP2HEPsTAJ8NaYQw87enZkGMayKk5mSQNWVxgyLnmZD
         GaaXSuma47XjeX7d5r5Q6e8xu1SV31KcxUas00i+O9t7Td64un7KxPT3dflroaPYtuBD
         bLbNDYOYar2a2TdTnJHOMD0XXFCJlLWx+IhQtD3usTuOZNtkHYocJ+hlQl6ZCOiXSmp9
         JkJOLTXMb6bjZ0FLkoBegtVp6jnHzJdxwPZvHtWkhj/AWBy9cFOO9CpA9WahzGvnHnD4
         HEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EUrkZWvr6omHJDtkevCoDNW8accmJmlrDLVVnekQ02M=;
        b=d3fXneMLwMPFfEh5Brp5yLDMTN21B6hahZMhaNQ+Ka0g+riZFv7xk4Mz8UY+EcvG06
         aokho5zY8B67zI6a5x7Uzz3jSSUWsd1/wog1Ps7Lzx/17vJK2vgbOdAdq0J5MmS5fV0a
         lWCVKaSXwPpiLSCeTvwuiqHDKM+WZNAXnoq6Vfa4MZ7mqtSTejGe2zbZ3hz2XvMq1dRm
         EnayjFivW/Yk2dfWrzQP48JDEMsuMj+jrghdGfKZY7lkOpVND1hZb2zGlEGs/js3vFtE
         QFXH2rvLT6vViOxLydIR/EZMX5/frGefuPPTkiMzzS0L4G5nF9yBu+U6CXR5kIoFz30O
         QKXg==
X-Gm-Message-State: ALyK8tK/+GW7fDpMrK4sWwarmQmb0Jkkxn/CbaKSyImMlhD46f8JuyW+nTS2GBtjZLpn+g==
X-Received: by 10.194.25.135 with SMTP id c7mr10219186wjg.63.1466348654176;
        Sun, 19 Jun 2016 08:04:14 -0700 (PDT)
Received: from neu4sfhg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f196sm3591691wmg.15.2016.06.19.08.04.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jun 2016 08:04:13 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <576650E7.70107@alum.mit.edu>
Date:	Sun, 19 Jun 2016 17:04:11 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3E132EEE-CEBA-4C0D-A5C4-62F587A02225@gmail.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com> <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com> <576650E7.70107@alum.mit.edu>
To:	Michael Haggerty <mhagger@alum.mit.edu>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 19 Jun 2016, at 09:59, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
> On 06/18/2016 12:05 AM, Lars Schneider wrote:
>> 
>>> On 17 Jun 2016, at 05:20, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> ...
>>> 
>>> * mh/split-under-lock (2016-05-13) 33 commits
>>> ...
>>> 
>>> Further preparatory work on the refs API before the pluggable
>>> backend series can land.
>>> 
>>> Will merge to 'master'.
>> 
>> This topic seems break two git-p4 tests (t9801 and t9803) on next:
>> https://travis-ci.org/git/git/jobs/137333785
>> 
>> According to git bisect the commit "ref_transaction_update(): 
>> check refname_is_safe() at a minimum" (3da1f3) introduces the problem: 
>> https://s3.amazonaws.com/archive.travis-ci.org/jobs/138457628/log.txt
>> (scroll all the way down to see the bisecting)
>> 
>> - Lars
>> 
> 
> Lars,
> 
> According to [1], something in that test seems to have been trying to run
> 
>    git update-ref -d git-p4-tmp/6
> 
> Similarly in the other failed test.
> 
> Because `update-ref` doesn't do DWIM for reference names, this is *not*
> expanded to `refs/heads/git-p4-tmp/6` or something. Previously this
> command would have quietly failed to do anything. But after
> "ref_transaction_update(): check refname_is_safe() at a minimum", `git
> update-ref` notices that `git/p4/tmp/6` is not a safe refname (according
> to `refname_is_safe()` [2]), and correctly fails with an error message.

All errors seem to be related to the Git-P4 branch import. I am no expert
in that area because the branch import never worked for me (and I am puzzled
to some extend how it is supposed to work given the differences how branches
work in Git and P4).

This is the offending call:
https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/git-p4.py#L3464

This is only a cleanup call and we could make all tests work if we remove the
cleanup and also the "cleanup successful check":
https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/t9801-git-p4-branch.sh#L303
https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/t9801-git-p4-branch.sh#L355

I am a bit surprised that we do not see other errors given the fact 
that the branch name is clearly invalid:
https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/t9803-git-p4-shell-metachars.sh#L102

I see two ways to proceed:

(1) We remove the cleanup.

(2) We sanitize the branch names (e.g. by removing invalid characters).
@Michael: Is there a function to "sanitize" a given branch name already?

Option 1 is trivial and option 2 (my preference) shouldn't be too hard. 
But maybe Luke has some insights since he added the "branch with shell char" 
test in 52a4880.


> Even before this change, Git didn't allow such references to be created
> or updated. So I think this test failure is revealing an error in `git
> p4 clone` that went undetected before this change.
> 
> Please let me know whether you agree. If so, it is realistic to fix
> `git-p4` promptly? This failure is currently blocking
> mh/split-under-lock, so if `git-p4` can't be fixed, then I'd have to
> either disable t9801 and t9803 in this patch series, or omit the
> `refname_is_safe()` check.
I am looking into option 2.

> 
> In the interest of backwards compatibility, I considered making `git
> update-ref -d` continue to fail silently for NOOP operations with unsafe
> refnames (one of the requirements being that no old_oid is specified).
> But I think that would be giving the wrong signal to scripts that are
> doing something that is invalid but pausible, like trying to delete the
> reference `../$(basename $PWD)/refs/heads/foo`. Such scripts would be
> misled into thinking the deletion was successful. And yet treating
> plausibly-sensible requests differently than obviously bogus requests
> seems like a path to madness.
Agreed!

Cheers,
Lars