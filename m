Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D9C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhLMWCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhLMWCX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:02:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F9C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:02:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id d11so7075938pgl.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/NNEmJ33JNjTwX0v5yHhMFr5MC3akMgoee5ApQuszI8=;
        b=UOx/2AoO/OHBIJL9jgNhpHXAUskExrZ8vaxg58Q6I/w1DtC25iO7nepUrkgoj88qaG
         GyPNVqA2nqG5H2F2p1KlRew31L6OIqRgr3Cahk8/a7oXlXu2xomP3qZ763p+wMyLJWYi
         GxP35szwyvdj5N+R0CddeqFGJVSgQmDcz7GgnlwxpQ5JuGkL+Dti9ScrRc6gtqSqTHnC
         yWnaNdQUzzKrpc/i7Wj2PsMMYw3glN4Ny3448DPuHX2T+/Xrdj70D7ov3ViHfzWdeKFl
         LZh51PABF8k1K9kzA4H244WCz8O8jC3JJBkctTLAzYUUOv9KK56zkH/NoWjVIxNKR8lR
         AESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/NNEmJ33JNjTwX0v5yHhMFr5MC3akMgoee5ApQuszI8=;
        b=ipi838wl4rcxylq7LjWcC0N3BJiNwJpMQoQQ7SslunvOQua+8KJZFmsp42FiEDXKdK
         8FFC16OWEol4mlDYosPpHCRlIQLdy9c+XQb6l2eRhUsC5HKyitJIg5BjXSyw1NZUL5IM
         sHrthOb2hnW/mIG7adS7my3otPY9MI1/CkfdLvH7WsJvUrVaAe/VVlqCviq7BV6pu/wf
         Nc0qvvaXhu4NkU72lecAytQfowwaVfLe9QDOXHah+m6TTZS0b0Q7n9P3+fS1p7+B+iSF
         8qtd4QdPtv0nIdXWX/XCArkAhbCq/c5TsUdUOxyq14BpnTSVazCqhDRQUeRu2xbPvrdN
         enIA==
X-Gm-Message-State: AOAM530qTz9rlzJ2ptoOHnAfwrFhHcO/qJfFQ1RBJcuqW4YkqQ1bAsy7
        vsMJj7PVFVxBXATrU0UsdNYsXQ==
X-Google-Smtp-Source: ABdhPJzj+xLTJSgyF9DISGbHkyq8W1lK3BJx/JKjpGj7W5QNFv1MChe6AgAlhqIm0kLKVrHDH5cUPg==
X-Received: by 2002:a63:cf04:: with SMTP id j4mr948548pgg.278.1639432942398;
        Mon, 13 Dec 2021 14:02:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:323c:e811:1713:53ca])
        by smtp.gmail.com with ESMTPSA id f8sm13599594pfv.135.2021.12.13.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:02:21 -0800 (PST)
Date:   Mon, 13 Dec 2021 14:02:15 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        bagasdotme@gmail.com
Subject: Re: [PATCH] l10n: README: call more attention to plural strings
Message-ID: <YbfC5/+Q7lPp0G2i@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>, bagasdotme@gmail.com
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
 <xmqqa6h4b24o.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6h4b24o.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.13 13:56, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In po/README.md, we point core developers to gettext's "Preparing
> > Strings" documentation for advice on marking strings for translation.
> > However, this doc doesn't really discuss the issues around plural form
> > translation, which can make it seem that nothing special needs to be
> > done in this case.
> >
> > Add a specific callout here about marking plural-form strings so that
> > the advice later on in the README is not overlooked.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  po/README.md | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/po/README.md b/po/README.md
> > index dcd8436c25..fd1e024dd3 100644
> > --- a/po/README.md
> > +++ b/po/README.md
> > @@ -219,7 +219,10 @@ General advice:
> >    they're part of Git's API.
> >  
> >  - Adjust the strings so that they're easy to translate. Most of the
> > -  advice in `info '(gettext)Preparing Strings'` applies here.
> > +  advice in `info '(gettext)Preparing Strings'` applies here. Strings
> > +  referencing numbers of items may need to be split into singular and
> > +  plural forms; see the Q\_() wrapper in the C sub-section below for an
> > +  example.
> >  
> >  - If something is unclear or ambiguous you can use a "TRANSLATORS"
> >    comment to tell the translators what to make of it. These will be
> 
> Sounds good to me, but I'd want an ack by those from the l10n
> department.
> 
> Thanks.

Hmm, I meant to CC both Jiang and Bagas, not sure why it didn't go
through.
