Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543581F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbcHVNYq (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:24:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:61938 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751032AbcHVNYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:24:45 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M1Ee8-1bHoFo0dwW-00t9B3; Mon, 22 Aug 2016 15:18:04
 +0200
Date:   Mon, 22 Aug 2016 15:18:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Wong <e@80x24.org>
cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <20160819223547.GB16646@dcvr>
Message-ID: <alpine.DEB.2.20.1608221509010.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3GjZg1VUMvD7d8DVJrS7sMedEDV1qy6q12ntwtbYcSiUQdo9kWH
 w/Afp451MoGah26Ik7j0Jz/eA+7eFDOA9jVHoy8Po3k9ZhiQ2NLCREtg+S+0kWM5vNpPugO
 4fKsf89ipkf4UvxwpRUixvgXuAr1GpNHzmI5Bb99tk5rnm1RinG3B36E+rT6qSwaZq/v0hK
 paFyhzu/QE7PYizbGxrHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8H7z+Q0BkKU=:gx1SzS0DW5SQsCEyib/1wS
 QIUJk2Zb+gDGE1KVhmBaiaGaJFyELD3oo4WXzWo5KhN/OpJab8mNoJrel1DymeB9PeiMWc6/c
 mV0Q9uWpvFJobztbqePuN1x79FmvrPsfTt+LWDAiNGM66vwN+ujjLXuzGZgPhZUC68gJG1aMc
 O+a43WFI3wsqQdu846MhdGD8hetICGoZMk/GFCAxDhbcd0YqmXpVOH5COdtrvhfSnd9CQ++Bd
 AraizqjX5j5M+9Csm+770xwbHz8WyWYTmMe54FDXbNUyfio+c+mKPVh5M7F6MR0vZCEXpV+94
 ev7caruRIn328bEU7Il+YKAgqabL+rfLpzwUryDqklXW1K3C6Gk0mG0mYM3JlT8A1Mw2CptrS
 4Z4jIpgd2WylubUIiAIzsd8A8zkX02AX35R3hjCg/0I2IVX8Tgh9kCUNcTWpJpBjbVe/l8zdY
 FiW7sjBMAZk8OLjLbZ3beXAUacmAXVShAqmkqrcZX/dFrWdmqcgVEKH4Mo1LOHXbIVkKrJkT8
 INPXv3XxnOR8qwczBXNiHU3Yqn+T+ji6kUgIFBht1PS4kCnSdXHmsoeiEl4kry6X3c5IPCkZl
 STsNXlIT9BJjsn8twCCIy/Osxv7IpCF/v33aeJkS3aAbJuFg6XzstLqB8Qjnwa2bX4CY7UXT7
 zXfgTIyIZHdXjMlh/wF/goEWDslh6t5dodAfplPDbclXSpWgvYAyUzbPnHW228WsaM1qd3ESm
 KmJGuEjyNKQWzoPZq9Q2KCB3QenHW184+ANcJ9YrZtKQOwxqOpaCUQesNFfJNRphJUDuxJT2y
 zrLalN4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 19 Aug 2016, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 18 Aug 2016, Eric Wong wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > > Old dogs claim the mail list-approach works for them. Nope.
> > > > Doesn't.  Else you would not have written all those custom
> > > > scripts.
> > > 
> > > git and cogito started as a bunch of custom scripts, too.
> > 
> > The difference is that neither git nor cogito were opinionated. Those
> > custom scripts are. They are for one particular workflow, with one
> > particular mail client, with a strong bias to a Unix-y environment.
> > 
> > I work really hard to make Git for Windows as easy and fun to use as
> > possible. I just wish that we were working together to make it as easy
> > and fun to contribute to Git, too.
> 
> I guess this is a fundamental difference between *nix and Windows
> culture.

I do not understand how you get from "I wish to make it fun to contribute
to Git" to "there is a fundamental difference between *nix and Windows
culture".

> I know Windows users have major performance problems with
> shell scripts;

That's because shell scripting is not native to Windows. I wish Linux had
a Powershell, allowing for decent scripting that does not try to smoosh
everything into a line-based text format. (Of course, since last week,
Linux does have a Powershell.)

Powershell is blazing fast, by the way, and not as ridiculously limited in
its expressibility as shell scripting.

But all of this is digressing from the original topic. I do not think this
is a productive.

> > We do not even have a section on Outlook in our SubmittingPatches.
> > 
> > Okay, if not the most popular mail client, then web mail? Nope, nope,
> > nope. No piping *at all* to external commands from there.
> > 
> > So you basically slam the door shut on the vast majority of email users.
> 
> Users have a choice to use a more scriptable mail client
> (but I guess the OS nudges users towards monolithic tools)

You call that choice. Are you serious?

> > That is not leaving much choice to the users in my book.
> 
> Users of alpine, gnus, mutt, sylpheed, thunderbird, kmail,
> roundcube, squirelmail, etc. can all download the source, hack,
> fix and customize things.  It's easier with smaller software,
> of course:  git-send-email does not even require learning
> the build process or separate download.

Now I am getting upset. This is a BS argument. Sure, I can hack the source
of these tools.

But why on earth do I *have* to? Why can't we use or create an open
contribution process *that works without having to work so hard to be able
to contribute*?

So unfortunately this thread has devolved. Which is sad. Because all I
wanted is to have a change in Git's submission process that would not
exclude *so many* developers. That is really all I care about. Not about
tools. Not about open vs proprietary, or standards.

I just want developers who are already familiar with Git, and come up with
an improvement to Git itself, to be able to contribute it without having
to pull out their hair in despair.

Ciao,
Dscho
