Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A322BB00
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvUx/jWv"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3377d45c178so3738127f8f.2
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705314950; x=1705919750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=10zKBgClQZCfBKial008kEJ3ydeEi42YtXUuWbepMv4=;
        b=gvUx/jWvRRnm62Aotm7rn3VSBT5ugta/6BANqAXwipL17vGW4H+ZIBo2b//qDM5yhU
         syH67gutiaPGwADBwY35FpJzChEHKEfW3dT5QfPGOaDxfmnK5jtmsdW7dUMb/1qmXBBP
         BKTe0TSL+1nBdLFJre2/yLl83bcI/qA1ZvPg5gF4dhG0tAj9F9aunBVH10CUtwJbN/9R
         yfRxnxhl+ARoneozblwi8WMK0CeIIFX6bYdZlEAqlya44d7G7xE1gXpBt7a2mZdK+pqe
         DybhYwpkESiuNuzq1sbzbZpxpOlkIsFX1UjFhYgr8Y/3Y3JGFnvSGdeWjE31tOUTueZf
         Sfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314950; x=1705919750;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10zKBgClQZCfBKial008kEJ3ydeEi42YtXUuWbepMv4=;
        b=Jky5TJE6AGPn72dnzkam1NBAooXM6/UGszxjKbSKNtU9c9kiJbMjLY817YOx00JYEs
         ke23WDFiTaMfATnbjA6NwQQeyFs/JHt1I2i0Gv5FD1CiUAnr0gLDhdoQS3qanh5eChte
         iqOQcAdBKAId3ZjR+FxtAZ/QZqIz/i1XuCL45v3vMGSNsaq3PQop1kfcPELlT2zARHIG
         0rzVThKVtNNPhW5j/L07haDeIkv3HDLn+vcI3lAXI/F91k7FxDRapv7GKo41zn6YDctB
         uTUDQyQC82J9bSnJY5xOHOMt8Q76eqi504GtKYkVnLW1KRk8OO4eV3Ga6Lkiq8TUX64l
         WS0w==
X-Gm-Message-State: AOJu0YztbtdgsNwzihkO8xXVVF6mtCBHVG1Od6q4YUNK9bPHE/p+ri9S
	Jy+1mkU0eW09EYAAOAQ3rCeeQlhbW3Q=
X-Google-Smtp-Source: AGHT+IFkkPmhMO0Jk9Cuyx3qemrb9GquE0eG3EIjp1+7M3YGj9jkGiHgVCGhbtW/z8fFcZlAfW+nMw==
X-Received: by 2002:a05:6000:1a54:b0:336:f339:cff9 with SMTP id t20-20020a0560001a5400b00336f339cff9mr2630603wry.31.1705314949834;
        Mon, 15 Jan 2024 02:35:49 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe948000000b00336710ddea0sm11546063wrn.59.2024.01.15.02.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 02:35:49 -0800 (PST)
Message-ID: <56522074-47b4-44d7-91da-8cf1149e85c7@gmail.com>
Date: Mon, 15 Jan 2024 10:35:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] clone: support cloning of filtered bundles
Content-Language: en-US
To: Nikolay Edigaryev <edigaryev@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Nikolay Edigaryev via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
 <24b82309-34e9-49a0-983b-7e94dad3d06b@gmail.com>
 <CAFX5hXTCPt-rDrWZ-RN8S84o_FooY3Ck2H1kMYdHQGzuetPBSw@mail.gmail.com>
 <CAFX5hXQ291gR4831dtRTdvtffWefCNCFp13ADvOkU7s3SVPczQ@mail.gmail.com>
In-Reply-To: <CAFX5hXQ291gR4831dtRTdvtffWefCNCFp13ADvOkU7s3SVPczQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nikolay

On 14/01/2024 21:26, Nikolay Edigaryev wrote:
>> Note that currently, when you clone a normal non-filtered bundle with a
>> '--filter' argument specified, no filtering will take place and no error
>> will be thrown. "promisor = true" and "partialclonefilter = ..." options
>> will be set in the repo config, but no .promisor file will be created.
>> This is even more confusing IMO, but that's how it currently on
>> Git 2.43.0.
> 
> I was wrong about this one: the .promisor pack file actually gets created.
> 
> And the filtering is not being done because the "uploadpack.allowFilter"
> global option is not enabled by default.

That makes sense - if you try to make a partial clone from a remote that 
does not support object filtering we fallback to a full clone and print 
the warning you mention below.

> Unfortunately the only way to figure this out is to run Git with
> GIT_TRACE=2, which shows:

That seems strange, you should see the warning without having to set 
GIT_TRACE. I've certainly seen the warning in the past when trying to 
create a partial clone from a remote did not support them without me 
setting any special environment variables.

Best Wishes

Phillip

> warning: filtering not recognized by server, ignoring
> 
> So please feel free to skip this part from the consideration.
> 
> 
> On Sun, Jan 14, 2024 at 11:39 PM Nikolay Edigaryev <edigaryev@gmail.com> wrote:
>>
>> Hello Phillip,
>>
>>> As I understand it if you're cloning from a bundle file then then there
>>> is no remote so how can we set a remote-specific config?
>>
>> There is a remote, for more details see df61c88979 (clone: also
>> configure url for bare clones, 2010-03-29), which has the following
>> code:
>>
>> strbuf_addf(&key, "remote.%s.url", remote_name);
>> git_config_set(key.buf, repo);
>> strbuf_reset(&key);
>>
>> You can verify this by creating a bundle on Git 2.43.0 with "git create
>> bundle bundle.bundle --all" and then cloning it with "git clone
>> --bare /path/to/bundle.bundle", in my case the following repo-wide
>> configuration file was created:
>>
>> [core]
>> repositoryformatversion = 0
>> filemode = true
>> bare = true
>> ignorecase = true
>> precomposeunicode = true
>> [remote "origin"]
>> url = /Users/edi/src/cirrus-cli/cli.bundle
>>
>>> I'm surprised that the proposed change does not require the user to pass
>>> "--filter" to "git clone" as I expected that we'd want to check that the
>>> filter on the command line was compatible with the filter used to create
>>> the bundle. Allowing "git clone" to create a partial clone without the
>>> user asking for it by passing the "--filter" option feels like is going
>>> to end up confusing users.
>>
>> Note that currently, when you clone a normal non-filtered bundle with a
>> '--filter' argument specified, no filtering will take place and no error
>> will be thrown. "promisor = true" and "partialclonefilter = ..." options
>> will be set in the repo config, but no .promisor file will be created.
>> This is even more confusing IMO, but that's how it currently on
>> Git 2.43.0.
>>
>> You have a good point, but I feel like completely preventing cloning of
>> filtered bundles and requiring a '--filter' argument is very taxing. If
>> you've already specified a '--filter' when creating a bundle (and thus
>> your intent to use partially cloned data), why do it multiple times?
>>
>> What I propose as an alternative here is to act based on the user's
>> intent when cloning:
>>
>> * when the user specifies no '--filter' argument, do nothing special,
>>     allow cloning both types of bundles: normal and filtered (with the
>>     logic from this patch)
>>
>> * when the user does specify a '--filter' argument, either:
>>    * throw an error explaining that filtering of filtered bundles is not
>>      supported
>>    * or compare the user's filter specification and the one that is
>>      in the bundle and only throw an error if they mismatch
>>
>> Let me know what you think about this (and perhaps you have a more
>> concrete example in mind where this will have negative consequences)
>> and I'll be happy to do a next iteration.
>>
>>
>> On Sun, Jan 14, 2024 at 10:00 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> Hi Nikolay
>>>
>>> On 14/01/2024 11:16, Nikolay Edigaryev via GitGitGadget wrote:
>>>> From: Nikolay Edigaryev <edigaryev@gmail.com>
>>>>
>>>> f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced an
>>>> incredibly useful ability to create filtered bundles, which advances
>>>> the partial clone/promisor support in Git and allows for archiving
>>>> large repositories to object storages like S3 in bundles that are:
>>>>
>>>> * easy to manage
>>>>     * bundle is just a single file, it's easier to guarantee atomic
>>>>       replacements in object storages like S3 and they are faster to
>>>>       fetch than a bare repository since there's only a single GET
>>>>       request involved
>>>> * incredibly tiny
>>>>     * no indexes (which may be more than 10 MB for some repositories)
>>>>       and other fluff, compared to cloning a bare repository
>>>>     * bundle can be filtered to only contain the tips of refs neccessary
>>>>       for e.g. code-analysis purposes
>>>>
>>>> However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
>>>> bundle, 2022-03-09) the cloning of such bundles was disabled, with a
>>>> note that this behavior is not desired, and it the long-term this
>>>> should be possible.
>>>>
>>>> The commit above states that it's not possible to have this at the
>>>> moment due to lack of remote and a repository-global config that
>>>> specifies an object filter, yet it's unclear why a remote-specific
>>>> config can't be used instead, which is what this change does.
>>>
>>> As I understand it if you're cloning from a bundle file then then there
>>> is no remote so how can we set a remote-specific config?
>>>
>>> I'm surprised that the proposed change does not require the user to pass
>>> "--filter" to "git clone" as I expected that we'd want to check that the
>>> filter on the command line was compatible with the filter used to create
>>> the bundle. Allowing "git clone" to create a partial clone without the
>>> user asking for it by passing the "--filter" option feels like is going
>>> to end up confusing users.
>>>
>>>> +test_expect_success 'cloning from filtered bundle works' '
>>>> +     git bundle create partial.bdl --all --filter=blob:none &&
>>>> +     git clone --bare partial.bdl partial 2>err
>>>
>>> The redirection hides any error message which will make debugging test
>>> failures harder. It would be nice to see this test check any config set
>>> when cloning and that git commands can run successfully in the repository.
>>>
>>> Best Wishes
>>>
>>> Phillip
