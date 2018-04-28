Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425991F428
	for <e@80x24.org>; Sat, 28 Apr 2018 13:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933522AbeD1NFg (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 09:05:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:53987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeD1NFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 09:05:35 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M97Nh-1f4xpY2FbB-00CPBX; Sat, 28
 Apr 2018 15:05:25 +0200
Date:   Sat, 28 Apr 2018 15:05:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 4/4] rebase --skip: clean up commit message after a
 failed fixup/squash
In-Reply-To: <CAGZ79kYJ--qt5AdM3EX9vwMb_AwD6gtWFp7wt2KP4OKsdOYLGQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804281500080.79@tvgsbejvaqbjf.bet>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524862093.git.johannes.schindelin@gmx.de> <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
 <CAGZ79kYJ--qt5AdM3EX9vwMb_AwD6gtWFp7wt2KP4OKsdOYLGQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zmqUxEkqdhN+XSM8YrIIxSSXRPSVCuCx27DAkMlhHplW0PnZoTB
 GwHK2asYYWFaSDqm0/GkU94OfYA6/snvJTZlveumU0xHfIqVUEOXHFYUDG8K1gWC1uMMqCx
 RslISgEFz4ibpQvEvlcwG415D6pr1EBddCqhIpjHydSUSndOuWSE0vYLuhYjaPWLl9aAGLw
 1Yqn9mHAGWrNUAzQoejsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EFHwyi3eW1w=:ysX/OnjcQyOChgo9iGyqej
 pZKdL1s66GPVd5t00SlWU7MCbkeIUufkbgfQlb4Jc2xexQ24tnKxFmNHju4gOpUc/vUQvoOC1
 1ky8wbz25g2Hfti+2t9h0cBYIEkISpC7oupQZCqW5W2qunifQW9G/6YO4UxNViusXUcUlbnNv
 V7goas0nsHmDCBdqrNrOKYMnbIe6wW3ZbzlDvHwRTxOzhif/SLLMH0ejUev1ovRwNOe51XjCC
 wEFi/+vxuZ8mUgnz6CHdyT+q0qMWh7LA2B1X3fNTJrx4Ldhz/lQDAv2mVlNIf2SNQPmkwzvbj
 r5a1D5huDOVJ5/pQBqKJxoN/PMh+E1UGGRNjrcIHVXqnfuDAtuQi5tc4AAmWj4FUQl5qCnmIY
 8SE3hMeGdukjDaYuhAotBVEK4MYAN05QJ3sZLbWjXoVB/g8NlWMg6cb6pkm7U1WIh6OCBjZLh
 pZD+6WHaKK804++W+2PiliJYuSRR3zlOkvE2Rs1Q+hU583qqpqUMIMS8v4SHy9lEaWOIflPKR
 CRfdg6YlfWdgd5pCOzi/6o6YejZEjVmCHUzWykSJ/BUvcHaaJwtaHjpWBGl3TI2OeMdMPNzXY
 ablbdSojM9hC2YJgFT+Lnb1F/nkwdXbIt/MyJEJCyLNmTZConNxs3nioJIxiegANgTasvtId9
 7LUJWQoJ4Ken2H2PfY4dTJwV+a8X+sivufvQtnCT56fx6yaFWZpaNiHkSvyQ27RHRyfBdigsA
 WAu2v3lsy02nlObMJCWkg6OPK2yEeoErvVZolMxuWqvRFTyW/AaTK9mYFr7EHvGEheTgNNuJi
 bwkTc/G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 27 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 27, 2018 at 1:48 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > During a series of fixup/squash commands, the interactive rebase builds
> > up a commit message with comments. This will be presented to the user in
> > the editor if at least one of those commands was a `squash`.
> 
> This sounds as if the whole series will be presented to the user, i.e.
> 
>  pick A
>  squash B
>  fixup C
> 
> would present A+B+C in the editor.

And that is indeed the case. The commit message would look something like
this:

	# This is a combination of 3 commits.
	# This is commit message #1:

	Hello Stefan

	This is A.

	# This is commit message #2:

	squash! A

	Me again, Stefan. I am here to be squashed.

	# The commit message #3 will be skipped:
	#
	# fixup! A

> I always assumed the sequencer to be linear, i.e. pick A+B, open editor
> and then fixup C into the previous result?

Nope.

> No need to resend it reworded, I just realize that I never tested my
> potentially wrong assumption.

No worries, you learned something today.

> > The diff is best viewed with --color-moved.
> 
> ... and web pages are "best viewed with IE 6.0" ;-)

That is what I had in mind writing that.

> I found this so funny that I had to download the patches and actually
> look at them using the move detection only to find out that only very
> few lines are moved, as there are only very few deleted lines.

I agree that the current iteration is no longer such obvious a move. I had
to add tons of stuff to fix the extra issues I found while working on v4.

But still, I found it super-helpful to see that the code was actually
moved, and where, because I essentially had to break up the nice sequence
of "is it clean? Yes? Then nothing to be done! No? Is HEAD to be amended?
Yes? No?" and basically build a matrix what to do in all combinations of
"clean? Amend HEAD?"

Ciao,
Dscho
