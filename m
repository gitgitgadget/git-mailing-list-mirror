From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] common progress display support
Date: Wed, 18 Apr 2007 15:20:28 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181517360.4504@xanadu.home>
References: <alpine.LFD.0.98.0704181422050.4504@xanadu.home>
 <20070418185649.GB18328@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeFhk-00075a-AP
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 21:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993070AbXDRTUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 15:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993071AbXDRTUc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 15:20:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18589 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993070AbXDRTUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 15:20:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP00FOLKE44C50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 15:20:29 -0400 (EDT)
In-reply-to: <20070418185649.GB18328@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44932>

On Wed, 18 Apr 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > Note: I left merge-recursive.c out since it has a strange notion of
> > progress as it apparently increase the expected total number as it goes.
> > Someone with more intimate knowledge of what that is supposed to mean
> > might look at converting it to the common progress interface.
> 
> That disaster in merge-recursive.c is my fault.  The progress
> meter there doesn't mean much of anything.
> 
> I've been thinking about getting rid of it.

Well... be my guest.  ;-)


Nicolas
