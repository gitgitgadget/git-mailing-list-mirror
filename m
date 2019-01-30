Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBF31F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfA3MnJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:43:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:45733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfA3MnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:43:09 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWSwU-1geRzs0oe2-00XcRw; Wed, 30
 Jan 2019 13:42:58 +0100
Date:   Wed, 30 Jan 2019 13:42:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches
 *.S on case insensitive filesystem
In-Reply-To: <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
Message-ID: <nycvar.QRO.7.76.6.1901301340270.41@tvgsbejvaqbjf.bet>
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-2-jeremyhu@apple.com> <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com> <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:O2kW9IbyDJQiYOt3gTwrXaxCpl/8f15Kq9VrKFjs/tLGjql+NdR
 IQJ97TmKolefRfTWaMzJ4ZFK9pzTJtBrKNc0EN7WgUjzUbaMz2cPRjSdmMA7wHMM7AL6exO
 WM3MR5VPCBkAallqCCT/XJZzEsRQP6Ci2rSv+QYFtcTue6OvakEuWkCSeAMdWyZVshG5rsv
 /HLbFUSDiHOWIArYaa6mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VcGDiqowBSI=:hhbBzW1wIZDZKsnQSQE+Pi
 2JNMqpZH64oRZ9Roureh7FuoKDIuKEcYmHIsf1Hn+U0LNxNqfFqEPGv+1vEl0l+ze4VuOUUFM
 BoFyyDAQdIsbO+5uB1pVyJsubdnhzRRIoRJAXWcQ1WoAtydmBPyu6pMol3PE04lD//ENlE3gK
 6eZjdCMP3IwwvLf8iGcA0kdtxCb6ZPCZ+/eCsZM2xnPLX6VXqA6li1DCEVoaqoc1MEO1sf/W8
 4Gq7Ic0rw2ijhw3uMeJNA2uMs2BWfF63AcSExAxKYy13+O5Q9mCbIuMVnCDZlX0XsMdHgeL3e
 E6hr+l7gDX/+dzGPsmg+ycSMkcKRq9cr4F4D5j/KjWP5wucdPJCCFb7p1zH9B9km8QUAwaKhl
 nwuD2k7/owdQx0kXqKUK1PBPsCnkZVoFWg7/z+0bQ/psF1Hab4L2kahZ32woY3uuvYixMuU1B
 EnyzLzOhS8OuRME9pB6Ybcef/BBU30DKhspIfaiOxZCSVd7Hh1mmNzwupe+bnOXU8WOwG3L8i
 gM1EgVBmvUhbe5AicTOuLMuZ8StCWNJZuZ7EIPy28naZv6/YHVhf+60NKw/TI+v8YF5bFFX2V
 IbZEmBNw46kbo8pzF5WcOPbV4g4sKL5FYZC5GB5Uy5/sR2Ja8hiVXs0elnrP6oGU5WQmJ8D/u
 kP81yA0OXRST8A6q2naR1839a0RKIH79mga+rAKuIUbvGbvD+39axkTjCJLU7GG43yDOcHN+I
 j4eVcWcYx7IN9+xQ3BbRI2PehwB0OaR15z7ZxNpzJAMNzDJoYOA/lCwFdGvyRttErDgi+nob+
 l3U34D7lQOzXocSGDPBOq9MzJlQUKCsSg2tOglbitBRR0o2jxVDEhkHz+iX7McLT7pYcD3Ytd
 Z4u+oGqj95dGsrkkA0OHpoR0WllWZJpgNlcM0zZcZ3vnu5yCFSOmX1/bBxnJW0FN2enPAcRbJ
 /ahsH4IZXtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeremy,

On Wed, 30 Jan 2019, Jeremy Huddleston Sequoia wrote:

> > On Jan 30, 2019, at 03:33, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > 
> > On Tue, Jan 29, 2019 at 3:11 PM Jeremy Huddleston Sequoia
> > <jeremyhu@apple.com> wrote:
> >> This was causing problems with ppc/sha1ppc.S
> > 
> > What problems, exactly?
> 
> The file is ignored, but it shouldn't be.

As somebody who sometimes (pretty rarely, but definitely more than once a
year) generates the assembler files to have a deeper look, I really
understand why *.s is ignored, and I think it should stay ignored.

What you probably want instead is

	# Accommodate for case-insensitive filesystems where *.s would catch
	!ppc/sha1ppc.S

after the `*.[aos]` line.

Ciao,
Johannes

> 
> > 
> >> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> >> ---
> >> diff --git a/.gitignore b/.gitignore
> >> @@ -195,7 +195,7 @@
> >> -*.[aos]
> >> +*.[ao]
> 
> 
