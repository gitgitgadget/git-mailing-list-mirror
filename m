Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C861F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbeKAFx2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:53:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47102 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbeKAFx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:53:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id q1so9316868qkf.13
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mFiuqX+q0LjciJzYfrlSycW71Pt8AzbnlLDE0I5j9fM=;
        b=Hgdgr0JdPMNZdk4vouDjp/bqvbqTn3K11aXttVjZOtViUFhnUBi/1a2VLUsOlOb456
         1FS0DncDDrTsobDl3dVDqb2CgKUtpnqYHKJedG4T1IbC8yctKen3MFIgdGn5sFd4ESXC
         U18ZosqUDOipKc4zZeNyVo7bI3v2Y6b9+UZQUqOe+tSUW8OvhaXCnMrPfrt+Bcz36NP0
         HRboJTYma1nAciOhrnLRbwk4tHGFEP7dIpcVhIHsC3QmJCMH0hwlzl0M7z6cxiVAkC93
         SypQ6jbe6bzeJ4Nd4sDze+cjhzJMH/QLwjspNVZb9AhYnpMAyuZFOxng1Gu7guUBM9Z0
         7mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFiuqX+q0LjciJzYfrlSycW71Pt8AzbnlLDE0I5j9fM=;
        b=sUzgFS5D99ghvvh3u5TGrWmB4igd+We9ehFQDLA8RGCByXRFFGZhmNzMxWtjKbl5gR
         oEKr6ljHQAbvlzdWNAgRJnv0j5J29Sy1VITrrSBxrqpsaHKERXF/GCfxDxVrpX1WgEp3
         42vZLHF0PxEm05OrBxkdGJYngPvI77oIdM9266tkNWr2PldI+imNIuBmBrCO+m2nbEn/
         IyyBTOy/kWdTb5rUzJKdCY44f9Un5U2PJKqN0Co0xshRsVuMuSsRpYMQrwroVaD2yLyr
         AdK9sOqIFGAV9yCg0hKTYiXcnwLoHWY2EBYORTmCEl9HoGfgHqd48+RjLRdl0aEBri2j
         SJdA==
X-Gm-Message-State: AGRZ1gJSbKU9/xy2RSFdODOhl4zmT5sbIASalhMcFgjLwzCWrSbRc/Xj
        AtDK+JQZB0CMwlaeQBOhukI=
X-Google-Smtp-Source: AJdET5fIklk5ejQRhNDDMa76ijOfPnxJD+tfkUBP4sWEf/vqg6/NmM3bTyZPKCEz1AA/6JY4Kf9QIw==
X-Received: by 2002:ae9:c303:: with SMTP id n3-v6mr4038065qkg.163.1541019223752;
        Wed, 31 Oct 2018 13:53:43 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z66-v6sm9355762qkc.30.2018.10.31.13.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:53:42 -0700 (PDT)
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
Date:   Wed, 31 Oct 2018 16:53:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/31/2018 3:11 PM, Duy Nguyen wrote:
> not really a review, just  a couple quick notes..
> 

Perfect!  As an RFC, I'm more looking for high level thoughts/notes than 
a style/syntax code review.

> On Tue, Oct 30, 2018 at 9:40 PM Ben Peart <peartben@gmail.com> wrote:
>>
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> On index load, clear/set the skip worktree bits based on the virtual
>> file system data. Use virtual file system data to update skip-worktree
>> bit in unpack-trees. Use virtual file system data to exclude files and
>> folders not explicitly requested.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>
>> We have taken several steps to make git perform well on very large repos.
>> Some of those steps include: improving underlying algorithms, utilizing
>> multi-threading where possible, and simplifying the behavior of some commands.
>> These changes typically benefit all git repos to varying degrees.  While
>> these optimizations all help, they are insufficient to provide adequate
>> performance on the very large repos we often work with.
>>
>> To make git perform well on the very largest repos, we had to make more
>> significant changes.  The biggest performance win by far is the work we have
>> done to make git operations O(modified) instead of O(size of repo).  This
>> takes advantage of the fact that the number of files a developer has modified
>> is a tiny fraction of the overall repo size.
>>
>> We accomplished this by utilizing the existing internal logic for the skip
>> worktree bit and excludes to tell git to ignore all files and folders other
>> than those that have been modified.  This logic is driven by an external
>> process that monitors writes to the repo and communicates the list of files
>> and folders with changes to git via the virtual file system hook in this patch.
>>
>> The external process maintains a list of files and folders that have been
>> modified.  When git runs, it requests the list of files and folders that
>> have been modified via the virtual file system hook.  Git then sets/clears
>> the skip-worktree bit on the cache entries and builds a hashmap of the
>> modified files/folders that is used by the excludes logic to avoid scanning
>> the entire repo looking for changes and untracked files.
>>
>> With this system, we have been able to make local git command performance on
>> extremely large repos (millions of files, 1/2 million folders) entirely
>> manageable (30 second checkout, 3.5 seconds status, 4 second add, 7 second
>> commit, etc).
>>
>> Our desire is to eliminate all custom patches in our fork of git.  To that
>> end, I'm submitting this as an RFC to see how much interest there is and how
>> much willingness to take this type of change into git.
> 
> Most of these paragraphs (perhaps except the last one) should be part
> of the commit message. You describe briefly what the patch does but
> it's even more important to say why you want to do it.
> 
>> +core.virtualFilesystem::
>> +       If set, the value of this variable is used as a command which
>> +       will identify all files and directories that are present in
>> +       the working directory.  Git will only track and update files
>> +       listed in the virtual file system.  Using the virtual file system
>> +       will supersede the sparse-checkout settings which will be ignored.
>> +       See the "virtual file system" section of linkgit:githooks[6].
> 
> It sounds like "virtual file system" is just one of the use cases for
> this feature, which is more about a dynamic source of sparse-checkout
> bits. Perhaps name the config key with something along sparse checkout
> instead of naming it after a use case.

It's more than a dynamic sparse-checkout because the same list is also 
used to exclude any file/folder not listed.  That means any file not 
listed won't ever be updated by git (like in 'checkout' for example) so 
'stale' files could be left in the working directory.  It also means git 
won't find new/untracked files unless they are specifically added to the 
list.

> 
> This is a hook. I notice we start to avoid adding real hooks and just
> add config keys instead. Eventually we should have config-based hooks,
> but if we're going to add more like this, I think these should be in a
> separate section, hook.virtualFileSystem or something.
> 

That is a great idea.  I don't personally like specifying the hook as 
the 'flag' for whether a feature should be used.  I'd rather have it be 
a bool (enable the feature? true/false) and 1) either have the hook name 
hard coded (like most existing hooks) or 2) as you suggest add a 
consistent way to have config-based hooks.  Config based hooks could 
also help provide a consistent way to configure them using GIT_TEST_* 
environment variables for testing.

> I don't think the superseding makes sense. There's no reason this
> could not be used in combination with $GIT_DIR/info/sparse-checkout.
> If you don't want both, disable the other.
> 
> One last note. Since this is related to filesystem. Shouldn't it be
> part of fsmonitor (the protocol, not the implementation)? Then
> watchman user could use it to.
> 

To get this to work properly takes a lot more logic than exists in 
fsmonitor/watchman.  The challenge is that 1) fsmonitor/watchman is 
focused on "what has changed since <time>" and 2) doesn't currently 
impact the excludes logic.

If you attempted to use this with watchman there is a chicken and egg 
problem.  The initial git checkout wouldn't write out _any_ files to the 
working directory as none have been modified.  There would be no way to 
get them populated where they could even get modified to get added to 
the list.  Not very useful. :-)

This works with VFS for Git because it provides a virtual projection and 
will dynamically write out the contents of the file in the working 
directory as they are read.  It makes it appear that they are there and 
will fetch the actual contents on demand transparently.  If the user 
ends up modifying the file, it will get added to the virtual projection 
list so that git will start to pay attention to and update that file.

If the files are only read (and not written) by the user, the version on 
disk must be maintained by the VFS for Git daemon because git is 
completely unaware of them.  That means the daemon must detect when the 
git commit changes and remove the contents of all the files that were 
read but not written and start projecting the files from new commit.

In short, this is only one small piece of what is necessary to get a 
fully virtualized git repo.  It's an important piece but only one of the 
many pieces.  My reason for submitting this RFC is to start the 
discussion about how interested the community is in enabling repo 
virtualization in the mainline version of git.
