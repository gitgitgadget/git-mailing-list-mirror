Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7601F51C
	for <e@80x24.org>; Thu, 17 May 2018 20:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEQUEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 16:04:00 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:9469 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQUEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 16:04:00 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 May 2018 16:03:59 EDT
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id JP07f6wkbpXFjJP0AfoykY; Thu, 17 May 2018 20:55:51 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=zW9DtTB3AAAA:8 a=NEAV23lmAAAA:8 a=zNDc8X-QtL_sdQQ7A6MA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=BHSfcOUB-Usa-PfFCJ-o:22
Message-ID: <2DABB84AEA714D88B73ECF6FA3170BF5@PhilipOakley>
Reply-To: "Philip Oakley, CEng MIET" <philipoakley@theiet.org>
From:   "Philip Oakley, CEng MIET" <philipoakley@theiet.org>
To:     "Bartosz Konikiewicz" <izdwuut@gmail.com>, <git@vger.kernel.org>
References: <CAAdU=LtfkKOKnJJC9yvxG+dZxqUh-Pwa5=ra1DOTfxQSY3e6qg@mail.gmail.com>
Subject: Re: Troubles with picking an editor during Git update
Date:   Thu, 17 May 2018 20:55:43 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180517-4, 17/05/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfP08ng3axW/kGoWheuTjCU2KV29sSoEAkI1CjqW7ynKf33akelceU5tWQFqAzRKmCnKHKv8vuvY5YCTja+WkcO3kT4CZ7qu0PKYgtVpP0V/lgnkejNHq
 Ma6qYtNLgsaWU/PdtaseVwSQN4wJaJThqaUmNBijSQL/kkoKare300FnG1+xKNDvwyBjmW4qIcfiRbQgI1uVVB9RVCxTBvnz9N8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bartosz,

From: "Bartosz Konikiewicz" <izdwuut@gmail.com>
> Hi there!
>
> I had an issue with Git installer for Windows while trying to update

The Git for Windows package is managed, via https://gitforwindows.org/, as a 
separate application, based on Git.

> my instance of the software. My previous version was "git version
> 2.15.1.windows.2", while my operating system prompted me to upgrade to
> "2.17.0". The installer asked me to "choose the default editor for
> Git". One of these options was Notepad++ - my editor of choice. Vim
> was selected by default and I've picked Notepad++ from a drop-down
> list. As soon as I did it, a "next" button greyed out. When I moved
> back to the previous step and then forward to the editor choice, the
> "Notepad++" option was still highlighted, and the "next" button wasn't
> greyed out anymore - it was active and I was able to press it and
> continue installation.
>
> Steps to reproduce:
>
> 1. Have Notepad++ 6.6.9 installed on Windows 10 64-bit 10.0.17134 Build 
> 17134.
> 2. Use an installer for version 2.17.0 to upgrade from version 2.15.1.
> 3. On an editor selection screen, choose Notepad++ instead of Vim. You
> should be unable to continue installation because of the "next" button
> being disabled.
> 4. Press "prev".
> 5. Press "next". Notepad++ should be still highlighted, and the "next"
> button should be active, allowing to continue installation.
>
> I find it to be a crafty trick to make me use Vim. I have considered
> it for a good moment.
>
The best place to report the issue, and perhaps contribure is via the 'GfW' 
Issue tracker https://github.com/git-for-windows/git/issues.

Building Git for Windows via the SDK has become even easier with recent 
updates, so it should be relativley easy to spot the offending line in the 
installer and perhaps even propose a PR (Pull Request) to fix the issue.

regards
Philip

