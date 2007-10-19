From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 22:49:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182247130.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iihvi-0003se-4c
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765911AbXJSCt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765924AbXJSCt3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:49:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27568 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764208AbXJSCt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:49:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ500B1P16FU7N2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 22:49:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019022154.GY14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61616>

On Thu, 18 Oct 2007, Shawn O. Pearce wrote:

> I really don't have an opinion either way.  Actually I think the
> entire progress system of git-pack-objects should be reduced even
> further so that users aren't exposed to the internal phases we
> are going through.  Most of them just don't care.  They just
> want to know when its going to be done[*1*].

Well, with my latest patches in that area, the typical progress on 
screen has been cut in half.  And the different phases are intertaining.


Nicolas
