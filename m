Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A1E1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeKFF3M (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:29:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34888 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeKFF3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:29:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so61520qtc.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zLVz1OjL3HkaXn21zA9qa1slD2kcMzEhwzDNAHkt4zU=;
        b=U+u+IF1pI9J2FXZtHaT9EeLTxw3w9ot0FxNmI3z/MK48bVcADgZft+zhy0Zj42igOz
         a5Tc+yyxQ3NM+goIm4SOAzhgRLajQocLWKbvXR5Kr2Hn3erK96GXrrI8sMGcuw+YtDWe
         8TrCfDPQfw2OfgEDLIPnyVkt6SSN7SRwP3jMIRaSs9gzR1bdxafkC8KEbiDwvWuas0CA
         fdDlX74N70roDOeTo1TnIaHLt4i9luBAGtYj7bESmEwycyJN2Vw8H7M/BkLKWI4A9nlX
         1JuEGJz2VFB1nEHjNs67n4kgBRkfZgv7IbGkE8KSM2Hx+lOOk7M9rncUjNyEatZnpWV4
         L0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLVz1OjL3HkaXn21zA9qa1slD2kcMzEhwzDNAHkt4zU=;
        b=laQKK3XV+M3jcZZmZnm4XwHWPGpcb8bnI+h6wDWi1ubjtnPInQViTyX8MahoTK4D5T
         YE7FIqctt8OUhtVQLqHkADAsdBqiIC82jtS1rNp/AKew0AfkoE2IPgmpbDeXHUJuGsHr
         2ihMDLMAR5lAWYGztSNOgApHsTcRAV4SbFACRItNNrSkeTUUKRm6BTX6nUl/lANSV4Ic
         uwslG4ymhEuKVMYjoJv5h7APAtdQcdnIDNq82Xg3tXFa2CHCMmPccHvjqaN6aYIB3q5b
         AMEEnuNbWflhEh2VBigf4vn0L6e30CPBimEpxA4W9jpfqwWtg6DwbG6fNijXjt8tQz2Z
         sdSw==
X-Gm-Message-State: AGRZ1gLb7TFzDauhCAS8KtpjGy3FQCFJIKLZU4t461UG5Ja1VmM5720I
        O1Ct5f+9zS1mC2miOUfe0pM=
X-Google-Smtp-Source: AJdET5f1Ugzgg7iTsDujujOsc2wt2Q5+IezZQJLtVBpQ2Zv466Y1tfP7MPc3QmWAJARncAoR07toXQ==
X-Received: by 2002:aed:3c7d:: with SMTP id u58mr20922990qte.198.1541448470779;
        Mon, 05 Nov 2018 12:07:50 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y7-v6sm22131599qkf.38.2018.11.05.12.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:07:50 -0800 (PST)
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
 <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
 <87ftwf7nwa.fsf@evledraar.gmail.com>
 <CACsJy8Coyw-yiumAfTeASSPdzWXeRgtrS8Ta-VtYph4QnPunVQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b0518222-f0ba-a613-6a54-ad7f66d56140@gmail.com>
Date:   Mon, 5 Nov 2018 15:07:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Coyw-yiumAfTeASSPdzWXeRgtrS8Ta-VtYph4QnPunVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/5/2018 10:26 AM, Duy Nguyen wrote:
> On Mon, Nov 5, 2018 at 12:40 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sun, Nov 04 2018, Duy Nguyen wrote:
>>
>>> On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
>>>>>> +core.virtualFilesystem::
>>>>>> +       If set, the value of this variable is used as a command which
>>>>>> +       will identify all files and directories that are present in
>>>>>> +       the working directory.  Git will only track and update files
>>>>>> +       listed in the virtual file system.  Using the virtual file system
>>>>>> +       will supersede the sparse-checkout settings which will be ignored.
>>>>>> +       See the "virtual file system" section of linkgit:githooks[6].
>>>>>
>>>>> It sounds like "virtual file system" is just one of the use cases for
>>>>> this feature, which is more about a dynamic source of sparse-checkout
>>>>> bits. Perhaps name the config key with something along sparse checkout
>>>>> instead of naming it after a use case.
>>>>
>>>> It's more than a dynamic sparse-checkout because the same list is also
>>>> used to exclude any file/folder not listed.  That means any file not
>>>> listed won't ever be updated by git (like in 'checkout' for example) so
>>>> 'stale' files could be left in the working directory.  It also means git
>>>> won't find new/untracked files unless they are specifically added to the
>>>> list.
>>>
>>> OK. I'm not at all interested in carrying maintenance burden for some
>>> software behind closed doors. I could see values in having a more
>>> flexible sparse checkout but this now seems like very tightly designed
>>> for GVFS. So unless there's another use case (preferably open source)
>>>   for this, I don't think this should be added in git.git.
>>
>> I haven't looked at the patch in any detail beyond skimming it, and
>> you're more familiar with this area...
>>
>> But in principle I'm very interested in getting something like this in
>> git.git, even if we were to assume GVFS was a 100% proprietary
>> implementation.
> 
> I have nothing against building a GVFS-like solution. If what's
> submitted can be the building blocks for that, great! But if it was
> just for GVFS (and it was not available to everybody) then no thank
> you.
> 

Not only is VFS for Git open source and is/will be supported on Windows, 
Mac and Linux, the interface being proposed is quite generic so should 
be usable for other implementations.

To use it, you just need to provide a hook that will return a list of 
files git should pay attention to (using a subset of the existing 
sparse-checkout format).

If you see anything that would make using it difficult for other 
solutions to use, let's fix it now!
