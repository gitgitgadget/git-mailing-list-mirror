Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12353202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 12:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdJ2M1h (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 08:27:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:52045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdJ2M1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 08:27:35 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmOLO-1da0AQ3hrO-00ZvFQ; Sun, 29
 Oct 2017 13:27:32 +0100
Date:   Sun, 29 Oct 2017 13:27:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ben Peart <peartben@gmail.com>
cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fsmonitor: Set the PWD to the top of the working
 tree
In-Reply-To: <16467d0e-b585-17d7-fb22-3eed7efe6747@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710291318300.6482@virtualbox>
References: <20171026013117.30034-1-alexmv@dropbox.com> <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com> <5a389621-961d-48e3-339a-ef182d3ed628@gmail.com> <alpine.DEB.2.10.1710261425390.9817@alexmv-linux>
 <16467d0e-b585-17d7-fb22-3eed7efe6747@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:00bpPyltHrtq59bAsxGVaRhr49ifclRTX/K9ioqcz0d2XvW28b+
 eQuUchiTczLKGw07g/srt3oKHES0KZZ84g2wVht3p1tmGJ6brRNPh62mChEtB+SipC3HNX0
 nZdNO2OMmJSSFHclReRRnMEZWlikpxvIS1BtbpNrNWRjbqN4G0mToagOv/LRm9XjLKCIPIS
 nqNYhlp5fpiUfo2izpbMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IMYc3vpdK20=:4VGFO075mLfgpLTtsh3Ac6
 S3mFavht0aOjW5TjxxSZkhmKaQWpt3WTHtcHJV7PGFsD6cKlwO0eoaAKJjlnWtjm01A1f6xY2
 3fP6NhMNe+5fy/SgHBK4IYmBGzPEhBgYe9bx4PKOk9+k2QOWxePTC7A459PltcAhmDu+qv3CP
 Rj50s7Jca8e5Xtqw3NQSRGJJc87iGbo4EVD64RoYx96Fjif9l5G+A+p4oSaph8Lhc3fhf+LXS
 kB4l3FCaF8ihnGjdsnSLfHul/y5yaKjHV1swVmF0BT3T0y7y53tsGOcutTq14w3+/rCJzsiAx
 LTN1F+APkJt/AhVfWHrh+/R1/1BKrK7xt+50lGzDM9v7jUeHUHARXAAnH6CyqKWtk+Y/1/iXB
 vccFOzjaUKAaYmuVcOhzA51DI00MhaIsMM0g1vyjrjpeiMSuG6I3DgXtmb2OWgTk2vcXfS6ds
 nFVmNdjAUSlGjoXCxsklBOaOAbiIdQEXowYeaNjNF2NIoYog95NzyPGovfYzNy1Rz1YrNaEmk
 9Tl3k6YBYVk6FdYnMowLFWHgyO1nSRcYsQvI8gJP0Wxuuhxcri30yDWdZsvsSXFuhX7NruQZM
 eeulqqbaefAY/an60S4W/vxdyNA2MMQkzBptWFF3M6pJvw+ODB1i+fwThYA3eoRYEN6XfNHfa
 oFBLT2jprZasKbUbCMMnRf6xucXn7eGvAHxFhJjEbWFHSwKnMudNhdIRAvjIgEk7RvwQAjW2a
 SYd9qF0JimVuel3h26SXdK49A4+x2sxCYZ5U9O6oFdsQjLgFOgqGgEQipQv9OZZ4+K+g0VHOb
 8gyQTscSdEmh7bAenRNxz0d7o+6V+zn2ip+bEb4EA+2CVncJ/YdPUmqhU4dh0dhJaupIpY4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 26 Oct 2017, Ben Peart wrote:

> On 10/26/2017 5:27 PM, Alex Vandiver wrote:
> > On Thu, 26 Oct 2017, Ben Peart wrote:
> > > On 10/25/2017 9:31 PM, Alex Vandiver wrote:
> > > > diff --git a/fsmonitor.c b/fsmonitor.c
> > > > index 7c1540c05..0d26ff34f 100644
> > > > --- a/fsmonitor.c
> > > > +++ b/fsmonitor.c
> > > > @@ -121,6 +121,7 @@ static int query_fsmonitor(int version, uint64_t
> > > > last_update, struct strbuf *que
> > > >     argv[3] = NULL;
> > > >     cp.argv = argv;
> > > >     cp.use_shell = 1;
> > > > +        cp.dir = get_git_work_tree();
> > > >    
> > >
> > > I'm not sure what would trigger this problem but I don't doubt that it is
> > > possible.  Better to be safe than sorry. This is a better/faster solution
> > > than
> > > you're previous patch.  Thank you!
> > 
> > See my response on the v1 of this series -- I'm curious how you're
> > _not_ seeing it, actually.  Can  you not replicate just by running
> > `git status` from differing parts of the working tree?
> >   - Alex
> > 
> 
> I saw your response but actually can't replicate it locally.  I've been
> running with Watchman integration on all my repos for months and my "watchman
> watch-list" command only shows the root of the various working directories -
> no subdirectories.

Indeed, I cannot replicate either. The thing is that "status" is marked
with GIT_SETUP in git.c:

	https://github.com/git-for-windows/git/blob/v2.14.3.windows.1/git.c#L465

That means that the setup_git_directory() is run, which sets the current
working directory to the top-level directory.

So there is your explanation why neither Ben nor I saw this.

And I agree with Ben that it is safer to do it the way you suggested, just
in case that the call path comes from a Git command that was not marked
with GIT_SETUP.

Ciao,
Johannes
