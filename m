Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED220E6
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW+6qyLw"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6C3588
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 06:45:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso12739075e9.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699541158; x=1700145958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XUh3dliQeHoYVu3mgkYJsTIS2cm6KNdg6wxNgjBxALU=;
        b=AW+6qyLwwmbyv6bvo6TBIZql9pwjzdpNmkTJRks4yjnvTx3VRulR1nL8blpz35kfN+
         iTDQLHsdS9952y1Q2IkVusbP6zMxVkQbdgPcpB3O/NekX9Z9hv1yka2Opu4TtRsZlj7q
         ZaDsXjvdk2G0highQM85m/Ms3uTPUSogw4qhN7SjQLXNTMooZ0IzC+j6/gs/wybzvHpb
         hDvjRnTOD561pZJW9ERCB84nUIzm61PPNbjuuaYrg8TOTxc9eYZ2s75hkcsg8YF/MnpY
         wKMDpjmzPuEorhFCvf6b/jMDnEtJ5WWTGBz4B2cR7p46OsUf+u5oHb/MHpPSXcD1LcMJ
         rQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699541158; x=1700145958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUh3dliQeHoYVu3mgkYJsTIS2cm6KNdg6wxNgjBxALU=;
        b=PCZgQZk/HrevElUJ7Z4ohyncR9fBc6P+xhS13pW6w76meSyQTEwx1Td/GX2ZHxCiyx
         9m9rJNLCDZBmdVWK4y/jbD6AMh/Fm64iB5UUYeW0efdN4vHWdCD+wqkAfHO9sbBjAsEu
         aJB3I+iVxK4SfoeH3SeAvE6cbpt2dHFhXSteNZP6cMUq082oXDRUoMCbu64PUIOw3HO0
         kchLNJdl7+Hgu6JlOzEScVD4jWCkheV6iDn5ab5FVLlsy/+W9xvtIm0JgNOtMHTQzizq
         c5iCowkJoYoVX/BXLexKExbw1u+ycbj6/uViPxDv2fInmrn14IRW3zIF876GnqrUMZbh
         JM6A==
X-Gm-Message-State: AOJu0Yws57xBGUml7a0N205pwym8TzxEKuZhhDXLVTyDPziujUUR1s6h
	oLsHAFoJ37/n/ixIO6xGv+w=
X-Google-Smtp-Source: AGHT+IHWzAyRH3T4kpdZJqtAwTp/C26HHClpeMSKELoHKU/fBJ8L0q+JBNZIKx6Ijf3v3plgdV0riA==
X-Received: by 2002:a05:6000:4020:b0:32f:75d2:bdba with SMTP id cp32-20020a056000402000b0032f75d2bdbamr7871170wrb.6.1699541157497;
        Thu, 09 Nov 2023 06:45:57 -0800 (PST)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c224800b0040684abb623sm2257121wmm.24.2023.11.09.06.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 06:45:57 -0800 (PST)
Message-ID: <a1cd2dba-3a74-4b41-8585-209b4a13b8c4@gmail.com>
Date: Thu, 9 Nov 2023 14:45:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: first-class conflicts?
Content-Language: en-US
To: Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org,
 Martin von Zweigbergk <martinvonz@google.com>,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
 <CABPp-BGd-W8T7EsvKYyjdi3=mfSTJ8zM-uzVsFnh1AWyV2wEzQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BGd-W8T7EsvKYyjdi3=mfSTJ8zM-uzVsFnh1AWyV2wEzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

On 08/11/2023 06:31, Elijah Newren wrote:
> Hi Phillip,
> 
> On Tue, Nov 7, 2023 at 3:49 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> [I've cc'd Martin to see if he has anything to add about how "jj"
>> manages the issues around storing conflicts.]
> 
> +1.  I'll add some other questions for him too while we're at it,
> separately in this thread.
> 
> [...]
> 
>>> Martin also gave us an update at the 2023 Git Contributors summit, and
>>> in particular noted a significant implementation change to not have
>>> per-file storage of conflicts, but rather storing at the commit level
>>> the multiple conflicting trees involved.  That model might be
>>> something we could implement in Git.  And if we did, it'd solve
>>> various issues such as people wanting to be able to stash conflicts,
>>> or wanting to be able to partially resolve conflicts and fix it up
>>> later, or be able to collaboratively resolve conflicts without having
>>> everyone have access to the same checkout.
>>
>> One thing to think about if we ever want to implement this is what other
>> data we need to store along with the conflict trees to preserve the
>> context in which the conflict was created. For example the files that
>> are read by "git commit" when it commits a conflict resolution. For a
>> single cherry-pick/revert it would probably be fairly straight forward
>> to store CHERRY_PICK_HEAD/REVERT_HEAD and add it as a parent so it gets
>> transferred along with the conflicts.
> 
> This is a great thing to think about and bring up.  However, I'm not
> sure what part of it actually needs to be preserved; in fact, it's not
> clear to me that any of it needs preserving -- especially not the
> files read by "git commit".  A commit was already created, after all.
> 
> It seems that CHERRY_PICK_HEAD/REVERT_HEAD files exist primarily to
> clue in that we are in-the-middle-of-<op>, and the conflict header
> (the "tree A + tree B - tree C" thing; whatever that's called)
> similarly provides signal that the commit still has conflicts.
> Secondarily, these files contain information about the tree we came
> from and its parent tree, which allows users to investigate the diff
> between those...but that information is also available from the
> conflict header in the recorded commit.  The CHERRY_PICK_HEAD and
> REVERT_HEAD files could also be used to access the commit message, but
> that would have been stored in the conflicted commit as well.  Are
> there any other pieces of information I'm missing?

Mainly that I'm an idiot and forgot we were actually creating a commit 
and can store the message and authorship there! More seriously I think 
being able to inspect the commit being cherry-picked (including the 
original commit message) is useful so we'd need to recreate something 
like CHERRY_PICK_HEAD when the conflict commit is checked out. 
Recreating CHERRY_PICK_HEAD is useful for "git status" as well. I think 
that means storing a little more that just the "tree A + tree B - tree 
C" thing.

>> For a sequence of cherry-picks or
>> a rebase it is more complicated to preserve the context of the conflict.
> 
> I think the big piece here is whether we also want to adopt jj's
> behavior of automatically rebasing all descendant commits when
> checking out and amending some historical commit (or at least having
> the option of doing so).  That behavior allows users to amend commits
> to resolve conflicts without figuring out complicated interactive
> rebases to fix all the descendant commits across all relevant
> branches.

That's a potentially attractive option which is fairly simple to 
implement locally as I think you can use the commit DAG to find all the 
descendants though that could be expensive if there are lots of 
branches. However, if we're going to share conflicts I think we'd need 
something like "hg evolve" - if I push a commit with conflicts and you 
base some work on it and then I resolve the conflict and push again you 
would want to your work to be rebased onto my conflict resolution. To 
handle "rebase --exec" we could store the exec command and run it when 
the  conflicts are resolved.

Also I wonder how annoying it would be in cases where I just want to 
rebase and resolve the conflicts now. At the moment "git rebase" stops 
at the conflict, with this feature I'd have to go and checkout the 
conflicted commit and fix the conflicts after the rebase had finished.

> Without that feature, I agree this might be a bit more
> difficult,

Yes, when I wrote my original message I was imagining that we'd stop at 
the first conflicting pick and store all the rebase state like some kind 
of stash on steroids so it could be continued when the conflict was 
resolved. It would be much simpler to try and avoid that.

> but with that feature, I'm having a hard time figuring out
> what context we actually need to preserve for a sequence of
> cherry-picks or a rebase.
>  
> Digging into a few briefly...
> 
> Many of the state files are about the status of the in-progress
> operation (todo-list, numbers of commits done and to do, what should
> be done with not-yet-handled commits, temporary refs corresponding to
> temporary labels that need to be deleted, rescheduling failed execs,
> dropping or keeping redundant commits, etc.), but if the operation has
> completed and new commits created (potentially with multiple files
> with conflict headers), I don't see how this information is useful
> anymore.

Agreed

> There are some special state files related to half-completed
> operations (e.g. squash commits when we haven't yet reached the final
> one in the sequence, a file to note that we want to edit a commit
> message once the user has finished resolving conflicts, whether we
> need to create a new root commit), but again, the operation has
> completed and commits have been created with appropriate parentage and
> commit messages so I don't think these are useful anymore either.

Yes, though we may want to remember which commits were squashed together 
so the user can inspect that when resolving conflicts.

> Other state files are related to things needing to be done at the end
> of the operation, like invoke the post-rewrite hook or pop the
> autostash (with knowledge of what was rewritten to what).  But the
> operation would have been completed and those things done already, so
> I don't see how this is necessary either.

Agreed

> Some state files are for controlling how commits are created (setting
> committer date to author date, gpg signing options, whether to add
> signoff), but, again, commits have already been created, and can be
> further amended as the user wants (hopefully including resolving the
> conflicts).

Agreed

> The biggest issue is perhaps that REBASE_HEAD is used in the
> implementation of `git rebase --show-current-patch`, but all
> information stored in that is still accessible -- the commit message
> is stored in the commit, the author time is stored in the commit, and
> the trees involved are in the conflict header.  The only thing missing
> is committer timestamp, which isn't relevant anyway.

The commit message may have been edited so we lose the original message 
but I'm not sure how important that is.

> The only ones I'm pausing a bit on are the strategy and
> strategy-options.  Those might be useful somehow...but I can't
> currently quite put my finger on explaining how they would be useful
> and I'm not sure they are.

I can't think of an immediate use for them. When we re-create conflicts 
we do it per-file based on the index entries created by the original 
merge so I don't think we need to know anything about the strategy or 
strategy-options.

> Am I missing anything?

exec commands? If the user runs "git rebase --exec" and there are 
conflicts then we'd need to defer running the exec commands until the 
conflicts are resolved. For something like "git rebase --exec 'make 
test'" that should be fine. I wonder if there are corner cases where the 
exec command changes HEAD though.

>> Even "git merge" can create several files in addition to MERGE_HEAD
>> which are read when the conflict resolution is committed.
> 
> That's a good one to bring up too, but I'm not sure I understand how
> these could be useful to preserve either.  Am I missing something?  My
> breakdown:
>     * MERGE_HEAD: was recorded in the commit as a second parent, so we
> already have that info
>     * MERGE_MSG: was recorded in the commit as the commit message, so
> again we already have that info
>     * MERGE_AUTOSTASH: irrelevant since the stashed stuff isn't part of
> the commit and was in fact unstashed after the
> merge-commit-with-conflicts was created
>     * MERGE_MODE: irrelevant since it's only used for reducing heads at
> time of git-commit, and git-commit has already been run
>     * MERGE_RR: I think this is irrelevant; the conflict record (tree A
> + tree B - tree C) lets us redo the merge if needed to get the list of
> conflicted files and textual conflicts found therein
> 
> So I don't see how any of the information in these files need to be
> recorded as additional auxiliary information.  However, that last item
> might depend upon the strategy and strategy-options, which currently
> is not recorded...hmm....

Yes, as we're creating some kind of commit we don't need to preserve 
those files separately.

>>> But we'd also have to be careful and think through usecases, including
>>> in the surrounding community.  People would probably want to ensure
>>> that e.g. "Protected" or "Integration" branches don't get accept
>>> fetches or pushes of conflicted commits,
>>
>> I think this is a really important point, while it can be useful to
>> share conflicts so they can be collaboratively resolved we don't want to
>> propagate them into "stable" or production branches. I wonder how 'jj'
>> handles this.
> 
> Yeah, figuring this out might be the biggest sticking point.

Indeed

>>> git status would probably
>>> need some special warnings or notices, git checkout would probably
>>> benefit from additional warnings/notices checks for those cases, git
>>> log should probably display conflicted commits differently, we'd need
>>> to add special handling for higher order conflicts (e.g. a merge with
>>> conflicts is itself involved in a merge) probably similar to what jj
>>> has done, and audit a lot of other code paths to see what would be
>>> needed.
>>
>> As you point out there is a lot more to this than just being able to
>> store the conflict data in a commit - in many ways I think that is the
>> easiest part of the solution to sharing conflicts.
> 
> Yeah, another one I just thought of is that the trees referenced in
> the conflicts would also need to affect reachability computations as
> well, to make sure they both don't get gc'ed and that they are
> transferred when appropriate.  There are lots of things that would be
> involved in implementing this idea.

Yes, it would certainly be lots of work.

Best Wishes

Phillip
