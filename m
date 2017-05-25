Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A683209FD
	for <e@80x24.org>; Thu, 25 May 2017 13:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969206AbdEYNt0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 09:49:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35935 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932285AbdEYNtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 09:49:25 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so30185141qta.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZHSDzibwzDQRKZXk+mGn/tuCjIFBYcWexM41HBgrUc=;
        b=fCXblWw35bimsUE3E7OUgpDC9bG+Ny/CTjs51XtgtmcK7O8Hx7BphhQtqyvkIai3NK
         xqWeQao+/R9V8PUfvmQj1208KBGE7DfCmztHw4HnVQDICOdVIYi4vulRtSwN/LO2NoTS
         bIjsmt7OJBQyhnx6Dq3rw5D1SUNXL1iZjyHQovV6B/CEpD8XY+kmvjGtzUoe7UHGsq7D
         mEzNsqTbrGfvKu3pjxX78VStsM8El9FiWy8yVYBhIe7TRdpW0vukMD5RfC97jsPzFu1r
         Q9n5U0L2JxGCgHsl0E2goaNXYqimD23nYJGHdbQ4TWIj1GZJn8vtApiSc63EWyhsiui8
         BBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZHSDzibwzDQRKZXk+mGn/tuCjIFBYcWexM41HBgrUc=;
        b=hkz3ju9tn3xe/zBzO1LZbAT70RAUNLndiWdg957Hk03HTLIb676HF9WX/dLwl0yb9s
         CPRtrZIWSpwIRzyUGYmkT6+jpAzcyFRFPyUis31lpNpHJS2um9u7W2S5cSme/KJz35I9
         XB++lqpZ0s4333aGxdc7S0hi+kodAlENbUtHcnHrIEObzG0xbHWTa3AL9KItF3d3daNs
         CitYQdmxxtY93Gy4Jqbt6ylzKraL8LK3YmS2bxIhIn/uEW1l4DQgiBN3hFsBVR+293kI
         EozTNY8lKDqw5AvjYCtdwZFhlNv02Ko3ctZNlUPhlZt1a8i2eKkgIBdK+1j4/NnwN78A
         TJcQ==
X-Gm-Message-State: AODbwcBHed6QiYmGPWQXMqpcFRB7tlVKWKGce45rSh9aPSsFXtgdPzMX
        D6CcTETb4Z/3pQ==
X-Received: by 10.200.47.169 with SMTP id l38mr43611093qta.150.1495720164117;
        Thu, 25 May 2017 06:49:24 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id l15sm4749806qta.7.2017.05.25.06.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 06:49:23 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] fsmonitor: add documentation for the fsmonitor
 extension.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, benpeart@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David.Turner@twosigma.com, Jeff King <peff@peff.net>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-6-benpeart@microsoft.com>
 <CACBZZX5URAeA+=12ezW-oDGnkdAqvQqV7it=HBaYCKUdx0p_XA@mail.gmail.com>
 <5ab333a4-c3cd-1cb5-ba3e-6b08fa14c9e7@gmail.com>
 <CACBZZX6LENwuVuTyU-RetaXz8jZtUp1dv+gmQQ281sPx1czPnA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <52d8376d-63ad-14f8-fbd5-3540a4926e92@gmail.com>
Date:   Thu, 25 May 2017 09:49:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX6LENwuVuTyU-RetaXz8jZtUp1dv+gmQQ281sPx1czPnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/22/2017 1:28 PM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 22, 2017 at 6:18 PM, Ben Peart <peartben@gmail.com> wrote:
>> On 5/20/2017 8:10 AM, Ævar Arnfjörð Bjarmason wrote:
>>>>
>>>> +== File System Monitor cache
>>>> +
>>>> +  The file system monitor cache tracks files for which the
>>>> query-fsmonitor
>>>> +  hook has told us about changes.  The signature for this extension is
>>>> +  { 'F', 'S', 'M', 'N' }.
>>>> +
>>>> +  The extension starts with
>>>> +
>>>> +  - 32-bit version number: the current supported version is 1.
>>>> +
>>>> +  - 64-bit time: the extension data reflects all changes through the
>>>> given
>>>> +       time which is stored as the seconds elapsed since midnight,
>>>> January 1, 1970.
>>>> +
>>>> +  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
>>>> +
>>>> +  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
>>>> +    is CE_FSMONITOR_DIRTY.
>>>
>>>
>>> We already have a uint64_t in one place in the codebase (getnanotime)
>>> which uses a 64 bit time for nanosecond accuracy, and numerous
>>> filesystems already support nanosecond timestamps (ext4, that new
>>> Apple thingy...).
>>>
>>> I don't know if any of the inotify/fsmonitor APIs support that yet,
>>> but it seems inevitable that that'll be added if not, in some
>>> pathological cases we can have a lot of files modified in 1 second, so
>>> using nanosecond accuracy means there'll be a lot less data to
>>> consider in some cases.
>>>
>>> It does mean this'll only work until the year ~2500, but that seems
>>> like an acceptable trade-off.
>>>
>>
>> I really don't think nano-second resolution is needed in this case for a few
>> reasons.
>>
>> The number of files that can change within a given second is limited by the
>> IO throughput of the underlying device. Even assuming a very fast device and
>> very small files and changes, this won't be that many files.
>>
>> Without this patch, git would have scanned all those files every time. With
>> this patch, git will only scan those files a 2nd time that are modified in
>> the same second that it did the first scan *that came before the first scan
>> started* (the "lots of files modified" section in the 1 second timeline
>> below).
>>
>> |------------------------- one second ---------------------|
>> |-lots of files modified - git status - more file modified-|
>>
>> Yes, some duplicate status checks can be made but its still a significant
>> win in any reasonable scenario. Especially when you consider that it is
>> pretty unusual to do git status/add/commit calls in the middle of making
>> lots of changes to files.
> 
> I understand that we get most of the wins either way.
> 
> I'm just wondering why not make it nanosecond-resolution now from the
> beginning since that's where major filesystems are heading already,
> and changing stuff like this can be a hassle once it's initially out
> there, whereas just dividing by 10^9 for APIs that need seconds from
> the beginning is easy & future-proof.
> 
> There are some uses of git where this would probably matter in practice.
> 
> E.g. consider a git-annex backed fileserver using ext4, currently
> git-annex comes with its own FS watcher as a daemon invoked via `git
> annex watch` to constantly add new files without killing performance
> via a status/add in a loop, with this a daemon like that could just
> run status/add in a loop, but on a busy repo the 1s interval size
> might start to matter as you're constantly inspecting larger
> intervals.
> 
> More importantly though, I can't think of any case where having it in
> nanoseconds to begin with would do any harm.

You're right, it's not hard to support nano second resolution and it 
doesn't do any harm.  I switch the index format and interface as I don't 
expect this code will still be running when the timer rolls over. 
Someone long after me will have to fix it if it is. :)

> 
>> In addition, the backing file system monitor (Watchman) supports number of
>> seconds since the unix epoch (unix time_t style).  This means any support of
>> nano seconds by git is academic until someone provides a file system watcher
>> that does support nano second granularity.
> 
> I haven't used watchman for anything non-trivial, but the
> documentation for the query API you seem to be using says you can
> request a {ctime,mtime}_ns field:
> 
> https://github.com/facebook/watchman/blob/master/website/_docs/cmd.query.markdown#user-content-available-fields
> 
> And isn't this the documentation for the "since" query you're using,
> saying you can specify any arbitrary fs timing field, such as a _ns
> time field:
> 
> https://github.com/facebook/watchman/blob/master/website/_docs/expr.since.md
> 
> ?

To keep the index extension and hook interface generic, I have not 
adopted the Watchman specific clock format.  This enables anyone to 
provide a different file system watcher that can inter-operate as nano 
seconds since epoc is easy for anyone to support.

> 
>> Finally, the fsmonitor index extension is versioned so that we can
>> seamlessly upgrade to nano second resolution later if we desire.
> 
> Aside from my nanosecond bikeshedding, let's say we change the
> semantics of any of this in the future: The index has the version, but
> there's one argument passed to the hook without a version. Is the hook
> expected to potentially be reading the version from the index to make
> sense of whether (in this case) the argument is a mtime or mtime_ns?
> 
> Wouldn't this make more sense than that on top, i.e. pass the version
> to the hook, untested (and probably whines about the sprintf
> format...):

It's a good point that the index extension is versioned and the hook 
interface is not.  I've not seen versioning in any hook interface to 
date but its never to late to start.  I'll add a separate version to the 
hook interface as well so they can be updated independently if needed.

> 
> $ git diff -U1
> diff --git a/cache.h b/cache.h
> index 6eafd34fff..3c63f179f8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -346,2 +346,3 @@ struct index_state {
>          struct untracked_cache *untracked;
> +       uint32_t fsmonitor_version;
>          time_t fsmonitor_last_update;
> diff --git a/fsmonitor.c b/fsmonitor.c
> index f5a9f818e8..7236b538ac 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -60,2 +60,4 @@ int read_fsmonitor_extension(struct index_state
> *istate, const void *data,
>                  return error("bad fsmonitor version %d", hdr_version);
> +       else
> +               istate->fsmonitor_version = hdr_version;
> 
> @@ -137,2 +139,3 @@ static int query_fsmonitor(time_t last_update,
> struct strbuf *query_result)
>          struct child_process cp = CHILD_PROCESS_INIT;
> +       char version[1];
>          char date[64];
> @@ -143,2 +146,3 @@ static int query_fsmonitor(time_t last_update,
> struct strbuf *query_result)
> 
> +       snprintf(version, sizeof(version), "%d", istate->fsmonitor_version);
>          snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update)
> 
