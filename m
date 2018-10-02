Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C811F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeJBVWt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:22:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:51789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:48 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9NIY-1g1LX939jy-00ChtX; Tue, 02
 Oct 2018 16:38:53 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9NIY-1g1LX939jy-00ChtX; Tue, 02
 Oct 2018 16:38:53 +0200
Date:   Tue, 2 Oct 2018 16:38:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Daniel Harding <dharding@living180.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
In-Reply-To: <9628abb4-86ec-a6f1-0c9c-64458949ebdb@living180.net>
Message-ID: <nycvar.QRO.7.76.6.1810021629020.2034@tvgsbejvaqbjf.bet>
References: <20180708184110.14792-1-dharding@living180.net> <20180708184110.14792-3-dharding@living180.net> <20180708210200.GA4573@genre.crustytoothpaste.net> <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net> <nycvar.QRO.7.76.6.1807092109440.75@tvgsbejvaqbjf.bet>
 <aa716d3f-6a80-e3fc-0172-1027fb85c792@living180.net> <nycvar.QRO.7.76.6.1807101504530.75@tvgsbejvaqbjf.bet> <9628abb4-86ec-a6f1-0c9c-64458949ebdb@living180.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3kV6fj0B6teubqQ6Jboxf/FTH5iTbS1UDpYE3NThIBhbjcZX+xw
 J2KMdEzMGv82VNO0ZdvVWZeqRytgW2pRkWZI8uj40uMqxcuyCFWeUUWlM6CjDDzEW0jnRSa
 T5pI7z3B4GCN5lRdy+18HtYpEmcwOhQUESq8uRLPrACRp1BqNebhYNY8I5Tkx/sCy29m7eJ
 RXxtfNwa6JQrBrKJaBflw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y9W/cAJH6pM=:2dU1G55UgHSkS4UmnV5NwY
 MBly8hOeHwAfXvVuQdRFJ8OHoK9++twMGVMAGUm7OUVBmzPNCmgbUco/L6fQsGkhlJXzWT/0q
 Zgeq9wJnHn7zKvSZW7sJmgZ4lqJUFU0jEmpAAS0apbIMN46vx1Ug3NRNAWs51mVqaL3cHiPUe
 cwP1uwNmUpnUEIruUQkn0nqqXyEeja3Y1ZqCB7kYNRjAlbDCW/Hddp0jARsO0Mamb9eu1Ymq/
 r+MSk8zo4Uj/P8b0KC+tvF0KXjYHJ2gGErF8GCtAVytQxEHdNdPjvAMKnB4bQ+X88266cZKm1
 z1a8QVr7C142gklLKi34nX5owCDzOaAGYvhM6+CiU9IeudKV4subA9xZEfaZdw7B3sXO15Ez6
 n2CpOGRHkpxwHt+mgDyzyJwfbw/JVx7xT1OCvCFe7uTFKyjcimdUd7aE7vKXpQl7Tvqj561IM
 S4lePp3hySgRPPxVMJ1/AUMbtkhDOuydFMOzVIgr9np3KPisaVgWMAD0oeeYSwKzqUSnb4VRz
 OEBmu6nadIPJ9GmX8OUGpMqS4g+VjRt/HtWyIJ9+VGeTUAL9ZgDj+XSQuJZhhcuoma2mVS+I9
 NTCvDjEq5khg5/4PRkyWO9ZoAOv/3YJsd9bYBgaSEuppiTcLdNJfaLOWi1MkBk7XLMHYkglch
 BO0oV22/cghdKL8uhcfvuAs6NYM/uVAiLbnRvJRMZE0QANRnaiNF5wDFT04sZS2bDI/CPwMOc
 Icg/V1U5nKHiaGdRJwO8cXCFFwHO/8jcXgV3nPS0bEfs7SPqFkPgRMpnhlAJf3RlYrZaZdv3T
 9BmRWRiAHrNTOYrHMvtnCcuMV7Get2lQFZ2BOvBQRKMB/iArGs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

[I forgot to address this mail earlier, my apologies]

On Tue, 10 Jul 2018, Daniel Harding wrote:

> On Tue, 10 Jul 2018 at 16:08:57 +0300, Johannes Schindelin wrote:>
> > On Tue, 10 Jul 2018, Daniel Harding wrote:
> > 
> > > On Mon, 09 Jul 2018 at 22:14:58 +0300, Johannes Schindelin wrote:
> > > >
> > > > On Mon, 9 Jul 2018, Daniel Harding wrote:
> > > > >
> > > > > On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
> > > > > >
> > > > > > Should this affect the "# Merge the topic branch" line (and the "#
> > > > > > C",
> > > > > > "# E", and "# H" lines in the next test) that appears below this?
> > > > > > It
> > > > > > would seem those would qualify as comments as well.
> > > > >
> > > > > I intentionally did not change that behavior for two reasons:
> > > > >
> > > > > a) from a Git perspective, comment characters are only effectual for
> > > > > comments
> > > > > if they are the first character in a line
> > > > >
> > > > > and
> > > > >
> > > > > b) there are places where a '#' character from the todo list is
> > > > > actually
> > > > > parsed and used e.g. [0] and [1].  I have not yet gotten to the point
> > > > > of
> > > > > grokking what is going on there, so I didn't want to risk breaking
> > > > > something I
> > > > > didn't understand.  Perhaps Johannes could shed some light on whether
> > > > > the
> > > > > cases you mentioned should be changed to use the configured
> > > > > commentChar or
> > > > > not.
> > > > >
> > > > > [0]
> > > > > https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L2869
> > > > > [1]
> > > > > https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L3797
> > > >
> > > > These are related. The first one tries to support
> > > >
> > > >   merge -C cafecafe second-branch third-branch # Octopus 2nd/3rd branch
> > > >
> > > > i.e. use '#' to separate between the commit(s) to merge and the oneline
> > > > (the latter for the reader's pleasure, just like the onelines in the
> > > > `pick
> > > > <hash> <oneline>` lines.
> > > >
> > > > The second ensures that there is no valid label `#`.
> > > >
> > > > I have not really thought about the ramifications of changing this to
> > > > comment_line_char, but I guess it *could* work if both locations were
> > > > changed.
> > >
> > > Is there interest in such a change?  I'm happy to take a stab at it if
> > > there
> > > is, otherwise I'll leave things as they are.
> > 
> > I think it would be a fine change, once we convinced ourselves that it
> > does not break things (I am a little worried about this because I remember
> > just how long I had to reflect about the ramifications with regards to the
> > label: `#` is a valid ref name, after all, and that was the reason why I
> > had to treat it specially, and I wonder whether allowing arbitrary comment
> > chars will require us to add more such special handling that is not
> > necessary if we stick to `#`).
> 
> Would it simpler/safer to perhaps put the oneline on its own commented line
> above?  I know it isn't quite consistent with the way onelines are displayed
> for normal commits, but it might be a worthwhile tradeoff for the sake of the
> code.  As an idea of what I am suggesting, your example above would become
> perhaps
> 
>     # Merge: Octopus 2nd/3rd branch
>     merge -C cafecafe second-branch third-branch
> 
> or perhaps just
> 
>     # Octopus 2nd/3rd branch
>     merge -C cafecafe second-branch third-branch
> 
> Thoughts?

That is a very good idea, if you ask me! Unfortunately, I forgot about
this suggestion, and IIUC v2.19.0 shipped with my previously-suggested
version.

But maybe you want to spend a little time on the code to change it
according to your suggestion?

The `merge` commands are generated here:
https://github.com/git/git/blob/v2.19.0/sequencer.c#L4096-L4120

> > Not that the comment line char feature seems to be all that safe. I could
> > imagine that setting it to ' ' (i.e. a single space) wreaks havoc with
> > Git, and we have no safeguard to error out in this obviously broken case.
> 
> Technically, I think a single space might actually work with commit messages
> (at least, I can't off the top of my head think of a case where git would
> insert a non-comment line starting with a space if it wasn't already present
> in a commit message).  But if someone were actually crazy enough to do that I
> might suggest a diagnosis of "if it hurts, don't do that" rather than trying
> to equip git defend against that sort of thing.

I did want to have an extra special visual marker for users (such as
myself), so a space would not quite be enough. That's why I settled for
the comment char.

Ciao,
Johannes
