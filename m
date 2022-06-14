Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B4BC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 12:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiFNMeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiFNMed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 08:34:33 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF64BFEF
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 05:31:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t21so5914545qtw.11
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zEhRGwcvrym4HNWJRlutVKOLdisMtPfp0ygsJu7xucg=;
        b=H9WiJuwIwV2bM/UMxtzGn2ejfCpCiOg4qf+7gsCcrODjDbo/zTEP0GxLUAGFw0P/bR
         5LG0JEvxBnoIrjt4FjQ3gy/JpGuX6Ef6PWC5vgB+TW0jWtNWbA6lMOOKOAF7UiRv4tAN
         Ng20LgHYpKYwH1lp30E2Bb/cMwuGP73i7jO8+S8fNhYsL1lVyBIpsJ1JvxNbDeOsi33n
         pWly6ky4F+PdDZTlqc6wWju5mzjfVSayxYVL/TFsRT8tDKFydWZRJyX2E+Uc20zIlnza
         pDAV0HYDmAGlAYxbwyNeqFtcg2UEQIqDg+J1hlbt854XmkWCNASkavW15hszTpTq2T1y
         ipKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zEhRGwcvrym4HNWJRlutVKOLdisMtPfp0ygsJu7xucg=;
        b=soj1srAVD+fOO9uqZqy4oevg4NQ1UXoz/+piD29J6z3BMHKVLgxX1aHAzm8ocyyToZ
         06XRB2iEJQ0cTGWNVG60n+Ti3ZCpRzbc41+xnjehbo+OrK0OvzbEaxxtIdNnHdwNRIxu
         jTtnQkS0LTXJq2MARN6VaakX+sDZ86//w/R+v9TkVT+ZuWz85Dc0ZxJHEhQKO0nE6qUY
         aAUeZ+ty+M+2ylcpUW70NObp4bDa4eUIlwGC83jT3wF/OMLb5szMXQ7fFrN2UNuYcekf
         DVBic/k9Zh7cibhXaRpRkkUVd9VfEpJo0KLobYGP5eZKGZG1ssMg0/ri5jpDeoRuyhRN
         0SpA==
X-Gm-Message-State: AOAM532YKqKWq81KbhwK0+Dh3JJDq2ToyLF8g17V3rZL/Mk19yQpkIJw
        R5IeUEEO8By2UE3ojO6PCa4YnDKEOKk=
X-Google-Smtp-Source: ABdhPJyBf57AIKRMvDOW93i6+EF4dFhNi2mnDQ6WNx990b85pxFa85c6QH0pjnoK+ziKNa65tvl1tQ==
X-Received: by 2002:ac8:7fd0:0:b0:305:11cd:f467 with SMTP id b16-20020ac87fd0000000b0030511cdf467mr3705160qtk.11.1655209874594;
        Tue, 14 Jun 2022 05:31:14 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i2-20020ac860c2000000b00304e688189fsm6981012qtm.37.2022.06.14.05.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 05:31:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] diff-format.txt: correct misleading wording
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
 <5ff3a52556716e92f7207c75660cec2eb3da2587.1655123383.git.gitgitgadget@gmail.com>
 <xmqqtu8o5r48.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3ef61018-60fa-31a5-b5e6-a1feab3b7cf2@gmail.com>
Date:   Tue, 14 Jun 2022 08:31:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqtu8o5r48.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2022-06-13 à 14:56, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Near the end of the "Raw output format" section, an example shows the
>> output of 'git diff-files' for a tracked file modified on disk but not
>> yet added to the index. However the wording is:
>>
>>     <sha1> is shown as all 0's if a file is new on the filesystem
>>     and it is out of sync with the index.
>>
>> which is confusing since it can be understood to mean that 'file' is a
>> new, yet untracked file, in which case 'git diff-files' does not care
>> about it at all.
> 
> I do not think such an understanding is sensible, as "untracked
> file" cannot be "out of sync with the index", because even its stale
> version wouldn't be in the index if it is untracked.
> 
> But I agree that not all people are sensible, and it would be nicer
> if the documentation helped them, too ;-)

Well, call me not sensible then ;) When I read that, I had trouble understanding
what was meant precisely because I had what you wrote in mind.

> 
>> When this example was introduced all the way back in c64b9b8860
>> (Reference documentation for the core git commands., 2005-05-05), 'old'
>> and 'new' referred to the two entities being compared, depending on the
>> command being used (diff-index, diff-tree or diff-files - which at the
>> time were diff-cache, diff-tree and show-diff). The wording used at the
>> time was:
>>
>>     <new-sha1> is shown as all 0's if new is a file on the
>>     filesystem and it is out of sync with the cache.
> 
> Yeah, I remember this version of wording.
> 
>> Rework the introductory sentence of the example to instead refer to
>> 'sha1 for "dst"', which is what the text description above it uses, and
>> fix the wording so that we do not mention a "new file".
> 
> That's good.  We may need to upgrade them to 'object name' to wean
> ourselves away from SHA-1 but that should be a separate topic.
> 
>> While at it, also tweak the wording used in the description of the raw
>> format to explicitely state that all 0's are used for the destination
>> hash if the working tree is out of sync with the index, instead of the
>> more vague "look at worktree".
> 
> I am not sure if that is a good idea.  Those who understand what the
> "work tree out of sync with" phrase mean would understand "look at
> work tree" but the reverse would not be true.

I'm not sure I agree. Even looking at it from a grammatical perspective,
"the hash is all zero if a path is unmerged, is a deletion or is out of sync
with the index" makes more sense to me than "the hash is all zero if a path is 
unmerged, is a deletion or "look at worktree""...

> 
> The other hunk about "new" -> "dst" is a good change regardless, but
> even there, "out of sync with" may need to be rewritten to make it
> easier to understand.  Is it different from "the index does not know
> the exact value (hence you need to look in the working tree if you
> really cared to find it out, perhaps with hash-object)"?

I think it's clear what is meant, I don't think we need to change it.

Thanks,

Philippe.
