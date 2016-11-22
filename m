Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECAEA1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754586AbcKVAPf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:15:35 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34937 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbcKVAPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:15:33 -0500
Received: by mail-qt0-f177.google.com with SMTP id c47so1239146qtc.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B4EA26AR+rVHv47eX+TrgHorHZ5GPij3vL7AR9ABtLQ=;
        b=fhqu5MvYrAdmz1aCj3mWu6skcutY7K8qRg4MZUEPMRWEbMT7HeoBE2fCmU/Qx/j708
         kTesOlLOH9f8vuDgMYT9I19xVmlMG26ft4Q5euXTq7HUeG9Vq4NRn0OMUJK5l4zIz1qQ
         iD2zYQO6QW7psJTg98NMyDA3muzDH/xZ/air3GU1H7fmT6WC1PRD2Vu5KxEGOqpIKnA1
         2IFaIOI+DfZGCr6I1XIO8ICkSzaI2dhlC9enAQuirbjONxcnpDwZDAmLwAy/y+t/cIGO
         N/P0aarGWOJmJsA+r5jhNWZ+m0/AD6R5J8z83nho8MV6YhHiefrb/vWK8r6DNCm5g7Yn
         D0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B4EA26AR+rVHv47eX+TrgHorHZ5GPij3vL7AR9ABtLQ=;
        b=Ht75JYteLKRaufIekR94vOgUCA9JzdwUlp1X/8vWH1P95ds7QJ9wsuy3P35Eq+hnG/
         jhxwj/h1rMxUUTRVsAFuQLO5O54sqkEiI3oHgNMjPjJ5P+VR2joPet4ZDcQt0fk8yELx
         Y/p6OB60SXRvZlnDWEoJMP43ZWeqZt8Q7EsoSoE+MQ+0hhMxM4XuakWJ/kTehhYRbe8p
         qPKHiEUxGjCZUd4mL6VNeHgahqaA9SFq12MScEwGwDWOFj4Gus++K0dN4AyG49gV1KOl
         QtS6HFEEpoih4aHw3qnRECNRK0e6fr/8RxjVN75dV1iYp3rRxlhlWL39aPLaFSK2/8Ip
         Z29Q==
X-Gm-Message-State: AKaTC01MiGCJrW1gHtg2JsUzudmT/9PjEd3WFtW/6uGrhl5c/jnCtctwzkk/7G46GOXjH916y129SiE+J6XT7nqK
X-Received: by 10.237.34.206 with SMTP id q14mr9667021qtc.101.1479773732386;
 Mon, 21 Nov 2016 16:15:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 16:15:32 -0800 (PST)
In-Reply-To: <20161122001148.GD149321@google.com>
References: <20161121232709.8906-1-sbeller@google.com> <20161121232709.8906-3-sbeller@google.com>
 <20161122001148.GD149321@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 16:15:32 -0800
Message-ID: <CAGZ79kY+0WHFgXfVmEmw7H-qwuUcWcSssRyMzg2XqsGSDq+FCw@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] submodule-config: rename commit_sha1 to commit_or_tree
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 4:11 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/21, Stefan Beller wrote:
>>
>>       switch (lookup_type) {
>> @@ -448,7 +448,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>>
>>       /* fill the submodule config into the cache */
>>       parameter.cache = cache;
>> -     parameter.commit_sha1 = commit_sha1;
>> +     // todo: get the actual tree here:
>
> s/todo/TODO
>
> Makes it more clear that this is a TODO
>

The // is more annoying here. I'll review these changes closely
before sending out v3.
