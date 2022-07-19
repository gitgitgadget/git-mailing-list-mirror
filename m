Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C13C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 23:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiGSX6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGSX5t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 19:57:49 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F1E4B0F8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 16:57:48 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id j3so9015879oif.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 16:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v881EXy3qhn5eGENKIi19QCTgrvpwGurZlf7bd13LWU=;
        b=Ay+yhFqvI36XfJ41yr7UBP8hnGNOIfVxw1sxMLzUkxe1X79fjN7fFB/CRXnuUoy1gT
         9TBaJifsYvYEH3vVX+qS9bi4+uEMvXS1HcJJYWNo/8SVRHZ3oJb3fDiY8qd5W52lkS46
         z2caIMLhW6gJNX3N27l5abQCgpRwjN69YjWsdAcFVjkqsHJSSefU/jKX1QTQa5f/Qoox
         91QZW8j2tLNq+Ql9+urS6uIqFi5OvF/e5JnGmJ0TTGaRtmYhoelHmhcXkqonw28DQ+dT
         HE+kqTH+3P1uPdGlKHzKoc9M8VpoL6Q2AHgvOrkf2IKnjFCy3uutGwSrR0MU+BE4NIPE
         Ug9Q==
X-Gm-Message-State: AJIora/XNzneVo9Ht2Ji/oIHxuAU4mhfCKaZgWJaQZ2OteeBhWRA/mZc
        AohQH9k/vqnG7D0YAdKO2CXx5Y1xFO+b9w==
X-Google-Smtp-Source: AGRyM1vWR2F0Tx0Bp5BeFgPoFfk0cFs3xfk/QDqWsjs7LkJQJUv38M2AP9QbhxETrb2klWo0ER0Q9g==
X-Received: by 2002:a05:6808:180d:b0:33a:3a7:1fd with SMTP id bh13-20020a056808180d00b0033a03a701fdmr995434oib.169.1658275067661;
        Tue, 19 Jul 2022 16:57:47 -0700 (PDT)
Received: from [10.0.0.141] (c-174-62-43-211.hsd1.nm.comcast.net. [174.62.43.211])
        by smtp.gmail.com with ESMTPSA id a25-20020a9d74d9000000b0061c7f73611asm6240301otl.60.2022.07.19.16.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 16:57:47 -0700 (PDT)
Message-ID: <7391734b-c5d7-1f8c-912b-a75833a3070a@kinzelman.com>
Date:   Tue, 19 Jul 2022 17:57:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: paul@kinzelman.com
Subject: Re: Possible git bug when working with Microsoft Mapped drives
Content-Language: en-US
To:     Jeff Hostetler <git@jeffhostetler.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
 <b5931787-3589-102f-cfeb-caeb8a07e149@jeffhostetler.com>
 <YtXS1s66fw/UCvLU@tapette.crustytoothpaste.net>
 <d4a77fd1-6be7-6466-8c94-6e2552184094@kinzelman.com>
 <e39ce708-afbf-4524-187c-20dcd979a061@jeffhostetler.com>
From:   Paul Kinzelman <paul@kinzelman.com>
In-Reply-To: <e39ce708-afbf-4524-187c-20dcd979a061@jeffhostetler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying, but their 2FA won't work for me. I'm not getting their
email (yes I checked junk and spam) and there doesn't seem to
be a PC based alternative. I don't want to install another phone app.

On 7/19/2022 3:02 PM, Jeff Hostetler wrote:
> Could you maybe create an issue against GFW for this so that we don't
> forget about it?
>
> https://github.com/git-for-windows/git/issues
>
> Jeff
>
>
> On 7/18/22 5:55 PM, Paul Kinzelman wrote:
>> Thank you! Jeff was right on, but I didn't want to create extra noise
>> on the elist, so I replied just to him.
>>
>> His suggestion of the --no-hardlinks
>> caused it to work!
>>
>> Might be good to test to see if a drive letter is on a remote system
>> and do that automagically.
>>
>> On 7/18/2022 3:38 PM, brian m. carlson wrote:
>>> On 2022-07-18 at 20:46:44, Jeff Hostetler wrote:
>>>> On 7/18/22 4:28 PM, Paul Kinzelman wrote:
>>>>> I'm using git version 2.37.1.windows.1 and Windows 10
>>>>>
>>>>> I've got two systems which are miles apart and so are not on the same
>>>>> LAN, and I have connected them together using the ui.com VPN and M$
>>>>> RDP/TSclient. I mapped each system's C: drive to be accessed by the
>>>>> other system as Drive X: and I can transfer files back and forth
>>>>> initiated on each system.
>>>>>
>>>>> I can also see all the repository files on the source system, 
>>>>> including
>>>>> the tree of files under the .git directory. Note I had to unhide the
>>>>> .git folder so that I could see that folder from the other system.
>>>>>
>>>>> However, when I run 'git clone' on one system to get the 
>>>>> repository from
>>>>> the other system, git seems to think the repository on the other
>>>>> system is empty when it's not. As I said, I can even do a directory
>>>>> and see all the other files.
>>>> I can't duplicate your setup, so I'll just speculate out loud
>>>> here.  I have to wonder if the "X:" drive letters are tricking
>>>> Git to thinking that the remote instance is actually local and
>>>> Git is trying to use some shortcuts. (For example, it might
>>>> hardlink them rather than copy them on Linux.)
>>>>
>>>> So I'm wondering if "--no-local" or "--no-hardlinks" or using
>>>> a file URL rather than a pathname might make it behave differently.
>>> It may also be the case that the remote file system lacks some
>>> functionality that Git needs.  For example, Windows can support mapping
>>> HTTP DAV resources as drives, but the DAV protocol is incapable of
>>> providing certain operations that Git expects of a file system (Git
>>> roughly needs something that's POSIX compliant, but can paper over case
>>> insensitivity) and thus such a disk simply can't work with Git.
>>>
>>> This may end up looking like the file system is empty because, for
>>> example, the function to query directory contents may return an error.
>>> The contents may not actually be empty, but because they cannot be
>>> enumerated in the way Git needs them to be, it appears that way.
>>>
>>> Again, I don't know if this is the case here, but you're the second
>>> person recently to have seen problems with using RDP for this purpose.
>>> You may wish to try SFTP, which should work (at least it does for Unix
>>> systems), or possibly SMB/CIFS (which may or may not work, but I 
>>> believe
>>> it typically does).
>>

