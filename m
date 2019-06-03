Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5850E1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFCSkp (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:40:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36086 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFCSkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:40:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so1114528qkl.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L754kRgEmbM/Ak0dJdtDxQZbTGaUbQ/XVyV7rdxTnfg=;
        b=KXw+5AW+ko8syTdpO3eAEPRna3byqf1/ABQ6R/2rYUEYUvraj/MW7HbuP1+/1CF97h
         Y/5sEYNuXFVYyMiew+1i5KSsY2n2t0HpsQ7LRWUSNhcpSq1NQ145R83+rXzZQ1qOq+jx
         40c8LvBC+hNCEigFSv25P7xyhQGPKPm0vq0TYvb4FRb+jRMvM4EJ8SXzY0s1UpnU8zgy
         poTmfriTNAyzhbb2qW8xQyI3JXFDYCeyuNL3f1WrUuq1Ii9Og4yNOwP49wgmXxt7GDGL
         jF4WRdI/L1I5vq3kZxaN6yBVO8mndnNSnnAoCUuQx8iVNRtqH8UGSLX/qJ3X4wLsGcaV
         uAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L754kRgEmbM/Ak0dJdtDxQZbTGaUbQ/XVyV7rdxTnfg=;
        b=A8Lt3QTsLhLSOp628L3cswcv2HAUiSS8glTzEwE3L2Nz1NuGlyKoipFewxfF5hJugV
         xHLOalAMR4JvP0d1IiyNHrVfcCTwWrWBzPzMuggBdU+TTO1GMZScD4YcDQgGUqbj/UkV
         4arjv9W1nxzU0bXHRG/Z293nyxn55VG75v4VLiWNLstOgsTrZTPndd4o/tCK9Wc93qRh
         ELZJ9r1DUlKTpKLr5MjgmWo45Aj0Bbu6tvtSeMyHfoijGqo32oD/x4j8QmEMm8iWygAR
         Zn593Ks/a/835ayjacKlYKaS/PyXwgyMZpk+/h3xf2Csr52nHVwcVY4zRd4b+EcJJ5kw
         dURg==
X-Gm-Message-State: APjAAAWWkQ5z25aly5KRAsr1MW3q3cu3+brdRNKkkXEuyVAHkea6Y/P6
        vKiB9T5RiQmmlnBcbd+AT1QypYdTEzg=
X-Google-Smtp-Source: APXvYqwqawC6GFEl20k5iIc53Ij5x83OyBbKZqpb76KL5+nRdLA3A2uh2w90E/PT6sKwfyTW6hefsg==
X-Received: by 2002:a37:6708:: with SMTP id b8mr21130481qkc.141.1559587244075;
        Mon, 03 Jun 2019 11:40:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f1a3:6535:3805:954d? ([2001:4898:a800:1010:a2d9:6535:3805:954d])
        by smtp.gmail.com with ESMTPSA id a6sm3867193qkn.14.2019.06.03.11.40.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:40:43 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
To:     Barret Rhoden <brho@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Cc:     michael@platin.gs, Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
 <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <80a23fb8-5ea8-dba3-ce7d-f6f5d4c02310@gmail.com>
Date:   Mon, 3 Jun 2019 14:40:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2019 2:11 PM, Barret Rhoden wrote:
> Hi -
> 
> On 5/30/19 2:24 PM, Derrick Stolee wrote:
>>> 8934ac8c 1190)     ent->ignored == next->ignored &&
>>> 8934ac8c 1191)     ent->unblamable == next->unblamable) {
>> These lines are part of this diff:
>>
>> --- a/blame.c
>> +++ b/blame.c
>> @@ -479,7 +479,9 @@ void blame_coalesce(struct blame_scoreboard *sb)
>>
>>          for (ent = sb->ent; ent && (next = ent->next); ent = next) {
>>                  if (ent->suspect == next->suspect &&
>> -                   ent->s_lno + ent->num_lines == next->s_lno) {
>> +                   ent->s_lno + ent->num_lines == next->s_lno &&
>> +                   ent->ignored == next->ignored &&
>> +                   ent->unblamable == next->unblamable) {
>>                          ent->num_lines += next->num_lines;
>>                          ent->next = next->next;
>>                          blame_origin_decref(next->suspect);
>>
>> The fact that they are uncovered means that the && chain is short-circuited at
>> "ent->s_lno + ent->num_lines == next->s_lno" before the new conditions can be
>> checked. So, the block inside is never covered. It includes a call to
>> blame_origin_decref() and free(), so it would be good to try and exercise this region.
> 
> What is your setup for determining if a line is uncovered?  Are you running something like gcov for all of the tests in t/?
> 
> I removed this change, and none of the other blame tests appeared to trigger this code block either, independently of this change.  (I put an assert(0) inside the block).
> 
> However, two of our blame-ignore tests do get past the first two checks in the if clause, (the suspects are equal and the s_lno chunks are adjacent) and we do check the ignored/unblamable conditions.
> 
> Specifically, if I undo this change and put an assert(0) in that block, two of our tests hit that code, and one of our tests fails if I don't do the check for ignored/unblamable.

The tests use gcov while running the tests in t/. Here is the build [1].

There are some i/o errors happening in the build, which I have not
full diagnosed. It is entirely possible that you actually are covered,
but there was an error collecting the coverage statistics. The simplest
thing to do is to insert a die() statement and re-run the tests.

Thanks,
-Stolee

[1] https://dev.azure.com/git/git/_build/results?buildId=615

