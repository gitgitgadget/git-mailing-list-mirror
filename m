X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 13:24:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610261320080.12418@xanadu.home>
References: <45354AD0.1020107@utoronto.ca>
 <"BAYC1-PASMTP07AB11A64250AAF683424 DAE0E0"@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
 <"Pin e.LNX.4.64.0610240812410.3962"@g5.osdl.org>
 <"Pine.LNX.4.64N.0610241300450.811 2"@attu4.cs.washington.edu>
 <20061025084810.GA26618@coredump.intra.peff.net>
 <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
 <"20061025094900.G A26989"@coredump.intra.peff.net>
 <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
 <454098EC.8040406@op5.se> <Pine.LNX.4.64.0610261247420.12418@xanadu.home>
 <Pine.LNX.4.63.0610261003290.2424@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 17:25:13 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	David Rientjes <rientjes@cs.washington.edu>,
	Jeff King <peff@peff.net>, Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0610261003290.2424@qynat.qvtvafvgr.pbz>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30246>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8yR-0003ZM-Sh for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423676AbWJZRYs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423684AbWJZRYs
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:24:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34010 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1423676AbWJZRYp
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:24:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7R009Z9718U9I0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 13:24:45 -0400 (EDT)
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, David Lang wrote:

> On Thu, 26 Oct 2006, Nicolas Pitre wrote:
> 
> > The pack index is actually limited to 32-bits meaning it can cope with
> > packs no larger than 4G.
> 
> the offset within a pack for the starting location of an object cannot be
> larger then 4G.

To be more exact, yes.  But I don't think we'll ever consider use 
scenarios with packs > 4G with the current index format.  There is 
simply no point.


