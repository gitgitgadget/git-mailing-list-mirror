Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8692D1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 21:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeCGVwl (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 16:52:41 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41346 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 16:52:40 -0500
Received: by mail-ot0-f170.google.com with SMTP id w38so3518683ota.8
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 13:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZRgFvOV7XOZccnzZlXU7cbUvw0aSG1O+T0PDUXnQ1kg=;
        b=RfyQ/VD9bo1qu/MBNp11j6uF69JmpRME06jKneUfN7fdLgdwhNzx3ZX2w0GLkvUEJE
         2d6V0dzTg145B/M0m9Kb4vUmpXAazSy3PatAD1ymML+8MIOLU25/npSBakn93YAnA3rr
         59zDC78fdM8M5HSVlNpEZlrzrrVwhZNiyYak6Qf18X197c3oP+TyK1xkL6CXyayPhyrm
         IwXD3Tn+ZvFVJotLMqFj+3/pz2hM0jVvth6i0eGdlEd/QqlZaswFO12+oa2/0osZy40T
         xtV15rXqDF3m5IHiSB86gAGmV6B9JJJWUww8Z8xKkjubrm4U1CHjQRzYuiLCb433b0Lx
         rY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZRgFvOV7XOZccnzZlXU7cbUvw0aSG1O+T0PDUXnQ1kg=;
        b=fnE4lO4LplKQaVLsT9GvpQnLDZaXjdNp1Py+O+IOwt5AX4L7oxtka7fb4oPl38fPHh
         O7MrvypYR5CrPYstd09x6uroxNMui7XlPPtRQp1fQYfU2zKoBV8D6eQ/vH3JcEpg9QTM
         8klXdl0N6o1ujXS4TOlm0EPybljMa6HjI1+FtkkjsNjDNRSi3g6sjTG4AgQA//FDDsjf
         cF5Xsxky3IWjECZ2HkYVTufEIxMC5+ewJxOalx7weouYELaYJ/FBmva+GY2ne9LP6R1s
         vHdxdRp3gH73VEKMQFMOlqcvZlADMeX9e73zZ5QrUd+/WFhFBW8qBgL+sduOLxUg8oFZ
         5ZYw==
X-Gm-Message-State: AElRT7FihbpeWU2D1ArNwlQfzS2JXAkYjCRNWwtwy3btUWvXKiMot1y7
        pVXU1CDWRQjVTCvRYhPTnny0lCj392dL9Z4buuU=
X-Google-Smtp-Source: AG47ELuBkZvP9YPLURjblIBPqvhHMpEU36lvwdxWJDBY3cU2uVPsTb4IZ//6m/HId5GCUwuP+FvCKT6vZikDEO4iRmc=
X-Received: by 10.157.53.10 with SMTP id o10mr15814210otc.283.1520459559953;
 Wed, 07 Mar 2018 13:52:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.76.9 with HTTP; Wed, 7 Mar 2018 13:52:39 -0800 (PST)
In-Reply-To: <87muzlwhb0.fsf@winehq.org>
References: <20180303034803.21589-1-dorabpatel@gmail.com> <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
 <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
 <xmqqr2oz9rka.fsf@gitster-ct.c.googlers.com> <87muzlwhb0.fsf@winehq.org>
From:   Dorab Patel <dorabpatel@gmail.com>
Date:   Wed, 7 Mar 2018 13:52:39 -0800
Message-ID: <CAE09B1LaKxk7CLaZ7M9vLFx7aJwUpxO25ZH4btXpYuwzo6sVyQ@mail.gmail.com>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
To:     Alexandre Julliard <julliard@winehq.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for updating us with the status of git.el.

The last time I looked at magit, it was too heavyweight for my needs.
I like the simplicity of git.el. But perhaps it's time for me to take
another look at magit.


On Tue, Mar 6, 2018 at 3:54 AM, Alexandre Julliard <julliard@winehq.org> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Having said that, I am sorry to say that I am not sure if the copy
>> we have is the one to be patched, so I would appreciate if Alexandre
>> (cc'ed) can clarify the situation.  The last change done to our copy
>> of the script is from 2012, and I do not know if Alexandre is still
>> taking care of it here but the script is so perfect that there was
>> no need to update it for the past 5 years and we haven't seen an
>> update, or the caninical copy is now being maintained elsewhere and
>> we only have a stale copy, or what.
>
> This is the canonical version, and I guess in theory I'm still taking
> care of it. However, the need that git.el was originally addressing is
> now fulfilled by better tools. As such, I feel that it has outlived its
> usefulness, and I'm no longer actively developing it.
>
> I'd recommend that anybody still using it switch to Magit, which is
> being actively maintained, and IMO superior to git.el in all respects.
>
> --
> Alexandre Julliard
> julliard@winehq.org
