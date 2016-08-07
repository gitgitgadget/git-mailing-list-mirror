Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EBF32018E
	for <e@80x24.org>; Sun,  7 Aug 2016 08:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbcHGIrA (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 04:47:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:56662 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcHGIrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 04:47:00 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M0PdN-1bFtGl2Lpl-00ubRr; Sun, 07 Aug 2016 10:46:38
 +0200
Date:	Sun, 7 Aug 2016 10:46:35 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Wong <e@80x24.org>
cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <20160806214325.GA9484@starla>
Message-ID: <alpine.DEB.2.20.1608071039410.5786@virtualbox>
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <alpine.DEB.2.20.1608050925240.5786@virtualbox> <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
 <alpine.DEB.2.20.1608061045240.5786@virtualbox> <xmqq8tw9iw7i.fsf@gitster.mtv.corp.google.com> <20160806214325.GA9484@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jd6fkQozxuwA4V0xVoVRtsc4y6vloZbaGZelQixPW07WQY/UerV
 u/l+GBDwyJqK9PMIqUwbxIyWwv0XXpLJam9qT1k5B+wQdil/6sadHkL9gDmB/TfKNwDHT8V
 NrvmDuUyQlHMz6Wz0ns9cCTY9J54bcFfMsAQXJIw6+GQehqSHvnc+emk6KJAePFFTZ6ikW8
 HtzAnXIiG9s8wDYIozI3A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LfcnPz3x9T4=:RxemgwUy06XM/tGNQTXkiE
 YkMlIPdpP16IzzqXHomB+H4UE8FKvuMqRbB9qN2YV00Q8P3E0hljyozd3NV0XApCWeQ3ZDbcU
 IiqsYem0feBvEKP9Dtkyhc1YWoyJq4Wh4BcfJSXXBQ1veEovoJVSJEcoeabwae36C313lp94m
 m6wnND0Hh73ujHt58MI6bJtDEVAQXixTYSiDc3xrWxHMRRr7S3h3KIY5Lyz9PgYu5awVnwLwM
 Q5HsZ9eeg4yEVEd3/v22LnzsuHPjviDD8hchm9ySIy8qu2Cp3h14BiJzyzyymUBnBNgLssUT+
 8u2WuPcjPu22zJHrSzFYL0L/fHkQz990eZmDa8GCJavLXR1q7BXOlucOueeXjzcuc2AcPf3ru
 kEubk3XaytvdkeM56JFU+UZX1wSVzoFRCO0SJQ7THObNJ+CSmqfAhB8BH/vLJMF+ledsChEdr
 fCSnHiNSJTgY6bCmPXd9VGdoXCEY2cV6aXFM4lrysWdSIunlb8qJEnelyNXi5BfptBFi8m2wp
 MDXCtCw+f53ODtciOn4Pn6Q+Ak0/C/Wkxvfm2KsVROOlV5bYXCfo/VboDsEZKL4G4W4HdMxCh
 AFpHg1oDhFOH9r+pPbqknR9d2/ecAUQhrBFV0p0Vb69y/j3GEpcvcuz0QXRbwT28yNiUnHLzv
 xOYritOlfTEOKboJrWIA6uzaxTkZmPWtoaPJtQ7yiwjxeTQXkBo+7wU8C5XIVmAB7SneKF9OK
 czdZHFrNWpvlaFyS1XWi3iktu8oYfFqgbbNX70ux3cEXVX0RAbO7xA9ykOn2hhe1jaJn+bwFo
 aSI0ki1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Sat, 6 Aug 2016, Eric Wong wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > Somebody mentioned "configuring it is hard--why does the user have
> > to know SMTP subtleties", and that may be a valid complaint against
> > the primary part of send-email.  The solution for that is not to
> > discard it with bathwater, but make it just as easy as other MSAs,
> > say, Thunderbird, to configure for an average user who can configure
> > these other MUAs.
> 
> Sadly, the average user does not use an MUA, SMTP or IMAP, anymore.
> It's all webmail or apps using proprietary protocols.
> Embrace, extend, extinguish :<

I think you both got it wrong. The original citizens were the mail clients
that allowed you to communicate with other human beings. Webmail is just a
new generation of the same commodity. It is our usage to transport
machine-readable content (and not as an attachment!) that is the intruder.

It's not making things better if we require users to use a second mail
client for sending out patches, and, oh, it does nothing to help with
reintegrating patches back into Git, were they had been before taking that
perilous and lossy journey through that medium called email.

Ciao,
Dscho
