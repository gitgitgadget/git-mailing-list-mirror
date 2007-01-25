From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Thu, 25 Jan 2007 18:32:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701251830400.3021@xanadu.home>
References: <20070125173954.GA13276@spearce.org>
 <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
 <7v7ivaailb.fsf@assigned-by-dhcp.cox.net> <20070125214923.GD13874@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAE4f-0007vl-Gu
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbXAYXcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXAYXcF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:32:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53266 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXAYXcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:32:04 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCG00KZ46PDMGD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 25 Jan 2007 18:32:02 -0500 (EST)
In-reply-to: <20070125214923.GD13874@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37778>

On Thu, 25 Jan 2007, Shawn O. Pearce wrote:

> We probably should make an option to enable the count, and
> if the count is enabled then we'll have to pickup counting
> where we left off and finish it out for the chosen tag so
> the count is correct.
Please don't make it an option.  This is too useful to require an 
additional switch all the time.


Nicolas
