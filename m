Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7141F405
	for <e@80x24.org>; Thu,  9 Aug 2018 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeHIPtC (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 11:49:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:45377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbeHIPtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 11:49:02 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lp3Qu-1gQPeZ2w7A-00ew4F; Thu, 09
 Aug 2018 15:24:03 +0200
Date:   Thu, 9 Aug 2018 15:24:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: pk/rebase-in-c, was Re: What's cooking in git.git (Aug 2018,
 #01; Thu, 2)
In-Reply-To: <xmqqbmahs5vh.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808091522440.71@tvgsbejvaqbjf.bet>
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808050229210.71@tvgsbejvaqbjf.bet> <xmqqbmahs5vh.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pt0j+/+uKKxJItITYo1bfMOXGuM+oMU8J9Nds62SfkeiTsMt110
 FCuuBKX2K3OOjsDvgQx8e9WXFXDuZHTCkgqCOHaeSpRKay5C0YrmD0I8hP8LRRprA/YBEWX
 jXQufGdZ7f50dg+uj4/BUQos7OmaYL0PQ2lrOECEDYWJ7vflXmcj2+cqSgw7dizNblClkMN
 eZpXetj924oAHas0qRJqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YoWC50FHPes=:5eUUlQCuB3dipyq5Ythhw+
 kVVShhZ39QlgNMqlvczRlRqTh5n9fzOfMm9NxkTOcfWWJKfKfD2Hsofnx41vSNDpu6YET+oEx
 EBww+zO7Pn+r3s8s++sfJPQ9H+dq6eFMs1zjw1EzRFxqWHHxMZkfRPpJYhblQpy9I2C4B1M3O
 IX5aL8cd8Z3I6cMpLmBgffmaoZUmsaFFCkvLmkPM2jzcxxC9Uz8vM1v1BSEgS6LehsJQWmCTQ
 iJpXx/ZJySPN27To+9DjNgOYhWApcHF1Jb8PELrTfqF1ofZfinXKSQaDW+fTCRvOkepqWzVhR
 EpZblHQUchpm/8+c5sTPWPw93l2rxaMisprW//CMMCmpUgNXauAQVg+t4t16Rw6mR0K7XEnSQ
 aUFHmH+UuYogIQJbecYSRc3EH6kMN6+s0qFeh7dTpQnkblCmGUOMi3PHLGcPaHTo++KoMNayy
 68xC5FtaDnDORuneu9+/aZSQIcWzniO7hPcyTj47KMyWBKnksvO3TFlEnT+rywbc12dRFK3SI
 G+lSWJgPXSPIw50wkHbX6zR1IYINWpCvOLESO1Li0l8EXu7nXPlRQqHvKUeyrba1h9Emwopa/
 yfYsWJtsmKQQur4LptQ7u4s2ALC/rMdry24fMjUz+xbjo1iBEHaaqTGPj4+0xiav9pka9RsBL
 dSXKqCW8mFheL3Iq4pSQmZmC40FqvghIzTAYkGVAlFTabRLrdFKEZpuHyOgX0N1aLZT/vQYUE
 C/Yzl0GcDvcmDAexJaWb/A7kLoAflDicDJ2sssUmMaDisognsdM2WvSAPM/4BGIHyU29Pv9DU
 5dBHSBx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 4 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 2 Aug 2018, Junio C Hamano wrote:
> >
> >> * pk/rebase-in-c (2018-07-30) 3 commits
> >>  - builtin/rebase: support running "git rebase <upstream>"
> >>  - rebase: refactor common shell functions into their own file
> >>  - rebase: start implementing it as a builtin
> >> 
> >>  Rewrite of the "rebase" machinery in C.
> >> 
> >>  Will merge to 'next'.
> >
> > Please hold. I found several bugs in the third patch, and it will need to
> > be fixed before sending another iteration.
> 
> Thanks.  I think the author already corrected/stopped me on this one
> and it is now marked as "hold" in my working draft.

Indeed, looking at public-inbox, I even see it. The strange thing is that
I never received this email in my inbox. Apparently GMX is letting me
down, as I have identified at least a dozen mails that made it to the Git
mailing list but not into my inbox, some even with me in the Cc: line.

Troublesome.

Ciao,
Dscho
