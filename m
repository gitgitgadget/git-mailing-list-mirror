Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1386320189
	for <e@80x24.org>; Sun, 19 Jun 2016 16:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbcFSQLM (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 12:11:12 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38536 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcFSQLK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2016 12:11:10 -0400
Received: by mail-wm0-f50.google.com with SMTP id r201so31214398wme.1
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 09:11:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UQJdVlvoJh1h+fGjXWuXI6MUVSealSNRLakOkUBJNAM=;
        b=nMlxo4mlt2jT+YaiF3v2oV7ht9BiDppfPrM17Yuo8WU+Yontm+IQC/JN8WeyAZUMdN
         5NHniHL6DoQ6lYHAq6ywQm7zLb3ImnuyNrjlDHaZL9Hg/+7R0Mv6BQWsM99LcVMR3Bs+
         4dRMNZJ8mqc/Y9KF7ueVDHeSywTI444iSJJ/wubMyWL80u+HrwaXVid+Zs0j+1/osl1a
         Y6s5a+2J/XUQxZHQ0iCZWA3N/uivJauIJCuhlch6Eh8YeQJWFvJ/rflL/PGSc0BLjCpe
         wfvkJ3TD2MheSXrf57iBqvGbipx4390JfEJUq1qERF312lJbdIhGkkbC5akKmPKW1Bqr
         T91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UQJdVlvoJh1h+fGjXWuXI6MUVSealSNRLakOkUBJNAM=;
        b=BcLuN5io+2oL3RMGJVA42aaBs9Gmhx7fS9hpJaCZpUVh5PK4cq30pfiR9wycu+zckq
         g55FbEG/s2YJwJBuNYVgpwFVstZmmOEL0VYZ21qmaRGeNVpXtUM1QEdRMt+IKJPronCK
         9V0YfzEh2OTrtV8uzO0Jb+RCvH8mTRj813LnYAGB7Iz2b89bdgrM5+FwHBRkjIvDBEmc
         sIUckOCuG1H54TD3xQyoOjZHRs46RzDx5TG6vsXTKE+LNvbXP/L+wuf9Y7sx3SYF/gfE
         M3S906TB0AXIQJ/qYqAxyrJNLoUmYQX98YuqfZjoMTxJBj4BHTsv7qeRnZesO8EWz+mb
         JWiQ==
X-Gm-Message-State: ALyK8tLVpygtfMWfplJ5B07wNv4cnB94OmVatGpjsVhLWmuu7fYkpPzk2uzyDk8qqzVfUA==
X-Received: by 10.28.218.10 with SMTP id r10mr6911689wmg.18.1466352666189;
        Sun, 19 Jun 2016 09:11:06 -0700 (PDT)
Received: from neu4sfhg12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d137sm9149860wmd.12.2016.06.19.09.11.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jun 2016 09:11:05 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <3E132EEE-CEBA-4C0D-A5C4-62F587A02225@gmail.com>
Date:	Sun, 19 Jun 2016 18:11:03 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BC5163B8-7CF2-4106-9FBE-8CCD096252A2@gmail.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com> <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com> <576650E7.70107@alum.mit.edu> <3E132EEE-CEBA-4C0D-A5C4-62F587A02225@gmail.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 19 Jun 2016, at 17:04, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 19 Jun 2016, at 09:59, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> 
>> On 06/18/2016 12:05 AM, Lars Schneider wrote:
>>> 
>>>> On 17 Jun 2016, at 05:20, Junio C Hamano <gitster@pobox.com> wrote:
>>>> 
>>>> ...
>>>> 
>>>> * mh/split-under-lock (2016-05-13) 33 commits
>>>> ...
>>>> 
>>>> Further preparatory work on the refs API before the pluggable
>>>> backend series can land.
>>>> 
>>>> Will merge to 'master'.
>>> 
>>> This topic seems break two git-p4 tests (t9801 and t9803) on next:
>>> https://travis-ci.org/git/git/jobs/137333785
>>> 
>>> According to git bisect the commit "ref_transaction_update(): 
>>> check refname_is_safe() at a minimum" (3da1f3) introduces the problem: 
>>> https://s3.amazonaws.com/archive.travis-ci.org/jobs/138457628/log.txt
>>> (scroll all the way down to see the bisecting)
>>> 
>>> - Lars
>>> 
>> 
>> Lars,
>> 
>> According to [1], something in that test seems to have been trying to run
>> 
>>   git update-ref -d git-p4-tmp/6
>> 
>> Similarly in the other failed test.
>> 
>> Because `update-ref` doesn't do DWIM for reference names, this is *not*
>> expanded to `refs/heads/git-p4-tmp/6` or something. Previously this
>> command would have quietly failed to do anything. But after
>> "ref_transaction_update(): check refname_is_safe() at a minimum", `git
>> update-ref` notices that `git/p4/tmp/6` is not a safe refname (according
>> to `refname_is_safe()` [2]), and correctly fails with an error message.
> 
> All errors seem to be related to the Git-P4 branch import. I am no expert
> in that area because the branch import never worked for me (and I am puzzled
> to some extend how it is supposed to work given the differences how branches
> work in Git and P4).
> 
> This is the offending call:
> https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/git-p4.py#L3464
> 
> This is only a cleanup call and we could make all tests work if we remove the
> cleanup and also the "cleanup successful check":
> https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/t9801-git-p4-branch.sh#L303
> https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/t9801-git-p4-branch.sh#L355
> 
> I am a bit surprised that we do not see other errors given the fact 
> that the branch name is clearly invalid:
> https://github.com/git/git/blob/05219a1276341e72d8082d76b7f5ed394b7437a4/t/t9803-git-p4-shell-metachars.sh#L102
> 
> I see two ways to proceed:
> 
> (1) We remove the cleanup.
> 
> (2) We sanitize the branch names (e.g. by removing invalid characters).
> @Michael: Is there a function to "sanitize" a given branch name already?
> 
> Option 1 is trivial and option 2 (my preference) shouldn't be too hard. 
> But maybe Luke has some insights since he added the "branch with shell char" 
> test in 52a4880.
> 
> 
>> Even before this change, Git didn't allow such references to be created
>> or updated. So I think this test failure is revealing an error in `git
>> p4 clone` that went undetected before this change.
>> 
>> Please let me know whether you agree. If so, it is realistic to fix
>> `git-p4` promptly? This failure is currently blocking
>> mh/split-under-lock, so if `git-p4` can't be fixed, then I'd have to
>> either disable t9801 and t9803 in this patch series, or omit the
>> `refname_is_safe()` check.
> I am looking into option 2.

After looking more into it I realized that the character "\$" in the branch 
name is not even the problem. The git-p4 temp refs are just not located
under refs/heads.

This seems to fix the issue:

--- a/git-p4.py
+++ b/git-p4.py
@@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
         self.useClientSpec_from_options = False
         self.clientSpecDirs = None
         self.tempBranches = []
-        self.tempBranchLocation = "git-p4-tmp"
+        self.tempBranchLocation = "refs/heads/git-p4-tmp"
         self.largeFileSystem = None
 
         if gitConfig('git-p4.largeFileSystem'):
-- 


@Luke: Would that be an acceptable solution?

Thanks,
Lars


> 
>> 
>> In the interest of backwards compatibility, I considered making `git
>> update-ref -d` continue to fail silently for NOOP operations with unsafe
>> refnames (one of the requirements being that no old_oid is specified).
>> But I think that would be giving the wrong signal to scripts that are
>> doing something that is invalid but pausible, like trying to delete the
>> reference `../$(basename $PWD)/refs/heads/foo`. Such scripts would be
>> misled into thinking the deletion was successful. And yet treating
>> plausibly-sensible requests differently than obviously bogus requests
>> seems like a path to madness.
> Agreed!
> 
> Cheers,
> Lars

