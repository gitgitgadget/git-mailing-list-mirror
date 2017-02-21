Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9624D201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 22:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbdBUWkD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 17:40:03 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:21332 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdBUWkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 17:40:01 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id gJ6Ec7HCy46SJgJ6Ec5kQZ; Tue, 21 Feb 2017 22:39:59 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=RtkAZsoME_M8jf8qGmgA:9 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <2C3983FC41474DCC880C1E53149DFBE0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Alex Hoffman" <spec@gal.ro>
Cc:     "Oleg Taranenko" <olegtaranenko@gmail.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Stephan Beyer" <s-beyer@gmx.net>, "git" <git@vger.kernel.org>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>   <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com> <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com> <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com> <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com> <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com> <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com> <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com> <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com> <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com> <ca1ef8f6-58cf-4994-d1bf-39e04b42dd4c@gmail.com> <4C20E99781EC4D6D82D48FBF9D9472A1@PhilipOakley> <CAMX8fZUR4h0T3hBmh6Z_0=f5LHFJetOi-vO_JJgnYPB7KjU_bg@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
Date:   Tue, 21 Feb 2017 22:39:58 -0000
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
X-CMAE-Envelope: MS4wfDbV432lgcAohAVVG28Wkk3xT0iUtVXeY3KVU5qFVzFvXAFCduNTyv4Ub9I9d2zVJnGQm3d+PdlKn/5CKrXhDUjmUOqL5EbNM3/8JY/RvZsx8uvD7M1j
 jlrLrt277R/x9bTrAibov1FsN1a0zuWU9kPoAncPk6CcFK/jBZSr3y3xk4TGI1IP16QGIYzhIyy2xIi/Kemv566bO2m2HUMxJ5Zs1oyZz0wUJ8eeDdZz9jTj
 iTA+aRdnqaK6pqfoSHB1KiOiiwoSPZi7qUfsJgYeAvm2jcm10btUH44hFQexHWRe/l7egJ44uDlubgXkIBCtQdOIi+/VAGESswWPSZ58CRzi/H6iqo0uP3oZ
 Z1ffLKwg4s4CmQM3gR+UjKDWkxBCRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Alex Hoffman" <spec@gal.ro>
>> isn't that spelt `--ancestry-path` ?
>> (--ancestry-path has it's own issues such as needing 
>> an --first-parent-show
>> option, but that's possibly a by the by)
>
> Indeed it is spelled `--ancestry-path`. And interestingly enough you
> may use it multiple times with the wanted effect in our case (e.g when
> the user has multiple good commit and a single bad commit before
> running the bisect itself).

> Also it is `--first-parent` (not `--first-parent-show`),

My spelling was deliberate ;-)

If you use the currently coded --first-parent with a properly relevant 
commit for --ancestry-path then you get nothing. The purpose of 
ancestry-path is to find the ancestry chain that deviates from being a 
first-parent traversal [1], but the first-parent want to hold the walk to 
just the first parent chain - a contradiction.

Adding the -show at the end is my attempt to indicate that it is for the 
second aspect, that of selecting which commits to show/use.

I had an initial discussion back at [2], but failed then too.

> but I do not understand why do we need this
> option? What kind of issues does `--ancestry-path` have?
>
> Best regards,
> VG
>
--
Philip

[1] \git\Documentation\technical\api-revision-walking.txt ["two 
diff_options, one for path limiting, another for output"]
[2] 
https://public-inbox.org/git/2FA1998250474E76A386B82AD635E56A@PhilipOakley/ 

