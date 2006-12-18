X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Mon, 18 Dec 2006 14:38:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612181435100.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de> 
 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com> 
 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de> 
 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com> 
 <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com> 
 <17797.35177.550000.996862@lapjr.intranet.kiel.bmiag.de> 
 <Pine.LNX.4.63.0612172027400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <906f26060612171736pab766b7t15a36d4d3fc7e85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 18 Dec 2006 23:41:05 +0000 (UTC)
Cc: Juergen Ruehle <j.ruehle@bmiag.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <906f26060612171736pab766b7t15a36d4d3fc7e85f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34766>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwIhY-0005Vv-0x for gcvg-git@gmane.org; Mon, 18 Dec
 2006 14:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754006AbWLRNiV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 08:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbWLRNiV
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 08:38:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43778 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1754006AbWLRNiU
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 08:38:20 -0500
Received: (qmail invoked by alias); 18 Dec 2006 13:38:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 18 Dec 2006 14:38:18 +0100
To: Stefano Spinucci <virgo977virgo@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 18 Dec 2006, Stefano Spinucci wrote:

> On 12/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > ...
> > I am sure that there are more problems with it. BTW the problem stems from
> > Windows having _no_ equivalent to fork().
> > ...
> 
> if you are sure that there are more problems with using MMAP, shouldn't 
> NO_MMAP be commented better in the Makefile and in INSTALL, pointing out 
> to use it always on cygwin ???

I argued for that a long time ago, but there were a couple "works-for-me"s 
and I just shut up.

It could also be the case that for most operations, git became safe over 
time. For example, my biggest problem was the fork()ed diff in git-log, 
which was substituted by a non-forking inbuilt diff.

> should I write to the cygwin-apps list asking for a different 
> compilation (with NO_MMAP), or for the majority of the users the 
> standard compilation is a better choice ???

Given that most Windows setups nowadays run on NTFS, I doubt that this is 
necessary. I use NO_MMAP myself on Windows, just in case, though.

Ciao,
Dscho
