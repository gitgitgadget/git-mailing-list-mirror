Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EF81F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 22:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdFEWGl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 18:06:41 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38064 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEWGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 18:06:40 -0400
Received: by mail-it0-f49.google.com with SMTP id r63so92264812itc.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Elp6xki82WUNsdPxxED5ygCllQ7uQfoEu97P+Lwo1Pw=;
        b=p2r9Nt8uCzFlujYWFg6y4lICt56MJMd6sE6Lxd1rV/ZMR3q713/VGuRmF/vmMaeey1
         qSjb/PKZLK22jRwehLs0ZF6+t9FwFaxJJ8a2402yMsVCxnEJf8stEyWAWmqDXdgp7hVl
         S3Uxm4nv0YnXyu+prP3IAgsSS9DSQGfVlT+aMzLEctPBd+IXTZ65XBbhIQrPBGiFykkR
         d1i2HNR8oir7xxcZl79/jyMsQsqqASJOUvS7dbTaTAuPAqbgT7+LhFW9RbToaV9fj//m
         FU0rWgWK9J7/jOzQ5WD5tbiKVjTpofkYkY4pih2Iuz6b40XNa7FGZXhNmLnj5keEp87P
         +nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Elp6xki82WUNsdPxxED5ygCllQ7uQfoEu97P+Lwo1Pw=;
        b=iW9dTmGff44RvaVWAh0D+L0EUAjomCD8N6L6YVV3RucrogKxyK0hWT7pE/hT5scvdc
         eKj3kaD4WvvLVGnNLWbk6UQVxunA5/xDeeqvr3/aHY4/iL3ng89C2YNekKtwWhglgeMl
         dx+5WfIPBah+tTVjX7pfWIyul1MAXpmxxUrpwoBHokmLiVD6444UcEmkHgJZfEM8VaTK
         kyujt9IqeGqFQRJ9NVbU98uN5hfMJZol7RT0N3U5z7AXxuV6oJ6T5DZtQxAH9Fpq8MT0
         DAD2YsGq1nB5M66GljNTu1ytdmHW05JqzEDdmki8apzy9EdZXnNbiMxTFKvitHjdQ2zs
         r1/Q==
X-Gm-Message-State: AODbwcBjVncb2A3KJaMfhLhsWGAWkTGhl1kg5mDRG2jg5NZGP6zhF/7x
        fiRYPvA9CK4AcvlRKYs5IjEaA0HNYA==
X-Received: by 10.36.164.67 with SMTP id v3mr2518691iti.71.1496700399423; Mon,
 05 Jun 2017 15:06:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 5 Jun 2017 15:06:18 -0700 (PDT)
In-Reply-To: <1C2B896999CB4549BCAC61EB369E932E@blackfat>
References: <5935C999.5060801@winserver.com> <1C2B896999CB4549BCAC61EB369E932E@blackfat>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 6 Jun 2017 00:06:18 +0200
Message-ID: <CACBZZX7VpmEjbzwGd+S15xVLRrkYRxqcf0LUKF1B7pAsd7Lr4w@mail.gmail.com>
Subject: Re: Git "Keeping Original Dates"
To:     Hector Santos <winserver.support@winserver.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 11:25 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> -----Original Message-----
>> From: Hector Santos
>> Sent: Monday, June 5, 2017 5:14 PM
>>
>> I'm implementing GIT.  If there an option or compile/version that "keep"
> file timestamps?
>
> That is not in the tree data structure, see below.
>
> root@blackfat /projects/tipsoftheday
> $ git cat-file -p head
> tree 4ca3c2a853c8e817d7de8563c331899cace8ee85
> parent 2a33f293df6df0d3978612e41fb1ecd52e2450a5
> author Jason Pyeron <jpyeron@pdinc.us> 1496424815 -0400
> committer Jason Pyeron <jpyeron@pdinc.us> 1496424815 -0400
>
> add JDK to CM
>
> root@blackfat /projects/tipsoftheday
> $ git cat-file -p 4ca3c2a853c8e817d7de8563c331899cace8ee85
> 040000 tree 76094b81b3877b5b27cd4fe518fa0708af3cefed    admin
> 040000 tree c66a88871c285e1485f92be0f8fa47185d94d0b3    client
> 040000 tree 460495af209a580e65b5d0b38132d774ddb283b7    database
> 040000 tree 264b191b036180039f3fd8c5d56c2b6800cb2ca2    doc
> 040000 tree dd128195971f7bafa56371aa6027d7c6bc80f351    middleware
> 040000 tree 7861fd39923950d501d4e39aeac4762f7daaca6b    reports
> 040000 tree 2ad3dedf0313ae775321c88c53741a4b4a7e87b0    tools
>
> I wish it was an allowable extension, the date could be between the mode and
> object type.

Yes it's not part of the tree structure, but in this case you can
simply set/update the mtime to the date of the last commit that
modified the file.

It can be a bit expensive to bootstrap that, and git doesn't help you
along at all, you need to do it via hooks or some script you run, but
that's a neat way to shove it into the datamodel if you need this for
some reason.
