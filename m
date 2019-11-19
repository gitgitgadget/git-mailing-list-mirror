Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A7D1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 18:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKSStZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 13:49:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53942 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKSStY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 13:49:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so4387204wmc.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 10:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TpUWxvTOE5WH3w+vWfblheJlhgNd7hDKAauKBlK2q9Y=;
        b=NhAojdtLC/7wDPAT1BDBal+Qv5SmYZogrDjP/3m0mmVtBk6jzs3NPa8lgNxMqH0CFQ
         F5ol0Vhbvek2FHNA7mRKYL/qPfT8cdzbClXmrTPEp+0wrBNae4Uq+1n50AzKOa9wAVPY
         hQaleOzUmF5CP5zIUzOdMD0HF0Lp7vz4zBTrwsEszlAT7kTe4W8FfhNrULBHXDTY+KhH
         hTLP0UiiZ22AHKUxigGw05NXhBv7EztG390kx4BeYaMV2WJJt+kmEv1zu7pqe1Oo2CEi
         MVrz40J7EKszKMNZ5M8L5fbuL3baXJEtfuiXy09OfjznGNnrVNlCZJiCfku9BOzXNSMM
         0ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpUWxvTOE5WH3w+vWfblheJlhgNd7hDKAauKBlK2q9Y=;
        b=auNGtAWWqdguwgSyswWYAWFSG0DuEYJiZFIIxM3Az6x3XGDyxw5k/z1DMmRCchstLa
         E+aa6Bv8XntrYFiwmhAc1ZtOwR/k54/h20ZL++h4Xo7nNT7DIkn4rHd3vy926Itprdrc
         lSsAbHxEjZSNVf7zTYpaAGTTmmVXH79nYPlyUyL8U8kvtyJ9IwFTA55YuPVGQRxA653l
         jmt7+6wcoQs/YWrZWcer9qyBiP3L7Cg7aQW0Orp+LGcY2pGlrEzWm8jenqEElEhvjF1D
         gXKFrMXFK9DvmIPfXgKRGc8ch/mL0jRUIQf/9yxTVG7iWitNtSrJMfw1aMV30tN/g/YO
         Uqvw==
X-Gm-Message-State: APjAAAW4s036Q2KEF4fMpcXB0njUlGeAUK/77ty5VcKVGACjA+KzupK2
        kcCywyN8y+TJz2MWhmvovKo=
X-Google-Smtp-Source: APXvYqxTB6xvXwcCcyebT1gRDtuUFFYGkJrEYB3PCXaA8fmFyyIx+3I6Pz0DHtjgObqB4vJsYnS6Mw==
X-Received: by 2002:a1c:7507:: with SMTP id o7mr7304177wmc.163.1574189362204;
        Tue, 19 Nov 2019 10:49:22 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id m16sm3823731wml.47.2019.11.19.10.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 10:49:21 -0800 (PST)
Date:   Tue, 19 Nov 2019 19:49:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191119184919.GM23183@szeder.dev>
References: <20191115230637.76877-1-emilyshaffer@google.com>
 <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
 <20191118214519.GH22855@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118214519.GH22855@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 01:45:19PM -0800, Emily Shaffer wrote:
> On Sat, Nov 16, 2019 at 12:05:45PM +0900, Junio C Hamano wrote:
> > > +==== https://public-inbox.org/git[git@vger.kernel.org]
> > > +
> > > +This is the main Git project mailing list where code reviews, version
> > > +announcements, design discussions, and more take place. If you fail to receive
> > > +help via the channels above, you can ask your question here. The Git list
> > > +requires plain-text-only emails and prefers inline and bottom-posting when
> > > +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> > > +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> > > +"subscribe git" in the body.
> > 
> > Sounds good; I agree with Denton, especially with the mention of
> > "you must join" on the other mailing list, that it is a good idea to
> > explicitly say that subscription is optional in this entry.
> > 
> > You can ask questions even if you haven't tried other avenues and
> > failed, but this entry makes it sound as if an earlier failure
> > elsewhere is a prerequisite for asking for help here.
> 
> I envision an exchange sort of like this:
> 
> Newbie to git@vger.kernel.org: "I'm having trouble compiling Git and I
> want to write a patch, I'm getting X error"
> 
> Veteran to Newbie, cc git-mentoring, bcc git@vger.kernel.org:
> "Please build with blah flag and paste console output, plus let us know
> system information blah blah blah"

That won't work if the veteran is not registered to the mentoring
list, and we can't assume that the newbie is registered there either.
I don't think that we should send anyone who asked a question here to
somewhere else, especially if that elsewhere requires registration.

> I don't mind the idea of pushing folks to ask on the mentoring list
> first. It's pretty well attended already - just now I count 16 list
> members, a pretty significant majority of which are project veterans. I
> have no problem suggesting newbies ask their questions, which others
> probably had and solved before them, in a space separate from the main
> mailing list.
> 
> Of course if you want to encourage newbies to ask in any of these three
> venues, weighted equally, I can change the language. But suggesting the
> main list as a last resort was intentional.

git@vger is the ultimate source of all wisdom :) and it is openly
accessible for anyone for writing, reading, and searching.  Therefore
these three venues cannot be weighted equally, but git@vger should be
the explicitly preferred venue.  Only if the newbie has some other
preferences should the other two be considered; e.g. if more
interactive, chatty communication is preferred, then try #git-devel.

