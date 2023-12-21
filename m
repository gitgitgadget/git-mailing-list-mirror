Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754985820B
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYrr66/d"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d22d3e751so12857895e9.1
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 08:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703176379; x=1703781179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9b+5My6IBjBHkvuOvcM0+1o4H+BBgnxeZVYEmkYSwtg=;
        b=BYrr66/dv80gRPm9NMWzgv4bOFcJWz96IPAWIgOniTrt51TjtOK+TR1SsosXcJov8g
         JrCSIRwW4xkwhKWnBSr+s67RLUJ+e44v1fkRxrK8kP+7ABh5f2Se7eRRK2s+ADe5k56K
         MUZmwLt21isMU78No/ds/JBpJp39I9eFOSrmGlVFZU2F8MlRyV37jhWQUrksddxDayKQ
         z+bMuugJvPxooDA9cONW4tgC0Xvy28r6l9SQVdA3RbMu7s+spZZ5VvfkGtUo8mmGT8g9
         D0AeGiUNa7AL0Zs27fsdraZE154EXk8i3EKlCSAwhJvUOG/wEhjB5iMNPq98JXxqc0E9
         de6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176379; x=1703781179;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b+5My6IBjBHkvuOvcM0+1o4H+BBgnxeZVYEmkYSwtg=;
        b=fB25MLekLJeA23cCG9SDDx4M4UEaiWlGbewiPjvOdy1ZYDV1eJbdzX50nDVBqTT61X
         Rr9Fphl1QpR8MhDniIWBdMdhoEmp38NojJyY27iBqv4lmy532dG7xjx+iha+Xn5dG5hw
         2LWHfZjk7C/PMCO2BeN9DDs1iVnh+CuNVja9fbzCkb5Z4edy0rUafKlA6htosLP76SPY
         /09zAQNqXcmUJmgHasPiFVDRtQ11pp2G9KB2oj/yQ5cXSVHrdv7lOI5zdUZpq6+8pY/l
         99rSoRt39WPkMsiHsVj64yHFPJuXg/JxbgPoSZDYeR9xaBGJ9gb++052jieaukVMR90m
         lcDA==
X-Gm-Message-State: AOJu0YyChd/c4ZvXjD88IDrNtWPseJw12j+8FHqdWsjyK82hcSUBghm4
	Ubf0CqRxhd52ftSPy/+EiVU=
X-Google-Smtp-Source: AGHT+IHqwFFfz0Qf+L1qsH5NSluNj2c7ge3v7iC/A/0g74Gt2frzx1230eX+Srxmu3Y+UDxk9SWiMQ==
X-Received: by 2002:a05:600c:354b:b0:40c:6e98:7c50 with SMTP id i11-20020a05600c354b00b0040c6e987c50mr700407wmq.165.1703176378456;
        Thu, 21 Dec 2023 08:32:58 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b004030e8ff964sm11869837wmr.34.2023.12.21.08.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 08:32:58 -0800 (PST)
Message-ID: <cfba7098-3c23-4a81-933c-b7fefdedec8a@gmail.com>
Date: Thu, 21 Dec 2023 16:32:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/1] revert/cherry-pick: add --show-current-patch option
Content-Language: en-US
To: Michael Lohmann <mial.lohmann@gmail.com>
Cc: git@vger.kernel.org, mi.al.lohmann@gmail.com, newren@gmail.com,
 phillip.wood@dunelm.org.uk
References: <42ff6b11-f991-4a6d-ad68-ca8c5a3cd735@gmail.com>
 <20231220065141.7599-1-mi.al.lohmann@gmail.com>
In-Reply-To: <20231220065141.7599-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael

On 20/12/2023 06:51, Michael Lohmann wrote:
> Hi Phillip
> 
> On 18/12/2023 16:42, Phillip Wood wrote:
>> Thanks for bringing this up I agree it can be very helpful to look at
>> the original commit when resolving cherry-pick and revert conflicts.

As an aside I find it useful is to do a kind of range-diff before 
committing the conflict resolution. Unfortunately one cannot use "git 
range-diff" because the conflict resolution is not yet committed. 
Instead I use

     diff <(git diff CHERRY_PICK_HEAD^-) <(git diff HEAD)

in practice it is helpful to pipe the diffs through sed to delete the 
"index" lines and normalize the hunk headers.

>> I'm in two minds about this change though - I wonder if it'd be better
>> to improve the documentation for CHERRY_PICK_HEAD and REVERT_HEAD and
>> tell users to run "git show CHERRY_PICK_HEAD" instead. I think the
>> main reason we have a "--show-current-patch" option for "rebase" is
>> that there are two different implementations of that command and the
>> patched-based one of them does not support REBASE_HEAD. That reasoning
>> does not apply to "cherry-pick" and "revert" and
>> "--show-current-patch" suggests a patch-based implementation which is
>> also not the case for these commands.
> 
> I appreciate the urge of limiting the interface to the minimum needed
> and not to duplicate functionality that already exists. On the other
> hand, this would
> a) grant the user the same experience, not having to wonder about
> implementation details such as different backends for rebase, but not
> for revert/cherry-pick and
> b) (I know it is more indicative of me, but:) when I am looking for a
> feature in software and I look into the respective man page I tend to
> focus first on the synopsis instead of reading the whole page (or
> sometimes I even just rely on the shell autocompletion for
> discoverability).
> 
> So yes, mentioning REVERT_HEAD and CHERRY_PICK_HEAD in the respective
> docs would technically be sufficient, but I don't think it is as
> discoverable to an average user (who does not know about the details of
> all the existing pseudo refs) as a toplevel action would be. But an
> assessment of the pros and cons is not on me to decide.

To make the psuedo refs discoverable we should certainly be mentioning 
them in the section about resolving conflicts. I haven't checked what 
the docs say at the moment but a worked example showing how to inspect 
the conflicts and the original changes would be helpful I think. That 
does assume that the user actually reads the section about resolving 
conflicts rather than just scanning the available command line options 
though.

> I have to be honest: I have troubles distinguishing a "patch" and a
> "diff", the latter of which `git show <commit>` shows according to the
> documentation ("For commits it shows the log message and textual
> diff."), though my understanding was that a patch is a diff + context
> lines, which is what `git show` actually shows... I think this is
> probably why I don't feel so strong about the potential loose usage of
> the word here.

I think for the purposes of this discussion "patch" and "diff" are 
largely interchangeable (a "patch" is essentially a "diff" with a commit 
message). Maybe I'm overthinking it but the reason I'm not very keen on 
"--show-current-patch" (in addition to the "duplicate functionality" 
argument you mention above) is that cherry-pick and revert do not work 
by applying patches (or diffs) but use a 3-way merge instead. I think 
--show-current-patch first appeared as an option to "git am" which makes 
sense as that command is all about applying patches.

I'd be interested to hear what other people think about whether it makes 
"--show-current-patch" make sense for other commands.

> Also the documentation of cherry-pick already uses the word "patch" in a
> (according to my understanding from a technical perspective) sloppy (but
> from a layman's point of view probably nevertheless helpful) way:
> 
>> The following sequence attempts to backport a patch, bails out because
>> the code the patch applies to has changed too much, and then tries
>> again, this time exercising more care about matching up context lines.
>>
>> ------------
>> $ git cherry-pick topic^             <1>
>> $ git diff                           <2>
>> $ git cherry-pick --abort            <3>
>> $ git cherry-pick -Xpatience topic^  <4>
>> ------------
>> <1> apply the change that would be shown by `git show topic^`.
>>      In this example, the patch does not apply cleanly, so
>>      information about the conflict is written to the index and
>>      working tree and no new commit results.
> 
> Should that also be rephrased?

It would certainly be more accurate for the first paragraph to say 
something like

     The following sequence tries to backport a commit. It bails out
     because the code modified by the commit has conflicting changes in
     the current branch.

The bit about exercising more care about matching up context lines is 
moot these days as the default merge strategy is "ort" which uses the 
histogram diff algorithm to do just that so commands <3> & <4> should 
not be needed.

> 
> Out of curiosity: The following from the rebase docs seems to imply that
> the apply backend will probably be removed in the future:
>> --apply
>>            Use applying strategies to rebase (calling git-am
>>            internally). This option may become a no-op in the future
>>            once the merge backend handles everything the apply one
>>            does.
> 
> But I would expect the `rebase --show-current-patch` still to be
> working. Would that only be a legacy compatibility flag and instead also
> for rebases the recommended option would be to run
> `git show REBASE_HEAD`?

The long term goal is to remove the apply backend but I don't think 
anyone is actively working on it at the moment. We'd certainly need to 
keep the --show-current-patch option for backwards compatibility.

I'll be off the list for the next couple of weeks but I'll be sure to 
catch up with this thread in the New Year

Best Wishes

Phillip
