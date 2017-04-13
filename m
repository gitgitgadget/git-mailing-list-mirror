Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DE520960
	for <e@80x24.org>; Thu, 13 Apr 2017 13:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdDMNwX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 09:52:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:64056 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbdDMNwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 09:52:21 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrrRi-1bvC3K4Aj0-013hGW; Thu, 13
 Apr 2017 15:52:09 +0200
Date:   Thu, 13 Apr 2017 15:52:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephen Hicks <stephenhicks@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Rebase sequencer changes prevent exec commands from modifying
 the todo file?
In-Reply-To: <CAKNkOnNMH72QnuDrja3XNG8Z6zLsuXdCERA==iBQztRQW1+O3Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704131526500.2135@virtualbox>
References: <CAKNkOnM366uiJKkz31hS8V3NTa8qksP2pXrH4+F-zodZaNdsqg@mail.gmail.com> <alpine.DEB.2.20.1703021617510.3767@virtualbox> <CAKNkOnOkSgFei7jpck8Z7tH+jYn_MXvarA86GAadT8jJt4aO-g@mail.gmail.com> <alpine.DEB.2.20.1704122355440.2135@virtualbox>
 <CAKNkOnNMH72QnuDrja3XNG8Z6zLsuXdCERA==iBQztRQW1+O3Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:98Ath8UTFsutdZR/dX+c7neOu2sBSWN19MwyfoE8tnbFHLyGWZB
 PufTuvjLAmV1697/sdY9ND/Tpy9KnDKPonzfOyNWaaqLWXBjfnCp+9Qj4vbBbZdpVBBu1Bq
 zBK8k1ODhqF5K/hIp6ZRRueVovP3Xt38pEJGdVrrJL4JrXPHoo79DHWX4QSWi+uCorOyT1M
 xHYsvR46LZKmlQNjeHFTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cya605e+RkM=:/EmVy6FdZMO4R8XWj9L+GS
 RJeEJF/Wwn0Qj4IrhW0u3KogRmBnhccO+46Y5Zuf9Z+E6qpqglbuX2JrK/1CVPRYtIWpGvhdf
 dc03dP85ob+7kQd0AZTEwcYaKw31gkVcfdmLrRFw/AUQ+0I75dlBLgw8UgXpoz9Ikr61EDSfN
 rtcYKijbNNEb0BNmFjmN96u3RvX/fxy3HmQ1IUqhbWyNZzBo57X/bHmWLX7xrCsFW3FIV9W67
 93TvRAZnGvXIdjanMxj9kgnxgAw/f3SqBq4VBntX4Yn+rllMgxanjH4EsgmQ61uQ2kS61kLMb
 pFYTCYUrUIgllqLSBEgK8viKCzrEznRjZTCduhpiL8yd9z4jAY3rWPsvS6CAzlDN26dTc19sW
 pYmYguSiKjDeF5oFK4itFegnWitQUTGhUmN38xIkaEyMFV5VTFOuwWM6NSu96q5ozFrUejhBU
 M26uzhCaZKFhrmk86/wVCRpxciS1DRYO+MzIgflBPpj1r1T8k3G7nnh75yWUjne0zYxS6Re95
 kobbNiUoPBVog0biUJ/saKnwLNyUl/P0tZemaLG3ufbyXY2Zl5hhNo0g7QBI+HU1XbAHBu3dk
 BfZgPaVaVivvA6R0wBGfD0OSj/O3u4Or6iVFzDIe9dAgUn6Y3GpJDX2eCayEN89ON+vkGt2WE
 padm82Nu/G3iGWf2k+hP82w2etoP/0kzb7gi+b7EytozApqxDLRQcvNI4uVpW4cQrNCUOCRHt
 V+F3UpLGroqYiIoSqa3p4IILpHbBQvFWhI83W2Y0nGSEc1rpcMx5+ryrY1HTB1LYxxXGZhbka
 tiw0ul4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephen,

On Wed, 12 Apr 2017, Stephen Hicks wrote:

> On Wed, Apr 12, 2017 at 3:05 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 11 Apr 2017, Stephen Hicks wrote:
> >
> > > I'm hesitant to only use mtime, size, and inode, since it's quite
> > > likely that these are all identical even if the file has changed.
> >
> > Not at all. The mtime and the size will most likely be different.
> 
> In my experience, mtime is almost always the same, since the file is
> written pretty much immediately before the exec - as long as the
> command takes a small fraction of a second (which it usually does) the
> mtime (which is in seconds, not millis or micros) will look the same.

Oh, I see, you assume that mtime is in seconds. However, on pretty much
all platforms supported by Git we use nanosecond-precision mtimes [*1*].
In practice, the mtimes are not always nanosecond-precision, as some file
systems have a coarser granularity. It is typically a pretty fine a
granularity, though, much finer than a second [*2*].

My mistake, I should have explained that I wanted to suggest adding a
field of type `struct cache_time` to the `todo_list` structure, and to use
ST_MTIME_NSEC(&st) to populate and compare the `nsec` part of that.

Ciao,
Johannes

Footnote *1*: The platforms for which we disable nanosecond mtimes are:
OSF-1, AIX, HP-UX, Interix, Minix, NONSTOP_KERNEL (?), and QNX. (If you
look at git.git's config.mak.uname, you will see that Git for Windows'
nanosecond support has not yet made it upstream.) In other words, the
major platforms (Windows, MacOSX and Linux) all compare the nanosecond
part of the mtime.

Footnote *2*: the coarsest mtime of which I know is FAT32 (2-second
granularity). If you want to use Git on such a file system, well, that's
what you get. And then some performance penalties, too. It would appear
from a quick web search that ext4 has true nanosecond granularitry. NTFS
has a 100ns granularity which is still plenty enough for our purposes.
