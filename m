From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 19:06:41 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702221904210.27932@xanadu.home>
References: <20070222202812.8882.44375.stgit@c165>
 <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221550290.27932@xanadu.home>
 <Pine.LNX.4.63.0702222157000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221605080.27932@xanadu.home>
 <7vhctddge7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 01:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKNxZ-00026o-2A
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 01:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXBWAGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 19:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbXBWAGq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 19:06:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41594 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXBWAGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 19:06:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDW00K8Z2Z7CG40@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Feb 2007 19:06:44 -0500 (EST)
In-reply-to: <7vhctddge7.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40400>

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> However, because ! test -f "$THIS_INDEX" is such a special case
> (totally new check-in), we can afford to be verbose if we wanted
> to, and offer tons of possibilities, say:
> 
> 	die 'nothing to commit.  You can use "git add file..."
> to include individual files, or use "git add ." if you want to 
> include all files in the current directory, for your first
> commit.'
> 
> But if we want to say "for your first commit" in the message, we
> should also be checking if HEAD commit really does not exist.

Seems to me that the single line message avoids all those issues.


Nicolas
