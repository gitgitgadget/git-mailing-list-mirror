Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4BD205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 14:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbdABOdd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 09:33:33 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35245 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbdABOdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 09:33:32 -0500
Received: by mail-lf0-f67.google.com with SMTP id x140so25903704lfa.2
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CJb2LdxMdlWKYBv2QpYLC9HVK13qyQNjMtwZxClEZEE=;
        b=avDP51gtqmOSnSC81AQey0l/UEXuJMcy1GBRcqkc2gwVbqYPSN2x3qJ/w9lTbzOJlR
         6T7JvtlQ5hdxesQdzdbqwp/NRUKJmoJfJcHSQLQJWlf6IfueAczYq9g5AP/C/5VTTLjN
         AdrdbMIlFc7Zj9AxgKyfx+eOchcS6I8DgCSvquA0xyhUPXkqMD7w6O9V9EFnsrgvSEOe
         ri+txneCNSGQ0lZ6Y5G/ek3bVouN6yNxEk2osC9EmvcysT3opfcSCZtvEdfOkZv53lQR
         +PlKP5sGx94kaVoJYS8kwLopkpQm8U7Q9iH2kWSyACKzcmPGXrGmQm5NUbbpZ8jgG63I
         AdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CJb2LdxMdlWKYBv2QpYLC9HVK13qyQNjMtwZxClEZEE=;
        b=KHJSSpuJzK2i2d7F4b0jQm7wTD1H71ogwQGTHoSWIZd6hZVYki9oCjKjBmvkPNQ4lG
         B9gsA9e0CDXYqwI9G9ECIB4MzSq0n1TAhBumfNq9D4iK82a4LS3tGATHhkQHcu79KuT5
         Kh0VV1SrB2oXI4GH33I12cvUiEiclQrffRL1BPXkh1l9d37iTvR4Pu4FiMkzHGbJPAff
         Y/aWQCqwQYB9rm/KTNqR57CEnXlmlvbMqlxh4klzN68yqO6GNB+gsNgZd8/D9ndd8haP
         tbkXBjKCmxvgit3vx8R8viW75uNFdCWunNTW2OGhNTNdWmacr4TDxcOGfhFKvxEQd6mC
         8A2Q==
X-Gm-Message-State: AIkVDXIW9njBtnn7Tcm75rbJCKaKLet9ySt10cMD5dc0hl/oCSD19KBSahdLvFUeBJHSGt7TGh33X0Y9ePJaww==
X-Received: by 10.25.209.73 with SMTP id i70mr16267545lfg.24.1483367610307;
 Mon, 02 Jan 2017 06:33:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 06:33:29 -0800 (PST)
In-Reply-To: <xmqqeg0t9oct.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-21-chriscool@tuxfamily.org> <xmqqeg0t9oct.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 15:33:29 +0100
Message-ID: <CAP8UFD0bgxVrc=RGHs1GrZ_5PF4cdfhqXLMiCSJTNw9axrr=_w@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] Documentation/config: add splitIndex.sharedIndexExpire
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  Documentation/config.txt | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e0f5a77980..24e771d22e 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2786,6 +2786,17 @@ splitIndex.maxPercentChange::
>>       than 20 percent of the total number of entries.
>>       See linkgit:git-update-index[1].
>>
>> +splitIndex.sharedIndexExpire::
>> +     When the split index feature is used, shared index files with
>> +     a mtime older than this time will be removed when a new shared
>
> As end-user facing documentation, it would be much better if we can
> rephrase it for those who do not know what a 'mtime' is, and it
> would be even better if we can do so without losing precision.
>
> I think "shared index files that were not modified since the time
> this variable specifies will be removed" would be understandable and
> correct enough?

Yeah, I agree it is better for end users. I will use what you suggest.

>> +     index file is created. The value "now" expires all entries
>> +     immediately, and "never" suppresses expiration altogether.
>> +     The default value is "one.week.ago".
>> +     Note that each time a new split-index file is created, the
>> +     mtime of the related shared index file is updated to the
>> +     current time.
>
> To match the above suggestion, "Note that a shared index file is
> considered modified (for the purpose of expiration) each time a new
> split-index file is created based on it."?

Yeah, I also agree it is better and will use that.
