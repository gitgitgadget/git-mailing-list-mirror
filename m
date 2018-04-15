Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11151F404
	for <e@80x24.org>; Sun, 15 Apr 2018 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeDOVVG (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 17:21:06 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:42702 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeDOVVF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 17:21:05 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 7p55fAWE4lWlT7p55fMHNI; Sun, 15 Apr 2018 22:21:04 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=z0hPu6OjExWM6BeeulkA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Git List" <git@vger.kernel.org>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com> <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley> <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Date:   Sun, 15 Apr 2018 22:21:04 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180415-0, 15/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfAIaJJnxx0Kd9Vc5tC3vY7BQMaYbEns3Fg1QheY5g3N1D9ACDp1CaXbTZsGWOc8vFiYCpOdHY1q1dCS6UpO9YoX/g+N1PgDREHhi2AYBZpxtXvR/lEhn
 p4aAk39x2fUGuF1bAnf5uHFUkThrN1S0FJdKkx9VlShIKTK5Wha/e1D40PlyFunP5+o438votzIfmg7o9+7nxKSWWFkcWNAu/pVtW3AQ7IemqmALrtGlqYrh
 wT6aUslcwZp75h0O3jPlsMSA5awF3HFzeC5+s30bZO8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com> : Saturday, April 14, 2018 4:44 PM
> On Thu, Apr 12, 2018 at 12:06 AM, Philip Oakley <philipoakley@iee.org>
> wrote:
>> I'm only just catching up, but does/can this series also capture the
>> non-command guides that are available in git so that the 'git help -g'
>> can
>> begin to list them all?
>
> It currently does not. But I don't see why it should not. This should
> allow git.txt to list all the guides too, for people who skip "git
> help" and go hard core mode with "man git". Thanks for bringing this
> up.
> -- 
> Duy
>
Is that something I should add to my todo to add a 'guide' category etc.?

A quick search of public-inbox suggests
https://public-inbox.org/git/1361660761-1932-1-git-send-email-philipoakley@iee.org/
as being where I first made the suggestions, but it got trimmed back to not
update (be embedded in) the command-list.txt

Philip

