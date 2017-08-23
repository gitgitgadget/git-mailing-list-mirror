Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02011F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 22:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdHWWm5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:42:57 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:47899 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdHWWm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:42:56 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id keMQd8pASlmqOkeMQdZ4k1; Wed, 23 Aug 2017 23:42:55 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=cJvsqIBe4VOkT2rzYjgA:9
 a=wPNLvfGTeEIA:10
Message-ID: <D0634C4264E4400492C9424041D7AF02@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Stephan Beyer" <s-beyer@gmx.net>
Cc:     "Git" <git@vger.kernel.org>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com> <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net> <alpine.DEB.2.21.1.1708231639470.19382@virtualbox>
Subject: Re: [BUG] rebase -i with only empty commits
Date:   Wed, 23 Aug 2017 23:42:55 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170823-12, 23/08/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDFD9U2SYV/auJ9ihY/70JUw0CsbrCu/zKatOLf/hRa+x3Xk1PKPCXUTGUx1aoAS6id2LMPVWpAQvfzqF/GlX4+eonz8K+Cd0Pclfq9rZnZIS7R+sD4t
 eXwsUtKjtxZjKKnETKy2o2ixamYv4ESrPwWEExM6mg0SZMFWdprSeVvcRaDsgfIQn02AbATF8EDsFiHo16jGMuUyBGQygvafdifPgExUPfwFNRUpwRny4PLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
<snip>

>> So the problem seems to be that rebase -i (like rebase without -i)
>> considers "empty commits" as commits to be ignored. However, when using
>> rebase -i one expects that you can include the empty commit...
>>
>> Also, the behavior is odd. When I only have empty commits, a "git rebase
>> master" works as expected like a "git reset --hard master" but "git
>> rebase -i" does nothing.
>>
>> The expected behavior would be that the editor shows up with a
>> git-rebase-todo like:
>> # pick 3d0f6c49 empty commit
>> # pick bbbc5941 another empty commit
>> noop
>
> These days, I reflexively type `rebase -ki` instead of `rebase -i`. Maybe
> you want to do that, too?
>
> Ciao,
> Dscho

Is the -k option actually documented? I couldn't see it in the man pages. 
I'm guessing it's the same as `--keep-empty`.
--
Philip 

