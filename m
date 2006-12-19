X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 21:28:50 +0100
Message-ID: <20061219202850.GA4501@steel.home>
References: <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org> <20061219083242.GF2511@spearce.org> <20061219084017.GB30448@fiberbit.xs4all.nl> <20061219084908.GG2511@spearce.org> <20061219091319.GC30448@fiberbit.xs4all.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 21:56:24 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 5189 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 16:56:10 EST
Content-Disposition: inline
In-Reply-To: <20061219091319.GC30448@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: Ttsy3aZZweb6B-+Qa7WeazfjqlIFWmWbv1CrnTtvAu8X80KUv4WKQu
X-TOI-MSGID: de651497-9b29-4fe7-a5a4-41f8774fcb00
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34855>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwmwY-0006A9-Af for gcvg-git@gmane.org; Tue, 19 Dec
 2006 22:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932964AbWLSV4L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWLSV4L
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 16:56:11 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:33943 "EHLO
 mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932964AbWLSV4K (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 16:56:10 -0500
Received: from fwd28.aul.t-online.de  by mailout10.sul.t-online.com with smtp
  id 1GwlaY-0005yl-02; Tue, 19 Dec 2006 21:29:26 +0100
Received: from tigra.home
 (Ttsy3aZZweb6B-+Qa7WeazfjqlIFWmWbv1CrnTtvAu8X80KUv4WKQu@[84.163.96.210]) by
 fwd28.sul.t-online.de with esmtp id 1GwlaS-1MTJUO0; Tue, 19 Dec 2006 21:29:20
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id F040F277AF; Tue, 19 Dec 2006 21:28:51 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.62 #1 (Debian)) id
 1GwlZy-0001h5-J8; Tue, 19 Dec 2006 21:28:50 +0100
To: Marco Roeland <marco.roeland@xs4all.nl>
Sender: git-owner@vger.kernel.org

Marco Roeland, Tue, Dec 19, 2006 10:13:19 +0100:
> > Not that I personally frequently clone large projects on Mac OS X.
> > But new users to Git might.  :-)
> 
> And perhaps the Cygwin version might benefit too.

Does not work there at all. Even errno is not set (0).
