Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB61C1F89C
	for <e@80x24.org>; Mon, 16 Jan 2017 03:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbdAPDRW (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 22:17:22 -0500
Received: from ozlabs.org ([103.22.144.67]:55125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbdAPDRV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 22:17:21 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3v1z1X1bFzz9sR9; Mon, 16 Jan 2017 14:17:20 +1100 (AEDT)
Date:   Mon, 16 Jan 2017 14:17:06 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Janke <floss@apjanke.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk pull request // was: Re: gitk: "lime" color incompatible
 with older Tk versions
Message-ID: <20170116031706.GA3322@fergus.ozlabs.ibm.com>
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
 <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
 <20170113112043.j7nowdilolswyk2k@gmail.com>
 <20170114084825.lcecrbtxny3ntulf@gmail.com>
 <xmqq37gldp8g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq37gldp8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, Jan 14, 2017 at 06:35:43PM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > On Fri, Jan 13, 2017 at 03:20:43AM -0800, David Aguilar wrote:
> >> 
> >> Ping.. it would be nice to get this patch applied.
> >
> > Sorry for the noise, and thank you Paul for the fix.
> > This was already fixed by Paul in gitk@22a713c72df.
> >
> > I'm sure Junio will merge gitk.git into git.git soon enough so I
> > can sit tight until then, but while I'm here I might as well
> > send out a pull request:
> >
> > The following changes since commit 22a713c72df8b6799c59287c50cee44c4a6db51e:
> >
> >   gitk: Follow themed bgcolor in help dialogs (2016-03-19 14:12:21 +1100)
> >
> > are available in the git repository at:
> >
> >   git://ozlabs.org/~paulus/gitk.git 
> >
> > for you to fetch changes up to fbf426478e540f4737860dae622603cc0daba3d2:
> >
> >   gitk: Update copyright notice to 2016 (2016-12-12 20:46:42 +1100)
> 
> Pinging Paul to signal me that his tree is ready to pull from is
> appreciated, and asking Paul if his tree is ready to be pulled and
> then relaying his answer to me is also fine, but I am sensing that
> this message is neither.  So let me double check.
> 
> Paul, is it a good time to pull, or do you still have something not
> published yet that should go together with what you have already
> queued?

I recently pushed out one more commit to update the Russian
translation from Dimitriy Ryazantcev.  The head is now 8fef3f36b779.
I have a couple more series that I am currently reviewing, but nothing
immediately ready to publish.  It would be a good time for you to do a
pull, since the "lime" color fix and the memory consumption fixes
should be helpful for a lot of people.

Thanks,
Paul.
