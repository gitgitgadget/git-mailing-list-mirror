From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-import.sh using git-fast-import
Date: Wed, 29 Aug 2007 11:20:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708291116310.16727@xanadu.home>
References: <fcaeb9bf0708270913o37b2dbdfw2f5f7d89d9ab1d21@mail.gmail.com>
 <20070828035430.GJ18160@spearce.org>
 <20070828055431.GA28311@coredump.intra.peff.net>
 <20070828061118.GO18160@spearce.org>
 <20070828063316.GB5444@coredump.intra.peff.net>
 <20070829034725.GR18160@spearce.org>
 <20070829041120.GA25779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 17:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQPLT-0006j0-G1
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 17:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXH2PUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 11:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXH2PUf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 11:20:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36208 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbXH2PUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 11:20:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNJ00MCMJY1C1L2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Aug 2007 11:20:26 -0400 (EDT)
In-reply-to: <20070829041120.GA25779@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56961>

On Wed, 29 Aug 2007, Jeff King wrote:

> On Tue, Aug 28, 2007 at 11:47:25PM -0400, Shawn O. Pearce wrote:
> 
> > Yea, so like the parallel pack-objects experiment that Nico had
> > done recently we decreased wall-clock time at the expense of using a
> > larger amount of the system resources.  That is bad as we use more
> > CPU time than we saved in wallclock time.  Usually a bad tradeoff,
> > unless you have a realtime requirement you have to meet.
> 
> It depends. If we all have 64-core processors in a few years, then it
> might be a better tradeoff.

Depends.  In the experiment I did, I clearly identified flaws showing 
that the direction was bad and that another approach has to be pursued.  
Thinking in terms of 64-core processors is no excuse for bad designs.

> Of course, some users might want to optimize
> for wall-clock time, while others want power consumption, etc.

Better get both at the same time when possible.


Nicolas
