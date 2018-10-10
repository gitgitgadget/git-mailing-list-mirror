Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1E21F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJKABJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 20:01:09 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46978 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKABJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 20:01:09 -0400
Received: by mail-ot1-f47.google.com with SMTP id o21so5975599otb.13
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyWDYeMqzjtjoyfN3ZLEO6rWq0oVY/k8xoTN06Rfrz4=;
        b=NYPujQqluAIzJtmgtY9/4g1RsAfO/E0a72Sisi5kCVjua2k1+2u59SGaXFCoTu5OBD
         vJ/zjozDfMpQFQcnwZW628+xDVSm9AEmFJttM1ZquIB937lhx5XrcvOGG2rlfZWPPyce
         9En7ePGCQpQFvhHhnwe6TUNps8Ywgg8oeGb0exap+hdM4OcJ4jnXREW3v3uDEmgPCBd9
         bWx9LLzCPO9e0asJyhBaMoLsLTqd9aYe2cFmwC3mW53IwUd2OP6RpeCOXIwrtH+s+UXL
         PXU4oMriOYKBxN20XTHzcxX6U5bDlvsO0MMduEtFA8FlHxU1yBs/quvPJl9Twa2ayOpE
         cfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyWDYeMqzjtjoyfN3ZLEO6rWq0oVY/k8xoTN06Rfrz4=;
        b=IWxvrENtkA4PqcOeksjSEy2DMfs8Xx+Ppvz/C66D5/gMLupQRLnJ1g733gtL41EToD
         Q2a2d1d6JpCeSLTsFqWftZKE64jDtUC0W+j/aIie54A5mvyfvoeupit6ZJSE361vCXe4
         yLI2t2xhoBIHo51ZL54EMUsBcqQEI2yamIznDU/V3XqGv8emLCiugrXsQjbNV3sw1s0P
         mdh/HA3yHmTek4qH7ujm4+oJhMFQ31X/Mr9lN4gpR3LEPczQqXW3Q5Ixhrfde2tUc0z9
         5AR14SFMLJ1/9+Cb7rlACk6XY4rJsPAEqotgIb2+Hj7FQaeZfkRQLpv5RSJHUvN/ZOKj
         HtPw==
X-Gm-Message-State: ABuFfojPWNFuU67QOWbx0KJz9ex8++okJ3j9JoC20m/nxrlH+B/U/0uk
        DzTQ6YgIwQCTZwIFK4+cxFqRuQjhQB9zwRUS5C8=
X-Google-Smtp-Source: ACcGV60dfLUaiVY2Dk739ZF15Z6EzntRMK60jbtncYOD8+2Zb3TqgYD/RDj5CIYMNaDIx/8NncN9a7h/vQOUogXVe1g=
X-Received: by 2002:a9d:4a0a:: with SMTP id h10mr5264862otf.96.1539189491723;
 Wed, 10 Oct 2018 09:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
 <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
 <20181009234502.oxzfwirjcew2sxrm@dcvr> <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
 <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
 <878t36f3ed.fsf@evledraar.gmail.com> <xmqqzhvmkn4z.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhvmkn4z.fsf@gitster-ct.c.googlers.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 10 Oct 2018 12:38:00 -0400
Message-ID: <CACPiFC+sPTSa6WRp8iy3e_qKVD46Z9VsXA-UnMhv-ygpZbUCaw@mail.gmail.com>
Subject: Re: git svn clone/fetch hits issues with gc --auto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 8:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> We probably can keep the "let's not run for a day" safety while
> pretending that "git gc -auto" succeeded for callers like "git svn"
> so that these callers do not hae to do "eval { ... }" to hide our
> exit code, no?
>
> I think that is what Jonathan's patch (jn/gc-auto) does.

+1

`--auto` means "DTRT, but remember you're running as part of a larger
process; don't error out unless it's critical".

cheers,


m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
