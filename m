Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51202211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 19:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBTs2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 14:48:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:34037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbeLBTs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 14:48:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLvLE-1gZ1uW3Wyi-007iRg; Sun, 02
 Dec 2018 20:48:16 +0100
Date:   Sun, 2 Dec 2018 20:48:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Paul Morelle <paul.morelle@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
In-Reply-To: <20181201200209.GC29120@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1812022044300.41@tvgsbejvaqbjf.bet>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com> <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
 <20181201200209.GC29120@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0jFsaXXmT8H+4gZn83bRR7iNkmqPib5ziY5xmbjaxSnAPU/Rg82
 fe9aLNXxBXlSdwcWw0XfxOIQFHgiLL+2bFkQm8Ic4rBQ9lfuWvns0lZyZI1kVkYU6+SiYch
 jk/EkwqyEMTX2jBjBeDLi7KoxVRPyfHsjnvWOPjfGa6jWtmkL7nC9fro3pjqPD4hIF6s/+U
 Ibw/Pti1/b8B8FKiAXRMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QRoD6kKa6aI=:83ATzX4kbr+MYTuC1845/N
 QrhGH2N70uG7+M/2tz7DdsOdKm1Z1Y3QLGCGgmU/CfAd3ZthWkK+9eh6UasG3krPSHEWDOqmm
 Eugby4Q0Lrja0KjAqbVfcxt1Khv2oqU9A0B8Guflq6Pbb8a/Qe2RiltHNuSf3HZJL18TWBtBC
 Isq5KvHomzfu8smrz5FouCz6SunH42etWyMztRn1zYUBhx4rlznGo/68DKRxxwXS5Run1bLFg
 ymg6n1xOJmG9f2GYjnDq3hbXBjEBZDbgkGF3+gGRaJ1xyBka2CQivMwchvXKnW8zFsAKih9ts
 Rs3i3rHGnzt5AWd015Vx0x3RvZNU0aojiW5Dk9cTN6WlE/TTQAM9UBCT/sfkOuGZNBEvERGar
 hwH47Euo1URI7v1NyKvSNVulz2J/WKCIo2pPFrL7L9ebHrYB7JBo+qhePzpcqlNo756Tfo3AR
 +IdqLb1001DLMyzvOrzv9x0tCYIraGShZfCHi9TtOH2DhUwpJiz1gb47Jdlx47FgDW6xqt2O4
 EfQyRbX9Fsiwc7PiAwRiGuDLE5ef0deWVi1q4QQFAXf12sAZs+oRE5eoXjxE/W757/GKiRxBg
 CP8CB5CBVsZzbbWDlzSIIH79fIC+Q5sZEUOeQoCRRDpnjKjcA6eP1wBetoCNDj0nlHyf1rRtB
 4DgRvU7BRG4N0Z5KZqywNYIqnkzqL/9RX4MfLrSQM2yyiFe95ZFghWJVR1BxiAl1km/woVmfE
 WBeApBlyuPbsPj1BzUx4g0+nUMSE4F4gz1IRGabTz86fKyDhV8G8XA7z2Fl0/ZpPf3vuS1UjG
 fekbanS80b5gh+ucUvqQV9oc6Rm5iUG1fuhJ7sfukS/GqOTOvU/EB70rDuphnNstTkyDIppnQ
 uS6coTwTaQnLD35BjziiNy+ilh5qljLSWSOH+UtnGcdxFdMF6V3joc5DbKL0s50HAARbHzRMP
 dwPvff0oF9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 1 Dec 2018, Jeff King wrote:

> On Thu, Nov 29, 2018 at 09:32:48AM +0100, Johannes Schindelin wrote:
> 
> > > > Would it not make more sense to add a command-line option (and a config
> > > > setting) to re-schedule failed `exec` commands? Like so:
> > > 
> > > Your proposition would do in most cases, however it is not possible to
> > > make a distinction between reschedulable and non-reschedulable commands.
> > 
> > True. But I don't think that's so terrible.
> > 
> > What I think is something to avoid is two commands that do something very,
> > very similar, but with two very, very different names.
> > 
> > In reality, I think that it would even make sense to change the default to
> > reschedule failed `exec` commands. Which is why I suggested to also add a
> > config option.
> 
> I sometimes add "x false" to the top of the todo list to stop and create
> new commits before the first one. That would be awkward if I could never
> get past that line. However, I think elsewhere a "pause" line has been
> discussed, which would serve the same purpose.

Yep, `break`, as Eric pointed out.

After all, you did not really want a command to fail, you just wanted the
interactive rebase to give you a break.

> I wonder how often this kind of "yes, I know it fails, but keep going
> anyway" situation would come up. And what the interface is like for
> getting past it. E.g., what if you fixed a bunch of stuff but your tests
> still fail? You may not want to abandon the changes you've made, but you
> need to "rebase --continue" to move forward. I encounter this often when
> the correct fix is actually in an earlier commit than the one that
> yields the test failure. You can't rewind an interactive rebase, so I
> complete and restart it, adding an "e"dit at the earlier commit.
> 
> How would I move past the test that fails to continue? I guess "git
> rebase --edit-todo" and then manually remove it (and any other remaining
> test lines)?

Yes, the current way would be to use `git rebase --edit-todo`.

> That's not too bad, but I wonder if people would find it more awkward
> than the current way (which is to just "rebase --continue" until you get
> to the end).
> 
> I dunno. I am not sure if I am for or against changing the default, so
> these are just some musings. :)

It's good that you chimed in with your side of things. If you missed the
`break` command, so will many others have missed it. And continue to miss
it.

Besides, Junio mentioned elsewhere that he is in the camp of people who
wait for enough users to complain why some config option isn't the default
to actually change the default.

So... I guess we'll leave the default where it is for now.

Ciao,
Dscho
