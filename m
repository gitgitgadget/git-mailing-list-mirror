From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 20:48:12 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKm1f-00015A-Sn
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbXBXBsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbXBXBsh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:48:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25405 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933320AbXBXBsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:48:36 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDY0087B2CCD130@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Feb 2007 20:48:12 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40486>

On Sat, 24 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> Since most servers will not have a no-progress aware upload-pack, how 
> about this? (It is slightly ugly, but at least works...)

Just slightly.

Why not simply filtering any string that ends in '\r' ?


Nicolas
