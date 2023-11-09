Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36AA1A71B
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/7M+Fav"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70D325B
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 06:50:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso11757631fa.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699541441; x=1700146241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wiPc8u473OCZx1PG+67Aolsox1Hhxb1Md92H9E87wP8=;
        b=f/7M+FaviqiVT14fmq+6lRFcpn3weO2hH32YFRRPP/UEGracLJY+5Vaslz/XLHIySQ
         HhfvVH3+FajAufRDHnN6s3EHphc4sds8FohmNI2UnwBX0KHpbfepVV8Z5Wpd+KQyylxg
         KHnV4Ww+MBI9NlLRHdUCFxZq5cbWpm2Pfg66JrOYkQMIzj8iPpeDHzYCdwcR0i5QSQLX
         5pqQmIZRWA3/pIhQTEmtKoGZQ3kqmAldGhQOo2YQI6XCjqQ7sFY5550fyP+c09lTwoso
         a/hZMKE5Z3Fw/WCw+dTNQJ+u4DNlgtMvtqyNVIU78VzBMrWwX9BNlMUpXq2RJC1Z+09M
         IkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699541441; x=1700146241;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiPc8u473OCZx1PG+67Aolsox1Hhxb1Md92H9E87wP8=;
        b=c6jPcsDFrulcu3Uk9xHL60QxSIyCSvPs69+nkrhV7YAyXxzx/tg8OH52NSYOBeXh79
         yNlO7qgNDs56xHdi3lH0QnvLr/6bTq+UNKX+RUBYse5luIpAhDbLR9izpn3hZ2trYM2a
         M+p6Pbv7vMOPW1WgnK2cf+jvYgFiirKcH8oUDaIVj+EHy4uqDpl7TFSmLodTR5lG1+JW
         1rZKhYoCOnef7FqLnjPdN4BlkgxL8rklODAnS8oyqfIzm/DQh5piPui1yI2v6tv9j03d
         AUt4fUG65HKiX5fQfKW8jfE1cWHY38LwkNtrEKwziIkpOp2dJT74WiBcKByLBdFkTO0y
         PGpA==
X-Gm-Message-State: AOJu0Yy0bLCgjzRftGci9UcCxCxWKsOTKEMud4ikU67KpRz3uard04dT
	P4CuEzLAZPX5iimk4NSq2tI=
X-Google-Smtp-Source: AGHT+IG0WQnrVvcjCao0KboFqD59GuR+mMB7MbDz6XTZdYSbHp3dyktogGlMSrzxAkSVdkLj0j25oA==
X-Received: by 2002:a2e:1f01:0:b0:2c5:8aa7:b922 with SMTP id f1-20020a2e1f01000000b002c58aa7b922mr4269354ljf.19.1699541440896;
        Thu, 09 Nov 2023 06:50:40 -0800 (PST)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b004094c5d929asm2343230wmq.10.2023.11.09.06.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 06:50:40 -0800 (PST)
Message-ID: <08fd9919-badc-4d3a-8dc4-4813c4dec649@gmail.com>
Date: Thu, 9 Nov 2023 14:50:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: first-class conflicts?
Content-Language: en-US
To: Martin von Zweigbergk <martinvonz@google.com>, phillip.wood@dunelm.org.uk
Cc: Elijah Newren <newren@gmail.com>,
 Sandra Snan <sandra.snan@idiomdrottning.org>, git@vger.kernel.org,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
 <CABPp-BH7WBm1j-Ue9oZFjoy6sTcw5B0hz_ndDEtJqvpZF4YF=w@mail.gmail.com>
 <ba047d38-4ad1-4440-8342-3379404f430b@gmail.com>
 <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
In-Reply-To: <CAESOdVDmQ85-des6Au-LH0fkUB9BZBZho0r-5=8MkPLJVA5WQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin

On 07/11/2023 17:38, Martin von Zweigbergk wrote:
> (new attempt in plain text)

Oh, the joys of the mailing list! Thanks for your comments below and in 
your reply to Elijah, I found them really helpful to get a better 
understanding of how 'jj' handles this.

Best Wishes

Phillip

> On Tue, Nov 7, 2023 at 3:49 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> [I've cc'd Martin to see if he has anything to add about how "jj"
>> manages the issues around storing conflicts.]
>>
>> On 07/11/2023 08:16, Elijah Newren wrote:
>>> On Mon, Nov 6, 2023 at 1:26 PM Sandra Snan
>>> <sandra.snan@idiomdrottning.org> wrote:
>>>>
>>>> Is this feature from jj also a good idea for git?
>>>> https://martinvonz.github.io/jj/v0.11.0/conflicts/
>>>
>>> Martin talked about this and other features at Git Merge 2022, a
>>> little over a year ago.  I talked to him in more depth about these
>>> while there.  I personally think he has some really interesting
>>> features here, though at the time, I thought that the additional
>>> object type might be too much to ask for in a Git change, and it was
>>> an intrinsic part of the implementation back then.
>>>
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
>> transferred along with the conflicts. For a sequence of cherry-picks or
>> a rebase it is more complicated to preserve the context of the conflict.
>> Even "git merge" can create several files in addition to MERGE_HEAD
>> which are read when the conflict resolution is committed.
> 
> Good point. We actually don't store any extra data in jj. The old
> per-path conflict model was prepared for having some label associated
> with each term of the conflict but we never actually used it.
> 
> If we add such metadata, it would probably have to be something that
> makes sense even after pushing the conflict to another repo, so it
> probably shouldn't be commit ids, unless we made sure to also push
> those commits. Also note that if you `jj restore --from <commit with
> conflict>`, you can get a conflict into a commit that didn't have
> conflicts previously. Or if you already had conflicts in the
> destination commit, your root trees (the multiple root trees
> constituting the conflict) will now have conflicts that potentially
> were created by two completely unrelated operations, so you would kind
> of need different labels for different paths.
> 
> https://github.com/martinvonz/jj/issues/1176 has some more discussion
> about this.
> 
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
> Agreed. `jj git push` refuses to push commits with conflicts, because
> it's very unlikely that the remote will be able to make any sense of
> it. Our commit backend at Google does support conflicts, so users can
> check out each other's conflicted commits there (except that we
> haven't even started dogfooding yet).
> 
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
> Yes, I think it would be a very large project. Unlike jj, Git of
> course has to worry about backwards compatibility. For example, you
> would have to decide if your goal - even in the long term - is to make
> `git rebase` etc. not get interrupted due to conflicts.
