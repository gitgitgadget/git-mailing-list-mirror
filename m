From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Wed, 18 Mar 2009 14:02:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903181401000.30483@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
 <20071205.202047.58135920.davem@davemloft.net>
 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
 <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
 <Pine.LNX.4.64.0712061201580.27959@racer.site>
 <alpine.DEB.1.00.0903181657180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk08P-0002ym-Bp
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542AbZCRSDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759069AbZCRSDa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:03:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22699 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505AbZCRSD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:03:29 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGP00BGERGF4A20@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Mar 2009 14:02:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0903181657180.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113645>

On Wed, 18 Mar 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 6 Dec 2007, Johannes Schindelin wrote:
> 
> > 
> > The default was not to change the window or depth at all.  As suggested
> > by Jon Smirl, Linus Torvalds and others, default to
> > 
> > 	--window=250 --depth=250
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Guess what.  This is still unresolved, and yet somebody else had to be 
> bitten by 'git gc --aggressive' being everything but aggressive.
> 
> So...  I think it is high time to resolve the issue, either by applying 
> this patch with a delay of over one year, or by the pack wizards trying to 
> implement that 'never fall back to a worse delta' idea mentioned in this 
> thread.

This is just a bit complicated to implement (cycle avoidance, etc).

> Although I suggest, really, that implying --depth=250 --window=250 (unless 
> overridden by the config) with --aggressive is not at all wrong.

ACK.


Nicolas
