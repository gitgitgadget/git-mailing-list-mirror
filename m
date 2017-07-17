Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFA420357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdGQRnr (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:43:47 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36457 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdGQRnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:43:46 -0400
Received: by mail-qk0-f193.google.com with SMTP id d136so1952056qkg.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3LM9YO2Iic+W+aXsCWQf4VQxuEFu9cxNWLGIhXab8UE=;
        b=CMs8JVR7i4cE0wqx4Wr00HneP5SEt/lYF9a4MN6jjE9cnz0BkgPNmNVeBLpRSnLe3n
         GLWLYOSk7m3QCitD7sph+1Mqqc0ZlOH7y914srHqHHSTraSazuq/ynRodAc2PD4VMDeQ
         lijzHd7i6R4oWJT2XNcmUge1cW4W/oDxl/HqQB+ixvcWi3+5qgIw81x15UueeXHGxkmc
         OLBE/ydEbJ5uZmAvSqxvn0o+1Pd78jKbxheW34UYzkvrhK/55tdOz2k5Oxvd4X0sIqxa
         RmiznH0Ht3x/Rp9SjvmyAsPkspbj4Mn93OwTnzlg1JnY5H/FoCzr26h3/shmo+eHn/dd
         WuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3LM9YO2Iic+W+aXsCWQf4VQxuEFu9cxNWLGIhXab8UE=;
        b=kLcP6lQo5EYBfqpFN6NcVmNzRjqhiK5sXgbIPtN35QNakobQbveZKvZUbNO+y1XHAd
         8hK+oAatuFROvRn/wJ34Plt/Ai4MfknoBeTH9hSVqyc0tu6r5RxHc5IMRjm5r2vdnl9S
         bammKIOW/K3iQwe4+dUqbELFWT3Vq5OGELMIB6675mzXWdzWPyG2741yP8n9XIr3Qadv
         kk5bwwkAG6r9RftB81ncYGMzpGtlHBSzL+zOZpIPYyHl7R6Z+MzoP42jXMQtllu6Klnc
         EwIiOnjVgbdzTssd2jblKMrEnT7/PVvKwVL7Om8KUNjKX3glV/hvl6cJxAfZhOeFoDbw
         neZQ==
X-Gm-Message-State: AIVw113DaDe2Ocnq1tci8BnMgLrJAkTl0Cx/5i559ulgQHONSkkBfKJc
        ImuSWAmjSq0U2APj0W4=
X-Received: by 10.55.75.210 with SMTP id y201mr30664391qka.80.1500313424812;
        Mon, 17 Jul 2017 10:43:44 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o39sm14655464qto.10.2017.07.17.10.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 10:43:43 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing
 blobs")
To:     Philip Oakley <philipoakley@iee.org>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1499800530.git.jonathantanmy@google.com>
 <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b928c073-6156-30f2-c850-993e59079ed1@gmail.com>
Date:   Mon, 17 Jul 2017 13:43:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/16/2017 11:23 AM, Philip Oakley wrote:
> From: "Jonathan Tan" <jonathantanmy@google.com>
> Sent: Tuesday, July 11, 2017 8:48 PM
>> These patches are part of a set of patches implementing partial clone,
>> as you can see here:
>>
>> https://github.com/jonathantanmy/git/tree/partialclone
>>
>> In that branch, clone with batch checkout works, as you can see in the
>> README. The code and tests are generally done, but some patches are
>> still missing documentation and commit messages.
>>
>> These 3 patches implement the foundational concept - formerly known as
>> "missing blobs" in the "missing blob manifest", I decided to call them
>> "promised blobs". The repo knows their object names and sizes. It also
>> does not have the blobs themselves, but can be configured to know how to
>> fetch them.
>>
> If I understand correctly, this method doesn't give any direct user 
> visibility of missing blobs in the file system. Is that correct?

That is correct

> 
> I was hoping that eventually the various 'on demand' approaches would 
> still allow users to continue to work as they go off-line such that they 
> can see directly (in the FS) where the missing blobs (and trees) are 
> located, so that they can continue to commit new work on existing files.
> 

This is a challenge as git assumes all objects are always available 
(that is a key design principal of a DVCS) so any missing object is 
considered a corruption that typically results in a call to "die."

The GVFS solution gets around this by ensuring any missing object is 
retrieved on behalf of git so that it never sees it as missing.  The 
obvious tradeoff is that this requires a network connection so the 
object can be retrieved.

> I had felt that some sort of 'gitlink' should be present (huma readable) 
> as a place holder for the missing blob/tree. e.g. 'gitblob: 1234abcd' 
> (showing the missing oid, jsut like sub-modules can do - it's no 
> different really.
> 

We explored that option briefly but when you have a large number of 
files, even writing out some sort of place holder can take a very long 
time.  In fact, since the typical source file is relatively small (a few 
kilobytes), writing out a placeholder doesn't save much time vs just 
writing out the actual file contents.

Another challenge is that even if there is a placeholder written to 
disk, you still need a network connection to retrieve the actual 
contents if/when it is needed.

> I'm concerned that the various GVFS extensions haven't fully achieved a 
> separation of concerns surrounding the DVCS capability for 
> on-line/off-line conversion as comms drop in and out. The GVFS looks 
> great for a fully networked, always on, environment, but it would be 
> good to also have the sepration for those who (will) have shallow/narrow 
> clones that may also need to work with a local upstream that is also 
> shallow/narrow.
> 

You are correct that this hasn't been tackled yet. It is a challenging 
problem. I can envision something along the lines of what was done for 
the shallow clone feature where there are distinct ways to change the 
set of objects that are available but that would hopefully come in some 
future patch series.

> -- 
> Philip
> I wanted to at least get my thoughts into the discussion before it all 
> passes by.
> 
>> An older version of these patches was sent as a single demonstration
>> patch in versions 1 to 3 of [1]. In there, Junio suggested that I have
>> only one file containing missing blob information. I have made that
>> suggested change in this version.
>>
>> One thing remaining is to add a repository extension [2] so that older
>> versions of Git fail immediately instead of trying to read missing
>> blobs, but I thought I'd send these first in order to get some initial
>> feedback.
>>
>> [1] 
>> https://public-inbox.org/git/cover.1497035376.git.jonathantanmy@google.com/ 
>>
>> [2] Documentation/technical/repository-version.txt
>>
>> Jonathan Tan (3):
>>  promised-blob, fsck: introduce promised blobs
>>  sha1-array: support appending unsigned char hash
>>  sha1_file: add promised blob hook support
>>
>> Documentation/config.txt               |   8 ++
>> Documentation/gitrepository-layout.txt |   8 ++
>> Makefile                               |   1 +
>> builtin/cat-file.c                     |   9 ++
>> builtin/fsck.c                         |  13 +++
>> promised-blob.c                        | 170 
>> +++++++++++++++++++++++++++++++++
>> promised-blob.h                        |  27 ++++++
>> sha1-array.c                           |   7 ++
>> sha1-array.h                           |   1 +
>> sha1_file.c                            |  44 ++++++---
>> t/t3907-promised-blob.sh               |  65 +++++++++++++
>> t/test-lib-functions.sh                |   6 ++
>> 12 files changed, 345 insertions(+), 14 deletions(-)
>> create mode 100644 promised-blob.c
>> create mode 100644 promised-blob.h
>> create mode 100755 t/t3907-promised-blob.sh
>>
>> -- 
>> 2.13.2.932.g7449e964c-goog
>>
> 
