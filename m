Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5818208B8
	for <e@80x24.org>; Mon, 14 Aug 2017 07:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdHNHiI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 03:38:08 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:37399 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdHNHiH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 03:38:07 -0400
Received: by mail-lf0-f50.google.com with SMTP id m86so36222696lfi.4
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whiteoctober.co.uk; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X6bMuAPsZBrWOPQBpgQblISDdPljZ5YoQo1iXD3nUsA=;
        b=p3JKHqmBmcgUWH/zDcTaFemWAyG7tC3BgphQL7m9DkMbNujyy+ZdqjEXqfo08szUM2
         0rxROM+OJ0nicBv2tppU5VHl/lt5bMeln3ucmwHzvMNyLAeZZEZx3wPpF1AcrHW0yDp9
         uDVZwGWJQu9NuDMgoUnXYGNCE263i44LtBvog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X6bMuAPsZBrWOPQBpgQblISDdPljZ5YoQo1iXD3nUsA=;
        b=hJfFBQqEptFIEirDpH24kkHoRmB0X/wcV3DWS9/rxMOjqv9qF3WQV5u3ED8MVwrBWB
         4YekXYX8dvOmyza3ovlFzJxInJtg2h0DrrU7WgfkJ2Mm6eZoELwStGUuKZmUjsYET9nB
         XQnWNjjONrd5n3zgLZuwSbcCcutaFQod2KaFw+LR0ZIORhXBsHaVgVBRmG5PlWdoOLlf
         T8IBRAADqIVX1hqr3LoX0U9C4xwnYSBIOFohSJqkeZFGOCYP7Bqhw+zvmV/oiYINuBvK
         Q8utjKRVgHjKzCxOeoGMavQ9jR8OwlGW+clT+eYPuJzPuAx2bR3wjjkq5ktosK/1qH4C
         Hw/Q==
X-Gm-Message-State: AHYfb5hr/10Sg4bwOTNgUnWf4WHTD/RMiKMGAKa7KLxza0IkzhwMCwuK
        volGc0qCeLdnl1p8r+WSBg1kKJwZRGsW+qk=
X-Received: by 10.25.196.23 with SMTP id u23mr8400345lff.238.1502696286099;
 Mon, 14 Aug 2017 00:38:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.83.156 with HTTP; Mon, 14 Aug 2017 00:38:05 -0700 (PDT)
In-Reply-To: <20170814044756.GA8587@alpha.vpn.ikke.info>
References: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
 <20170814044756.GA8587@alpha.vpn.ikke.info>
From:   Sam Partington <sam@whiteoctober.co.uk>
Date:   Mon, 14 Aug 2017 08:38:05 +0100
Message-ID: <CAPuLQgPt=NPtd=14BLZ+q8zJyFGOdxNZQX7F1OCdhGrgkFB1+A@mail.gmail.com>
Subject: Re: Bug when stashing previously-ignored file plus associated
 .gitignore change
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Kevin,

Yes, you're right - I didn't commit the change to the .gitignore file,
so that addition is also being stashed.

Thanks
Sam
Sam Partington
Senior Developer



www.whiteoctober.co.uk
Office: +44 (0)1865 920 707

This email message and any attachments are confidential and solely for
the use of the intended recipient. If you are not the intended
recipient, you have received this message in error. Please notify us
immediately and delete the message from your computer. You should not
distribute, copy or disclose its contents to any other person. Any
views or opinions expressed in this email are solely those of the
author and do not necessarily represent those of White October
Limited. White October is a private limited company registered in
England & Wales under registration number 3982889. The company=E2=80=99s
registered office is at 264 Banbury Road, Oxford, OX2 7DY.


On 14 August 2017 at 05:47, Kevin Daudt <me@ikke.info> wrote:
> On Fri, Aug 11, 2017 at 04:55:38PM +0100, Sam Partington wrote:
>> Hi there,
>>
>> I'm running git 2.7.4 on Ubuntu 16.04.  I've found a couple of
>> problems when "un-ignoring" files in tandem with git stash.
>>
>> Here's how to reproduce:
>>
>> Say you have a project using git, with a .gitignore file which
>> contains the following line:
>>
>> bin/*
>>
>> You can then see the problems by doing this:
>>
>> $ touch bin/mynewfile # this file will be ignored at this point >
>> and then updating .gitignore to look like this (adding that second line)=
:
>>
>> bin/*
>> !bin/mynewfile
>>
>> So far, so good; the new file is no longer ignored.
>>
>> But now, try stashing the changes and including untracked files in the s=
tash:
>>
>> $ git stash save -u
>>
>> Here's the first problem, bin/mynewfile is still there:
>>
>> $ ls bin/mynewfile
>> bin/mynewfile
>>
>> But you'd expect it to not be there and be in the stash, I think.
>> This is what would normally happen with the untracked-files option for
>> git stash.
>>
>> This leads to the second problem - you can't now pop the stash:
>>
>> $ git stash pop
>> bin/mynewfile already exists, no checkout
>> Could not restore untracked files from stash
>>
>> If you want to apply the stash, you have to remove the file:
>>
>> $ rm bin/mynewfile
>> $ git stash pop # this works, and re-creates bin/mynewfile
>>
>> This is quite an unusual edge case, but I have hit it two or three
>> times now and so thought it worth reporting, but I'll understand if
>> it's deemed not worth fixing!
>>
>> Do let me know if you need any more information from me here.
>>
>> Thanks
>> Sam
>>
>> PS Sorry for the lack of formatting - I'm sending this as plain text
>> as my original HTML emails was rejected as possible spam by your
>> mailserver.
>>
>> Sam Partington
>> Senior Developer
>>
>
> Hello Sam,
>
> Is it the case that you did not commit the addition of '!bin/mynewfile'
> yet? I suspect that by running git stash save -u, you also are stashing
> this addition to the .gitigore file. Can you confirm this?
>
> Kevin
