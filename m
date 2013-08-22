From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCHv2 0/6] duplicate objects and delta cycles, oh my!
Date: Thu, 22 Aug 2013 19:35:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308221933450.14472@syhkavp.arg>
References: <20130821204955.GA28025@sigill.intra.peff.net>
 <20130821205220.GB28165@sigill.intra.peff.net>
 <CACsJy8DkUeS3s+X=gKX4ZAi82g_D_9t=bBVs8NNY2EeqM9W-rQ@mail.gmail.com>
 <20130822144305.GA21219@sigill.intra.peff.net>
 <20130822231215.GA16978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 23 01:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCePZ-0000pk-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab3HVXf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 19:35:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25390 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab3HVXfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 19:35:25 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MRY00H4SHITG1A0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Aug 2013 19:35:17 -0400 (EDT)
In-reply-to: <20130822231215.GA16978@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232794>

On Thu, 22 Aug 2013, Jeff King wrote:

> On Thu, Aug 22, 2013 at 10:43:05AM -0400, Jeff King wrote:
> 
> > > write_idx_file() is called after index-pack processes all delta
> > > objects. Could resolve_deltas() go cyclic with certain duplicate
> > > object setup?
> > 
> > Good question. I'm not sure. I'll check it out.
> 
> I think the answer is "no", based on both reasoning and testing (both of
> which are included in patches 3-4 of the series below).
> 
> So here's my re-roll of the series.

This looks all good to me.


Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
