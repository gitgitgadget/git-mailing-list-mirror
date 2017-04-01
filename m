Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E6F20958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdDATaR (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:30:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36732 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdDATaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:30:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so22917758pgh.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n6jO97RxuHdEE4sTLFRLtApK9hW76ionuu6OXmjvhSU=;
        b=Hh1lpcmt6JKVW9Lk7M7oZ1dCPRy0b/mRWTW5ZscOPsniGVBdyhkCaCswZ+dJMPQJ49
         YhZ3VzfLZcTBphSgTCDuPO5ZZsy7eKPoSj16h9eM2zclVyq/Mo6pZ88Cx6GUVWT6i9vk
         pdThKEmbgg2uGYQNkUr8z94CcTpxS24hAD479gyRiCjllBfdGdLJpgCCZrfYR5ji/zO/
         36gD656UP0wF7lrio3xcSIWzAssgRw5iUfTer5iiRqKZRJkpd2fQcl9pUhnj50r2QIpF
         zX31ifMCJMxJxix0P4L1+8fHYkBPFAWYDgnwYg/jbOs+/WPUbsMwMxp6nTHKsnw3o1Wk
         WImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n6jO97RxuHdEE4sTLFRLtApK9hW76ionuu6OXmjvhSU=;
        b=oci6BY6zYSJBar7Wzpy9ugwNt8nbtc5v/3cz2hCoVjviZSuG6YhhgX6wKS12YIovmw
         LnNTZ5QPUEYpXJVuKFqRpbA/TpDJuNaDIlSvGXNzkoVg5FulFRMSm0q3kiOCY9qKjYYV
         CUz7YC78tC0CrYNiieoUKBw1N4zJ9lXttAku0Ux4Lm0SXVrctvLjydhL1baaXIfh29s+
         LOzpz2wbviCU22fjmnF6/HSOrBe2sd1xkNFuQgPKTQ0WoyKcIF0o2XlhMSRA3QZSqeg8
         1zkisUvBSRGdXknjpGVWtk8ngDTEGdJ4IqGZ0h7Yg57LlvC9qHdblZQY2tPbsbHTZ1hX
         n30w==
X-Gm-Message-State: AFeK/H2aJ9PVqnw+adoccNfZCiTfWfEcKmumCOdgH+WFkUfizbxlGJsWMhSnWtPAFepKsRcH2FV/jKKh9KLqPw==
X-Received: by 10.84.175.129 with SMTP id t1mr10956428plb.17.1491075015853;
 Sat, 01 Apr 2017 12:30:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.15 with HTTP; Sat, 1 Apr 2017 12:30:15 -0700 (PDT)
In-Reply-To: <xmqqy3vkt008.fsf@gitster.mtv.corp.google.com>
References: <20170401153049.21400-1-robert.stanca7@gmail.com> <xmqqy3vkt008.fsf@gitster.mtv.corp.google.com>
From:   Robert Stanca <robert.stanca7@gmail.com>
Date:   Sat, 1 Apr 2017 22:30:15 +0300
Message-ID: <CAJYcaSOgcmZs9WOAGDm0DXonZooq2Uymcu0xkhcvwv-W6tkv0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] Convert signed flags to unsigned
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regarding the first part , i can resend those 2 patches rewriting the
commit message if you want.

On Sat, Apr 1, 2017 at 10:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Stanca <robert.stanca7@gmail.com> writes:
>
>> Subject: Re: [PATCH 1/2] [GSOC] Convert signed flags to unsigned
>
> Try
>
>     git shortlog --no-merges -40
>
> to learn how commits are typically titled.  And then imagine this
> patch makes into our codebase and appear in the output.
>
> Can you tell what this commit is about from that single line title?
> No.  You wouldn't even know that it is only touching bisect.h and
> nothing else.
>
> What do your readers want "shortlog" output to tell them about your
> commit?  What are the most important thing (other than giving you an
> excuse to say "I have completed a microproject and now I am eligible
> to apply to GSoC" ;-)?  Your proposed commit log message, especially
> its title, must be written to help future readers of the project
> history.
>
> Perhaps
>
>     bisect.h: make flags field in rev_list_info unsigned
>
> would help them better.
>
>>  Unsigned int is a closer representation of bitflags rather than signed int that uses 1 special bit for sign.This shouldn't make much difference because rev_list_info.flags uses only 2 bits(BISECT_SHOW_ALL and REV_LIST_QUIET)
>
> Overlong lines, without space after full-stop before the second
> sentence, without full-stop at the end of the sentence.
>
>>
>> Signed-off-by: Robert Stanca <robert.stanca7@gmail.com>
>> ---
>>  bisect.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bisect.h b/bisect.h
>> index acd12ef80..a979a7f11 100644
>> --- a/bisect.h
>> +++ b/bisect.h
>> @@ -16,7 +16,7 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
>>
>>  struct rev_list_info {
>>       struct rev_info *revs;
>> -     int flags;
>> +     unsigned int flags;
>
> Have you checked how this field is used?  For example, there is this
> line somewhere in rev-list.c
>
>         int cnt, flags = info->flags;
>
> and the reason why the code copies the value to a local variable
> "flags" must be because it is going to use it, just like it and
> other codepaths use info->flags, no?  It makes the code inconsistent
> by leaving the local variable a signed int, I suspect.
