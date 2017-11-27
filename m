Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2701C20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdK0VUK (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 16:20:10 -0500
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:45070 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751601AbdK0VUJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2017 16:20:09 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Nov 2017 16:20:09 EST
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-12v.sys.comcast.net with ESMTP
        id JQeieBF8VfgCFJQh7eiBml; Mon, 27 Nov 2017 21:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1511817121;
        bh=UiL6fKxjk4y0+mqaicagHEmkig4UoSochtBocqNvHwA=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=CzOYP7l54t5piQjZ59aPPANxhfswkq6wnsd+wtgyOKioUicRPY7d2+1+AyeotGbq2
         O4AbgwG3XdFHgt7kMrLbNsNZGspwpUuycdXdRo6Ua0zRBhOxxE6B/JiZj890YxMCfG
         iFAABUr7rKfVsB1+eZo9f7klq1Y5lGH1PVseaSWNV4ZDItDrakhazq/iOPQ55Oub4D
         5W0qft2Utzxb44SBComKAVAzMp0x13bR+ZPpNqN5bEA/+F5fCGY9FBL+QpIaPlXO/K
         ya57gDUIdLgYm61xnsMYaXvBPRpVbHP7JaRrMSXGpWlJhNpCcMg3C26ygu9NlCEXZ4
         WhKk09hvrfVgA==
Received: from [192.168.1.100] ([73.149.212.147])
        by resomta-ch2-20v.sys.comcast.net with SMTP
        id JQh6evj7ok7fvJQh6eCZl8; Mon, 27 Nov 2017 21:12:00 +0000
Subject: Re: Problem installing Git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     git@vger.kernel.org, git-for-windows@googlegroups.com
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net>
 <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
 <alpine.DEB.2.21.1.1711252312270.6482@virtualbox>
From:   Phil Martel <pomartel@comcast.net>
Message-ID: <63cb0d32-c866-f249-c636-2e034b48836f@comcast.net>
Date:   Mon, 27 Nov 2017 16:12:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711252312270.6482@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfAfEecL5wYEXwCoPsYXTDLxVTbPJIDu/A1B/7UURQgUui04n9ory6kKTXoulFfkilaauV1Atl8CYS+8SBjO/7AArWenVhnZ7DHi64MemQPlThPLn/Mjc
 Yd8FGq626+JB/jaNiqxYshNizZLCWSUb/b/OR0we2y1k1xDb0CH4oKohr8HYT8KgLH9nPuSCu+x19LWPyZZ1uqpZTBIkRyJa0fU3c0mAdoryHOEthXaFj2IL
 emA638jtVNW8ZtshJVOaUlKOubkslc24q+gjTvmJiy5xPC5Qw3w8vnkxuoyUZgruA8Bl00td9J6jgVNnxZk5tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/25/2017 5:16 PM, Johannes Schindelin wrote:
> Hi Igor,
>
> On Thu, 23 Nov 2017, Igor Djordjevic wrote:
>
>> [ +Cc:  Git for Windows mailing list ]
> I have no idea why it claimed that that group does not exist, the email
> address looks correct to me.
>
>> On 23/11/2017 19:51, Phil Martel wrote:
>>> I'm trying to install Git-2.15.0-64-bit.exe onto my Windows 10
>>> machine.  When I run this installer program no matter what options I
>>> try or whether I run as administrator it ends up with an error box
>>> saying "The drive or UNC share you selected does not exist or is not
>>> accessible. Please select another".  I do not see any way of
>>> selecting a drive.  Any suggestions?
>>  From what I could Google around, this seems to be (Inno Setup?)
>> installation related issue...?
> Indeed.
>
>> Do you already have "Git for Windows" installed? If so, does it work
>> if you try uninstalling it first?
> That is a workaround, correct.
>
>> p.s. Note the existence of "Git for Windows"[1] specific mailing list
>> as well, where this issue might belong better.
>>
>> [1] git-for-windows@googlegroups.com
> I think a much better place is the Git for Windows bug tracker (if you
> ever wonder where the bug tracker is, or the home page, or the repository
> or the FAQ, there are links in the upper left of the release notes --
> which probably nobody reads, even if I really try to make them worth the
> while -- and which you can find in C:\Program Files\Git\ReleaseNotes.html
> if you closed the tab after installing Git for Windows).
>
> And indeed, there is already a ticket for this issue:
> https://github.com/git-for-windows/git/issues/1074
>
> The original reporter did not respond to any questions, maybe you can do
> better, Phil?
My case seems similar although it may be different.  I originally had 
Git installed on my C: drive.  A hardware upgrade moved that drive to 
E:.  I was able to link everything back and to run Git Bash (IIRC).

A few weeks later, the E: drive got sick.  The repair shop I went to was 
not able to restore much, but in the course of changes took my DVD drive 
out of the boot sequence which changed the E: drive to D:.  I was able 
to restore most of my files from an external herd disk backup, but the 
backup was from when the disk was C:

I could not run Git when I tried, so I downloaded the latest version 
from git-scm.com.  This failed to install with the  "The drive or UNC 
share you selected does not exist or is not accessible. Please select 
another" error.  I was puzzled because the installation code had not 
asked me to select a drive.  Following Buga's suggestion, I tried 
uninstalling Git.  I believe Windows said it could not find the 
uninstall information, but it did remove Git from the list of programs.  
I also removed Git from the start menu.  The installation then succeeded.

Best wishes,
--Phil
>
> Ciao,
> Johannes

