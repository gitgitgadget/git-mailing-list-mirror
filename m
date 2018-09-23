Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2DF1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 19:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeIXBxL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 21:53:11 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21841 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXBxL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 21:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537732469; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=MxKaAgdki0f9xnglRyCM2CZHbxCmVhNPzbD2ucujj9GMyFjg/9n9DQYunM40objWImVhzEV0q6ikjDM77Ox+j5iP5xXsj1fh9h8ObKnVfpDXlAmKkj43uE/KD1niHQxIhN/6DC+ELEOJwVwsr4f4jR9xanAFO4ONszQB9NFqJw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537732469; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=IIOCww7a3hH7m91YjpwrglVO8uG+siqNfdp8uwYCbXw=; 
        b=el0G6D8QC9x87PXCi2KDPazjL1/6cLewoBV5ihCcRvbXXxT8nM/xjgBGgTpQOkG9hE+do/w7SDecOF03hvJiAaLJ/jaFMIm8o3oiZpb5T7wRvEmzKG1iNPeSb3HJtpCRFUE0vhzOgmEFzOpcsycbR7L8nozEWTw4G8HJRhEwqdk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43]) by mx.zohomail.com
        with SMTPS id 1537732467144513.7637095312308; Sun, 23 Sep 2018 12:54:27 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w21-v6so944738lff.6
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 12:54:26 -0700 (PDT)
X-Gm-Message-State: APzg51BQwOnYTz+EFSEftuEJiEuGwdr9KTv4PiHBVr2IhczT0jdwTu9w
        KW34M5d0Go3dLM6VT7BeW4hrSBOAg8eplTKQxhw=
X-Google-Smtp-Source: ANB0VdZ1yNoBmSNq8C3J/yoeDLFfEr4dW4zIebZ5HF/caB9VFpru9ZiRNLtgzBXPdo2L3UEq4yFnW9n83YFG5rVp2ZM=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr4047464lfi.72.1537732465379;
 Sun, 23 Sep 2018 12:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net> <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com> <000501d45366$cf437060$6dca5120$@nexbridge.com>
In-Reply-To: <000501d45366$cf437060$6dca5120$@nexbridge.com>
From:   John Austin <john@astrangergravity.com>
Date:   Sun, 23 Sep 2018 12:53:58 -0700
X-Gmail-Original-Message-ID: <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
Message-ID: <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
Subject: Re: Git for games working group
To:     Randall Becker <rsbecker@nexbridge.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        id@joeyh.name, Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 10:57 AM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>  I would even like to help with your effort and have non-unixy platforms I'd like to do this on.
> Having this separate from git LFS is an even better idea IMO, and I would suggest implementing this using the same set of build tools that git uses so that it is broadly portable, unlike git LFS. Glad to help there too.

Great to hear -- once the code is in a bit better shape I can open it
up on github. Cross platform is definitely one of my focuses. I'm
currently implementing in Rust because it targets the same space as C
and has great, near trivial, cross-platform support. What sorts of
platforms are you interested in? Windows is my first target because
that's where many game developers live.

> I would suggest that a higher-level grouping mechanism of resource groups might be helpful - as in "In need this directory" rather than "I need this file". Better still, I could see "I need all objects in this commit-ish", which would allow a revert operation to succeed or fail atomically while adhering to a lock requirement.
> One bit that traditional lock-brokering systems implement involve forcing security attribute changes - so an unlocked file is stored as chmod a-w to prevent accidental modification of lockables, when changing that to chmod ?+w when a lock is acquired. It's not perfect, but does catch a lot of errors.

Agreed -- I think this is all up to how the query endpoint and client
is designed. A couple of different types of clients could be
implemented, depending on the policies you want in place. One could
have strict security that stored unlocked files with a-w, as
mentioned. Another could be a weaker client, and simply warn
developers when their current branch is in conflict.

