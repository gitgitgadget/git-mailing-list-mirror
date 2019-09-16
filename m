Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408181F463
	for <e@80x24.org>; Mon, 16 Sep 2019 17:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfIPRt5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 13:49:57 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48721 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfIPRt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 13:49:57 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 13313C0004;
        Mon, 16 Sep 2019 17:49:53 +0000 (UTC)
Date:   Mon, 16 Sep 2019 23:19:50 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     David <bouncingcats@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Git Gui - enhancement suggestion - Can a double =?utf-8?Q?cli?=
 =?utf-8?Q?ck_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move?=
 =?utf-8?B?IHRoZSBpdGVtIHRvIOKAnHN0YWdlZCBjaGFuZ2Vz4oCd?=
Message-ID: <20190916174950.so6ku57hyr35ivy4@yadavpratyush.com>
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com>
 <CAKPyHN0=AHzr1V35PDzsq02aeGK1e54CxTeunED_u6GRUygkuA@mail.gmail.com>
 <CAMPXz=qWmHGpDrGVpg1gwEBQsg5pujY-Ghg8icyaPoiMNCXssg@mail.gmail.com>
 <20190914190656.r2aogh4dcobay5vn@yadavpratyush.com>
 <CAMPXz=oC29Wr16KPp_jJ5gFi7N2AN3tqnHX38FkszR32PH5M+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMPXz=oC29Wr16KPp_jJ5gFi7N2AN3tqnHX38FkszR32PH5M+Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/19 01:41PM, David wrote:
> On Sun, 15 Sep 2019 at 05:08, Pratyush Yadav <me@yadavpratyush.com> wrote:
> > On 15/09/19 02:07AM, David wrote:
> > > On Sat, 14 Sep 2019 at 06:51, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> 
> > > > I consider adding a second way as not not acceptable. I also consider
> > > > double-click on a file in a GUI an "open" action.
> > >
> > > Yes!
> > >
> > > In fact, I've often fantasized how useful it would be that if I double
> > > clicked on that file name in the unstaged pane or the staged pane,
> > > then that would open the file for editing in my preferred/configured editor.
> > >
> > > Now for me *that* would be a very frequently used improvement!
> > >
> > > I wonder what other readers think about this idea?
> >
> > Sounds reasonable. I've wanted something similar, but for commit
> > messages.
> >
> > But one major reason I didn't come up with a patch for editing commit
> > messages in the editor of your choice is terminal based editors.
> 
> Hi again Pratyush Yadav, and other readers!
> 
> I hope I don't sound like I am arguing or enthusiastically promoting change
> in this subthread. I'm not, my attitude is rather just to explore an idea to see
> what others think of it. Some days I have good ideas, other days my ideas
> have flaws that I missed, so I like to discuss first.
> 
> More important, I want to say that I am very happy to see that there are
> folks interested to discuss the Tcl/Tk git GUI tools. In fact I have local Tcl
> patches myself, bugfixes and enhancements for git-gui and gitk, which I
> would be happy to share except that I do not know how to do that effectively.
> 
> I don't enjoy Tcl and because of that I have avoided it and don't consider
> my skill level to be very high. I find it rather obtuse, especially the way
> it does namespacing, and "upvar" in particular. I struggle to read it without
> comments. But I learned enough of Tcl specifically to improve aspects
> of git-gui and gitk that were bothering me in the past.

I have quite the opposite experience with Tcl. I've been a C person for 
a long time, and was never a big fan of scripting languages. But I have 
been enjoying hacking in Tcl. But I do agree that some parts of Tcl are 
rather strange, and not easy for readability.

I'd be happy to look at your enhancements, and try to fine tune the 
code, but I would point out that some things might just be too specific 
to your workflow, and won't work for the rest of the people using 
git-gui. So do take that into account if you do decide to send some 
improvements in.
 
> As well as bug fixes, I have enhancements to both that greatly assist
> my workflow. For example, in git-gui, I have a hotkey that pastes the
> currently highlighted pathname into the commit message. In gitk,
> I have added "find all files in commit" to the file list pane, and fixed
> the flawed regex matching and associated controls.

FYI, I'm not the maintainer of gitk. So patches for it should be sent to 
Paul Mackerras <paulus@ozlabs.org>.
 
> My workflow involves a lot of large rebases, and merge conflicts can occur
> in the middle of them that affect dozens of files, that need editing
> to resolve. That's where easily being able to start an editor from git-gui
> in that situation would benefit my workflow. But, it's not a big deal.
> 
> Now, to specific comments you made:
> 
> > I don't
> > think there is any way of finding out the default terminal emulator in
> > Linux, and I don't think there is a standard way of making terminal
> > emulator launch programs you want.
> 
> I agree where you say there is no "standard way", because the
> various GUI environments are not consistent (Gnome, LXDE, etc) and
> neither are the command line arguments of various terminal emulators,
> and sometimes those don't work as expected.
> 
> > So your suggestion works only for GUI based editors. We would have to
> > mention that only GUI based editors can open files.
> 
> Here, I disagree. My suggestion was to provide a double-click facility
> that would trigger a command that can be *configured by the user*.
> 
> And it is wrong to say that only GUI editors can open files.
> For example, my OS is Debian, my GUI is LXDE, and my terminal
> emulator is lxterminal. (I don't recommend it, but that's another story).
> If I have a terminal window open, I can type the command:
>   $ lxterminal -e vi foo

Ah! I have used this many times (for gnome-terminal), but for some 
reason it didn't occur to me to have a customizable editor command. 
FWIW, I am in favor of something like this being used in git-gui.

> and a new independent terminal window opens with the editor 'vi'
> editing the file foo. Similar functionality can be achieved from a
> .desktop file, or from a shell script.
> 
> Here is a demo Tcl script (working here) that confirms one way
> of spawning an editor from Tcl in a terminal window under LXDE:
> 
> ##### begin script #####
> #!/usr/bin/tclsh
> 
> package require Tk
> 
> # name of this script
> set scriptname [info script]
> 
> # demo user command
> set command "lxterminal -e vi -R $scriptname"
> 
> # create text widget
> pack [text .t]
> 
> # add text to show that we are running
> .t insert end "$scriptname: Running: $command\n"
> 
> # run the demo command
> set chan [open "| $command"]
> 
> # (at this point, a new terminal window appears
> # containing vi displaying this script file)
> 
> # add text to show that we did not block on command
> .t insert end "$scriptname: Reached end\n"
> 
> ##### end script #####

If you would volunteer to send patches implementing something like that, 
I would be happy to review. As for me doing it myself, I can't really 
say if or when I can get to it. I have limited time available, and there 
are some other things I'd rather do first.

-- 
Regards,
Pratyush Yadav
