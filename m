From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: serious performance issues with images, audio files,
 and other "non-code" data
Date: Tue, 18 May 2010 15:59:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005181557250.12758@xanadu.home>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
 <20100518194105.GA4723@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 21:59:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESxJ-0006X0-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab0ERT7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:59:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45032 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0ERT7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:59:51 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L2M00033SVR1C20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 May 2010 15:59:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100518194105.GA4723@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147305>

On Tue, 18 May 2010, Jeff King wrote:

> On Tue, May 18, 2010 at 03:33:58PM -0400, Nicolas Pitre wrote:
> 
> > > It will have to write the whole 200M packfile out each time, though.
> > 
> > No.  gc will only create a pack with new loose objects by default.  
> > Only if the number of packs grow too large will it combine them into one 
> > pack.
> 
> I think that is only "gc --auto".

Argh. You're right.  And "gc --auto" is already ran by many commands 
already.

It is "git repack" that doesn't combine packs by default.


Nicolas
