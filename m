Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5A020958
	for <e@80x24.org>; Fri, 31 Mar 2017 11:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754345AbdCaL3d (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 07:29:33 -0400
Received: from smtpq1.tb.mail.iss.as9143.net ([212.54.42.164]:34548 "EHLO
        smtpq1.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752409AbdCaL3c (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 07:29:32 -0400
Received: from [212.54.42.135] (helo=smtp11.tb.mail.iss.as9143.net)
        by smtpq1.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1ctukD-0007I6-3V
        for git@vger.kernel.org; Fri, 31 Mar 2017 13:29:29 +0200
Received: from 53546d64.cm-6-5b.dynamic.ziggo.nl ([83.84.109.100] helo=jessiehernandez.com)
        by smtp11.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <git@jessiehernandez.com>)
        id 1ctukD-0008HG-19
        for git@vger.kernel.org; Fri, 31 Mar 2017 13:29:29 +0200
Received: by jessiehernandez.com (Postfix, from userid 112)
        id 4161C20278; Fri, 31 Mar 2017 13:29:26 +0200 (CEST)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id CB36220274;
        Fri, 31 Mar 2017 13:29:03 +0200 (CEST)
Received: from 217.150.190.17
        (SquirrelMail authenticated user jessie)
        by mail.jessiehernandez.com with HTTP;
        Fri, 31 Mar 2017 13:29:04 +0200
Message-ID: <2db3bf6de4e169f0c116ba77b74998b4.squirrel@mail.jessiehernandez.com>
In-Reply-To: <20170331105803.814cef2ce06b9171901206f4@domain007.com>
References: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
    <916067befdc828e5d33dd3c1817989e7.squirrel@mail.jessiehernandez.com>
    <20170331103330.5d7c414b6a0273cefb8508f2@domain007.com>
    <ff7628d7c69ecd3d212b29fec33f6ba1.squirrel@mail.jessiehernandez.com>
    <7447cca107bbc922877f8b80e9f3d934.squirrel@mail.jessiehernandez.com>
    <20170331105803.814cef2ce06b9171901206f4@domain007.com>
Date:   Fri, 31 Mar 2017 13:29:04 +0200
Subject: Re: ttk error when starting git gui
From:   "Jessie Hernandez" <git@jessiehernandez.com>
To:     "Konstantin Khomoutov" <kostix+git@007spb.ru>
Cc:     git@jessiehernandez.com, "David Shrader" <dshrader@lanl.gov>,
        git@vger.kernel.org
Reply-To: git@jessiehernandez.com
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.109.100
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=M/c9E24s c=1 sm=1 tr=0 a=O0j+lLEKKvAiBX9A7DJArw==:17 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=CdBCPKDxAAAA:8 a=Auuf5dQBuF5Cb3-FI6QA:9 a=wPNLvfGTeEIA:10 a=lDjxF1AZmdN7bNtopFhl:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, 31 Mar 2017 09:53:38 +0200
> "Jessie Hernandez" <git@jessiehernandez.com> wrote:
>
> [...]
>> >> It's possible to have ttk with 8.5 as well (say, here on Debian 8.5
>> >> ships with ttk enabled).
>> >>
>> >> A proper patch would be
>> >>
>> >> -set default_config(gui.usettk) 1
>> >> +set default_config(gui.usettk) [namespace exists ::ttk]
>> >>
>> >> Could you please test it on your system?
>> >>
>> >
>> > Yeah that seems to work.
>> > Thanks for this.
>> >
>> > I have tried it with git 2.12.2
> [...]
>> I spoke to soon. :(
>> It does not work. I forgot to do a install when testing.
>> Sorry for the confusion.
>
> Care to elaborate on the exact error, please?
>

The error I get is the following

Error in startup script: wrong # args: should be "ttk::style theme use theme"
    while executing
"ttk::style theme use"
    (procedure "ttext" line 4)
    invoked from within
"ttext $ui_workdir -background white -foreground black \
	-borderwidth 0 \
	-width 20 -height 10 \
	-wrap none \
	-takefocus 1 -highlightthickness 1\
	..."
    (file "/usr/libexec/git-core/git-gui" line 3190)



