Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EECB208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 07:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdHXH2O (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 03:28:14 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38631 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdHXH2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 03:28:14 -0400
Received: by mail-wm0-f52.google.com with SMTP id l19so14198341wmi.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 00:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l8RjZYQ//PdypsAQIYY5fpDUqeJEZiBCuagfuAUYtvQ=;
        b=B6yalXGYZX3De+YCLl0aL2AANTp3tPgfVXAmtdF8auiBlWcnDiD9tmFA1pDf5xrUwL
         jtOVH0GUa/w0FuQlxcr9fh0nm+0jpWKKgW6ASVyZDlvVyakmQ+NwycYN/eCY3mHhfvOM
         dluAKkLUVx//x+QAbN0pswBo8BaSaypEAmJLLbWkmWNp7xIEDtDLd+dXNHJf7jyhUck/
         EqqDhQ3bGX/e8dd9qauTsNKi2idKiVV6Ap6HrqH8JojeKm4Q52m26p3Blc49n53nr8iO
         ZhntiSoMhdblwOYLU24xhynwtaXbgdhWW2osyoE0uWN5op9epXHiJKhofEmpdBfRetVJ
         XWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l8RjZYQ//PdypsAQIYY5fpDUqeJEZiBCuagfuAUYtvQ=;
        b=JZV79MtdBfBTklP3OqFwh91Mz4zMBY8zdLprVqhFQMgmycpO971ttSQmYabaHpoLEr
         DdFF5SIzNMOQJWb5KWSCH1QhQ6+Fzol8uHn71cGp0BTqGBFQ2dAx+QIfvVcYgxUdIWQV
         DIllFvZtMXhPm5lL6JDL3mrDK+HDhqONBRdKw0jTHz/RaAPcd+WOI5CT3dwzdmllg5c7
         248sHLGQ3gutKsPKvVaItDCi9SCebN9JneFaO9MPymVh0uxSXhLcfCPntWB6UIxxtNTA
         ZwO0hJfZNm59shVNEg2mXGRV+0MN0fLfSBLFpRtLfqjOourt6ott5kop4743qNmbWqi7
         /uhA==
X-Gm-Message-State: AHYfb5hl9JHbwiq7twowfzYmbNodMejTeK6TBPwsPUgx5Z2LZlN54P49
        +qUjcdMeA1wuNWaXdHobgeMcUOmtNQ==
X-Received: by 10.80.153.99 with SMTP id l32mr2543358edb.293.1503559692853;
 Thu, 24 Aug 2017 00:28:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.182.5 with HTTP; Thu, 24 Aug 2017 00:27:52 -0700 (PDT)
In-Reply-To: <20170823212251.li5fs4kypeveydbm@sigill.intra.peff.net>
References: <20170822182242.20862-1-jonathantanmy@google.com>
 <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com> <20170823212251.li5fs4kypeveydbm@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 24 Aug 2017 00:27:52 -0700
Message-ID: <CA+P7+xoPscnzCGLHSK-gk80GcZLZ5T4e7E29ztVX7qbjMcGbnw@mail.gmail.com>
Subject: Re: [PATCH] Doc: clarify that pack-objects makes packs, plural
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 2:22 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 22, 2017 at 12:56:25PM -0700, Junio C Hamano wrote:
>
>>  - There should be an update to say max-pack-size is not something
>>    normal users would ever want.
>
> Agreed.
>
>> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
>> index 8973510a41..3aa6234501 100644
>> --- a/Documentation/git-pack-objects.txt
>> +++ b/Documentation/git-pack-objects.txt
>> @@ -108,9 +108,13 @@ base-name::
>>       is taken from the `pack.windowMemory` configuration variable.
>>
>>  --max-pack-size=<n>::
>> -     Maximum size of each output pack file. The size can be suffixed with
>> +     In unusual scenarios, you may not be able to create files
>> +     larger than certain size on your filesystem, and this option
>> +     can be used to tell the command to split the output packfile
>> +     into multiple independent packfiles and what the maximum
>> +     size of each packfile is. The size can be suffixed with
>>       "k", "m", or "g". The minimum size allowed is limited to 1 MiB.
>> -     If specified, multiple packfiles may be created, which also
>> +     This option
>>       prevents the creation of a bitmap index.
>>       The default is unlimited, unless the config variable
>>       `pack.packSizeLimit` is set.
>
> I wonder if it is worth mentioning the other downside: that the sum of
> the split packfiles may be substantially larger than a single packfile
> would be (due to lost delta opportunities between the split packs).
>
> For the sneaker-net case, you are much better off generating a single
> pack and then using "split" and "cat" to reconstruct it on the other end
> Not that I think we should go into such detail in the manpage, but I
> have to wonder if --max-pack-size has outlived its usefulness. The only
> use case I can think of is a filesystem that cannot hold files larger
> than N bytes.
>
> -Peff

Is it possible to detect on the file system that we can't store files
that large, and remove the option, while enabling it only when we
detect the filesystem is unable to store large files?

Thanks,
Jake
