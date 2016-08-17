Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7026B1F859
	for <e@80x24.org>; Wed, 17 Aug 2016 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbcHQFcN (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 01:32:13 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34169 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcHQFcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 01:32:12 -0400
Received: by mail-yw0-f171.google.com with SMTP id z8so55505004ywa.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 22:32:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=lhhCnAOJEm+fb8zONQZ+oq4LRz2/BFApg97A9om/wDk=;
        b=iHX8amNGY1+kZwWJr6FcJMunjR8pqZgTPlMZbhZkBUA+ki8wrKj8QFCaFnumAcKXGo
         TN42JodIUPUn0PDr+jNWZ+xCzDaUbiBExJpwZW8BrBjOp3xIt7bfZqFgsinul/EZPpJP
         GNof1PD6CzcHSU+qtAhk4mcQmdre75ryWrS7uLgbcu2zc/LXbl67ZXyR5qxVfDeskhNR
         ts5ZOAihdhhmZDcB6Y5Fqfxua6dmmcLhhOYAZtaO1ULeVo+Rrk80FTHQmMTCsWefxfGH
         3c7+vnrkMwmtTpYebgWR1TscoRNuoQkMAHUd48PUkWysVW8hiRC+Xsk9yk8rkU7eK12s
         7vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=lhhCnAOJEm+fb8zONQZ+oq4LRz2/BFApg97A9om/wDk=;
        b=TVYmP+benkuSHwnisyp/vll+ziZiV28wyiHX7Yd5esQ2BrLGSLv3De3BQYqUQldNr5
         aXatjkklqSUSFbtv08Cbu8VJJWwxye7NZ+XAP9xMS7sjZ6kONEbv+klceslufACoB4ix
         p5tYGimWGrlHPmXcEj2a7+D7bmQBmNXEtkpfS+3bV3sHfADZAVg/W63akko5G/UrUeVs
         ZjScIBl42NSpR6gZDBqXQkkJYwoYQIfdr9v8WVdW0BEEt0njDy5HqNgNuVQA8m29ZpU9
         4+6gyV1u4ALLbBAAQPg7Z0C5aGjZBPcmnKSL49PbkLYQUpECtI79K+XLa5p6JSI8zZwF
         Wqwg==
X-Gm-Message-State: AEkoousXi6URotOCl9XbjRJqUxD6j7ef8BGrznsyunpoVfplxslptOxumag4J52g7b0yAvujso6RR0J9QF5USQ==
X-Received: by 10.13.249.135 with SMTP id j129mr29393802ywf.267.1471411931346;
 Tue, 16 Aug 2016 22:32:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 16 Aug 2016 22:31:50 -0700 (PDT)
In-Reply-To: <87pop8wh5w.fsf@thinkpad.rath.org>
References: <87y43wwujd.fsf@thinkpad.rath.org> <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
 <87pop8wh5w.fsf@thinkpad.rath.org>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 22:31:50 -0700
Message-ID: <CA+P7+xp2q8JWqqtqj-ATd=Ox9snTpC0DE9ND76VhV-5hOvVQdw@mail.gmail.com>
Subject: Re: Working with zip files
To:	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 2:14 PM, Nikolaus Rath <Nikolaus@rath.org> wrote:
> On Aug 16 2016, David Lang <david@lang.hm> wrote:
>> On Tue, 16 Aug 2016, Nikolaus Rath wrote:
>>
>>> I would like to store Simulink models in a Git
>>> repository. Unfortunately, the file format is binary. But luckily, the
>>> binary format happens to be a zipfile containing nicely formatted XML
>>> files.
>>>
>>> Is there a way to teach Git to take advantage of this when storing,
>>> diff-ing and merging these files?
>>
>> you should be able to use clean/smudge to have git store the files
>> uncompressed, which will help a lot.
>
> Having looked at that, I'm not sure if this really helps:
>
> As I understand, the smudge command is run on checkout to convert the
> blob in the repository to the format that is desired in the working
> tree. But this is the opposite of what I need: on checkout, I need to
> convert the text data in the repository to a blob in the working tree.
>
> Furthermore, I need to convert multiple text files into one blob, will
> smudge/clean seem to do just 1:1 conversions.
>
> Am I missing something? Are there any other options?

You want to store the contents of the zip file as *one* blob that is
the uncompressed contents of the archive somehow concatenated
together. That should still be a 1:1 relationship.

You won't store one blob per file in the zip.

Thanks,
Jake
