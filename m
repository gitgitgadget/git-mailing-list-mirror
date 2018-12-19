Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0F31F405
	for <e@80x24.org>; Wed, 19 Dec 2018 03:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLSDR4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 22:17:56 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:43245 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSDR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 22:17:56 -0500
Received: by mail-pl1-f181.google.com with SMTP id gn14so8787122plb.10
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 19:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=INSJhTBZ2JeYFFy4W30JO9+1veZTs95AaBwdlzE6jq8=;
        b=Ajhl61n1M2bQ+1X84oGdFnKMdRzS2B8ZJ7f6FOwTTFnC/zCym3NgeRvqhif2tn6hoT
         O7BZCQA9S8JIFVS3xQVXH1k2ujN5Nxu2YyR5eiSqCTaz5+YWx6h94nQj5pCIkhrQJDac
         PyIDneelawywAK/dwvJZSWRFa3Q079U9U6b1A4fGG28DR7BHzF5nrxQ27gGvWQz+PD+k
         g9QaOJIAYp2+B1hiD/qx/HsOxAzQ37HnLRnvOF9MxJXDITGFBUqCCo1yO7TWANlsrFi4
         hycRN9aSLGfAW0JBxMKW0ATbg63Zt/soEj38NvnBDT0QyfxCW30ihfh4Bf5usAVk4xzB
         REPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=INSJhTBZ2JeYFFy4W30JO9+1veZTs95AaBwdlzE6jq8=;
        b=SoePpjgOjLC+GUX0yUIvEqg6LGODFh628SpM4wrhOSnJPFKC8a9KO8xN6x8zlEzphy
         9eSMynFyYQB/VX+VPE2ifU2T7TSP0gVj03IxCca4g6F38MjreZjAFYi1QDAb/8WnaQct
         I6mDmoZlBqzWg2HnoBpvt1h9R42Nnr1BjSHq05TGMVs5DxqJwYXynMQ81iRL/1acIYaP
         Qzh1SmsyX4M1wbsaNW/ZZ4b9DJQz5LllBdI/SUGY0TXxBSS44TPWtDIwS+F3hqoj65xZ
         vbCIub2Z5e8NXbRqaRjoVNZEKMlBrDo1TitXPy8Dn+fUoH9w6C1QN7fBvwbUMe3d40KA
         cDNA==
X-Gm-Message-State: AA+aEWYhsYRDWDAr/qnE1XgbOntb5RcJYnYgLh2HQS4UaYZguu+8SP/Z
        OAZ911td3HNH2xAZmzi+zDU=
X-Google-Smtp-Source: AFSGD/UvJr5uZstfLicoc3WOZdSGEh/lNdUSB6tEEycODUft+eQYq5VYeosSveumRrHGdtX5RJkYCg==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr19089423ply.65.1545189475114;
        Tue, 18 Dec 2018 19:17:55 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u6sm17813248pgr.79.2018.12.18.19.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 19:17:54 -0800 (PST)
Date:   Tue, 18 Dec 2018 19:17:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Can git choose perl at runtime?
Message-ID: <20181219031752.GA181843@google.com>
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

John Passaro wrote:

> https://public-inbox.org/git/878t55qga6.fsf@evledraar.gmail.com/
>
> The struggle is that Mac's package manager Homebrew has opted,
> apparently with some finality, to no longer support linking to a user
> perl at build time. PERL_PATH is hard-coded to link to the system
> perl, which means the user needs sudo to install the SSL libraries
> required for send-email. So for send-email to work, you need to either
> sudo cpan or build git yourself. The obvious solution here would be to
> do /usr/bin/env perl, but in the above message Aevar pointed out
> pitfalls with that.
>
> It seems that choosing perl at compile time necessarily comes with
> tradeoffs. So I wonder if there is a way we can support choosing a
> perl at runtime without breaking the existing mechanism of linking to
> perl at compile time.

I haven't carefully looked at your exact proposal, but I just wanted
to offer you my support: yes, I would love to see some solution.
Thanks for looking into it.

It would let me remove this bit of horror from my local build script:

 APIVER_EXPR='@{[sub{use Config; $$Config{api_version}}->()]}'
 XCODE_PERL="/Applications/Xcode.app/Contents/Developer/Library/Perl/5.$APIVER_EXPR/darwin-thread-multi-2level"
 make ... PERLLIB_EXTRA="$XCODE_PERL"

(My apologies.)

[...]
> That does mean we have a new command to support and document: "git
> perl". If it is preferred to keep this hidden as an implementation
> detail, we could call the executable something like "util-git-perl"
> instead so that it doesn't show up when scanning libexec for git
> commands.

Typically we handle this kind of thing by putting a double-dash in
the command name.  See git-sh--setup, for example.

Thanks and hope that helps,
Jonathan
