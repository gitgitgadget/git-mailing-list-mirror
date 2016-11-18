Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C981FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 23:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbcKRXnP (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:43:15 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34598 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbcKRXnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:43:13 -0500
Received: by mail-yw0-f182.google.com with SMTP id t125so173418655ywc.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 15:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=duegpVXWtKfZLgT8ricWtgVPjvG0WkErJZp6RIUtYDY=;
        b=taSkLYiPOXmPB6OtQHxw5f/EZnDLzp9UYDfqe2A1YvsmD4FiLC45v0FVRdGYAAUIgB
         WEa5pY4RyuQZm3bZz2hLfx9MqzJLNTgkhPCFWQRKkBNr0Kso914Nz2ctpy3iC/CZAh2G
         49hh6RfNw3mBJKX2r+dc4uDjvPQEzkgZshz6esm7ZOYTUaMn3mLbZbCao7gUBTCk/kRD
         RS7tj57ElvwD3MKuDySe+lnniiWUi8EFA499d/BZUd+ZdWveqj1am/azCtd9k3fhvrzD
         ff0rjLI0ouhm0dfOqETejFEaNQyOH5YlWLeWlQLSf+ZEBhliptc6jvEQdl+EhC1Q+D1L
         7RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=duegpVXWtKfZLgT8ricWtgVPjvG0WkErJZp6RIUtYDY=;
        b=eXyfOvQSPByn1o6kD9EKBxQnQWkd5rFJ4VUYlnE75j6ONUIc4yiBIRpi1/MsV3FunA
         2Hxd674ylgKmIqtfvX1B+XL+F62whATmqkAnIna8Q4fdgXd3B/Y7GgqJgDr6DY+uRiOB
         Npi//d9I6yL5Meb/K0sX2li3QXRwBJ/mvWv+45QnMWcm88RdCT56TNsHCAficrB4CvKa
         Sdt5sbJ/BeEgR1GqXRllwEc/mkatYtlXCGPL6Z++j3knmh1tfJnY1OcFXAob9DFRsSrL
         /kRmyAX9UKEDpJrjTur/11NXklbQw51LIXp6utFOBy31yi62YKkdtA85jsZ2M13YpE/X
         JNBQ==
X-Gm-Message-State: AKaTC02MQE9xX/uI82Pf+eV3sO/8dnxtZoN3nAcdy5h4mQ5tQi4fLQ75dvFHm1iGYBs5qce9I/f850rWlXJ6cQ==
X-Received: by 10.129.74.65 with SMTP id x62mr2346816ywa.59.1479512592601;
 Fri, 18 Nov 2016 15:43:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 18 Nov 2016 15:42:52 -0800 (PST)
In-Reply-To: <xmqq8tsgl5o4.fsf@gitster.mtv.corp.google.com>
References: <20161118230825.20952-1-jacob.e.keller@intel.com> <xmqq8tsgl5o4.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 18 Nov 2016 15:42:52 -0800
Message-ID: <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] add format specifiers to display trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> Git interpret-trailers will not recognize this as a trailer block
>> because it doesn't have any standard git tags within it. Would it be ok
>> to augment the trailer interpretation to say that if we have over 75%
>> trailers in the block that we accept it even if it doesn't have any real
>> recognized tags?
>
> I thought the documented way to do this is to configure one of your
> custom trailer as such.  Jonathan?
>

That would be fine then, if that works.

>>   pretty: add %bT format for displaying trailers of a commit message
>
> Are %(...) taken already?  In longer term, it would be nice if we
> can unify the --pretty formats and for-each-ref formats, so it is
> probably better if we avoid adding any new short ones to the former.
>

Oh, I hadn't considered adding a longer one. I'll rework this to use
longer ones.

> We have %s and %b so that we can reconstruct the whole thing by
> using both.  It is unclear how %bT fits in this picture.  I wonder
> if we also need another placeholder that expands to the body of the
> message without the trailer---otherwise the whole set would become
> incoherent, no?
>

I'm not entirely sure what to do here. I just wanted a way to easily
format "just the trailers" of a message. We could add something that
formats just the non-trailers, that's not too difficult. Not really
sure what I'd call it though.

Thanks,
Jake
