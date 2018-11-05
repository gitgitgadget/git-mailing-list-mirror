Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6831F453
	for <e@80x24.org>; Mon,  5 Nov 2018 12:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeKEVpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 16:45:41 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:32132 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKEVpl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 16:45:41 -0500
Received: from [192.168.1.12] ([92.29.15.216])
        by smtp.talktalk.net with SMTP
        id JdxIgftVBoI6LJdxIgow0K; Mon, 05 Nov 2018 12:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541420768;
        bh=aCN3hY3zlDWa02b7KQ3UtfwUxlc+1Wo3wg0RYiYeRgg=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=lWoy0fqyOyqcHKDppQT16pPtwo0w9/oiJiOQWOZNCqfYJcC5FZrYirNSfoAmymwd9
         eDhQlTZGavo2GAzOAt1VBctyfN71dvtSVDeT2zq03QVxjCTrc4VYejjA8Lt8KHn9Ca
         g8wXcAZoB9ULc8IzG37yKn2c3d4a3ZDXHZELyLzs=
X-Originating-IP: [92.29.15.216]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=nW19o/PZ5qZJ0p49dqPFUw==:117
 a=nW19o/PZ5qZJ0p49dqPFUw==:17 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8
 a=txqFxXwaAAAA:8 a=5rxgeBVgAAAA:8 a=AVbMHacnAAAA:8 a=VwQbUJbxAAAA:8
 a=h9GtzQcEuS5QHyIiwGUA:9 a=QEXdDO2ut3YA:10 a=PWrjKhWBdF8A:10
 a=H5RkCRLHyEoA:10 a=YJ_ntbLOlx1v6PCnmBeL:22 a=2U7u32ZBAyMuB9OKO3Vn:22
 a=PwKx63F5tFurRwaNxrlG:22 a=AjGcO6oz07-iQ99wixmX:22
Subject: Re: if YOU use a Windows GUI for Git, i would appreciate knowing
 which one and why
To:     _g e r r y _ _l o w r y _ 
        <gerry.lowry@abilitybusinesscomputerservices.com>,
        git@vger.kernel.org
References: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <2f1855a2-58c4-d7d6-cd62-41ce877f11b6@talktalk.net>
Date:   Mon, 5 Nov 2018 12:26:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJW6ZEfHTdMbVTgwpe78vPBlA7IJ6zTABn2BovkYyGt0sneCt+qRDPST4yHR9cVIvrKIO9T+DCogdQr6SvfIX5TcbrJ/Tl5vtSTYZCGHLEiVuiFCEOUN
 trkgvZzlvi7+KCHTx9ublKcA3/M3Iten3S4ZVO5j4ggSZDNsyXGezmFNxxeUDCo60JGoLDJbl56lLRnLnhrVv9yU0eEWVYJ4zh0rlPZHeiQh2AXnsATNfKj1
 IQpVZUHTyohtAwXGOsTxJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gerry,
I'll give my view, as someone approaching retirement, but who worked as 
an Engineer in a mainly Windows environment.

On 04/11/2018 17:48, _g e r r y _ _l o w r y _ wrote:
> PREAMBLE [START] - please feel free to skip this first section
> 
> Forgive me for asking this question on a mailing list.
> 
> stackoverflow would probably kill such a question before the bits were fully saved to a server drive.
> 
> Let me explain why i am asking and why i am not being a troll.
> 
> [a] i'm "old school", i.e., > 50% on my way to being age 72 [born 1947]

8 years behind..
> 
> [b] when i started programming in 1967, most of my work input was via punched cards
'69, at school, post/compile/run/wait for post; 1 week
  (Maths club)

> 
> [c] punching my own cards was cool
Pin punching individual chads ;-)

> 
> [d] IBM System/360 mainframe assembler was cool and patching previously punched card encoded machine code output was a fun risky but
> at times necessary challenge.
Eventually the 370 at university.

> 
> [e] using command windows and coding batch files for Gary Kildall's CP/M and the evil empire's PC/MS-DOS was how i accomplished many
> tasks for early non-GUI environments (i still continue this practice even in Windows 10 (a.k.a. please don't update my PC O/S behind
> my back again versions of MS Windows)).
Engineer in electronics; software was an interlinked part of electronics 
back then....
> 
> [f] my introduction to Git was via a command line based awesome video that has disappeared (i asked this community about that in a
> previous thread).
Discovered in 2011 via 'Code News' article - Spotted immediately that it 
solved the engineers version control issue because it 'distributed' the 
control. I've tried a few of the Gui's.

> 
> BOTTOM LINE:  virtually 100% of my Git use has been via Git Bash command line [probably downloaded from https://git-scm.com/]
> 
> For me, and i suspect even for most people who live with GUI platforms, [a well kept secret fact] using the keyboard is faster than
> using the mouse [especially when one's fingers are already over one's keyboard-example, closing one or more "windows" via Alt+F4.
> 
> Also for me, i am happy to change some code and/or write some new code, Alt+Tab to Git Bash frequently, ADD/COMMIT, then Alt+Tab
> back to whatever IDE i'm using [mostly LINQPad and vs2017]; i know that's quite a bit schizophrenic of me-command line Git but GUI
> IDE.
> 
> PREAMBLE [END]
> ----------------------------------------
> 
> QUESTION:  if YOU use a Windows GUI for Git, i would appreciate knowing which one and why
> 
> i have been asked to look at GUI versions of Git for Windows.
I presume that this is for a client who isn't sure what they want 
http://www.abilitybusinesscomputerservices.com/home.html

> 
> https://git-scm.com/download/gui/windows currently lists 22 options.
That's nearly as bad as choosing a Linux distro ;-)

> 
> if i had more time left in my life and the option, because of my own nature, i'd likely download and evaluate all 22 - Mr.T would
> pity the fool that i often can be.
> 
> CAUTION:  i am not looking for anyone to disparage other Git Windows GUIs.
> 
> Let me break down the question into 4 parts:
> 
> [1a] Which do you prefer:  Git GUI, Git command line?
I use the three parts provided as part of regular Git and Git for 
Windows, that is git-gui, gitk and git cli in a terminal (mintty)

> [1b] What is your reason for your [1a] preference?
I have been in a general Windows environment for decades. The Gui format 
with single buttons/drop downs that do one thing well, without finger 
trouble side effects, is good in such environments. One cannot be master 
of everything.

The cli is good for specialists and special actions, especially 
precision surgery. The key is to avoid the "the surgery was a success 
but the patient died" results.
> 
> [2a] if applicable, which Git GUI do you prefer?
git-gui and gitk are now the only two I use.

> [2b] What is your reason for your [2a] preference?
Many of the other Gui's hide the power of Git and its new abstraction of 
no longer actually being about "Control" (by 'management'). Now it is 
about veracity. If you have the right object ID (sha1/sha256) you have 
an identical original [there are no 'copies', all Mona Lisas with the 
hash are the same]. Management can choose which hash to accept upstream.

Most other Gui's try to hide behind the old school Master-copy view 
point that was developed in the 19th century for drawing office control. 
If you damaged the master drawing the ability to make things and do 
business was lost. Protecting the master drawing was everything. They 
were traced before they went to the blue print machine. Changes were 
batched up before the master could be touched (that risk again).

Too may Gui's (and their Managements!) still try to work the old way, 
loosing all the potential benefits. They are still hammer wielders 
looking for nails, and only finding screws to smash.

I've heard reasonable things about SmartGit but that costs money so I 
haven't tried it. I tried TortoiseGit and GitExtensions, but gave up on 
them as they would (to me) hide the real operations behind old concepts.

The one are that could be improved is having manuals for the two guis, 
and a better explanation, with practical examples, for the gitk viewer, 
which has far more power than I have fully delved into.

Ultimately it is a management problem. As a systems engineer, what needs 
to be researched is the mind set - weltanschauung of the client, their 
management style and its operations.

See the recent discussion with Nicolas Mailhot 
https://public-inbox.org/git/1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net/ 
on the release management issue
> 
> 
> if you are uncomfortable replying to git@vger.kernel.org please feel free to reply directly to my e-mail address.
> 
> i look forward to hearing from members of this Git community.
> 
> Thank you for reading and thank you for your valuable time.
> 
> gerry (lowry)-wasaga beach-ontario-canada
> gerry.lowry@abilitybusinesscomputerservices.com
> 

Education is the answer, especially for the lower quartile.
Kruger & Dunning. "Unskilled and unaware of it" 1999.

-- 
Philip
