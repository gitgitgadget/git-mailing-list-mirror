From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 09:04:39 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704200900460.4504@xanadu.home>
References: <11770585393395-git-send-email-junkio@cox.net>
 <1177058540390-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:04:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hesn5-0003nf-Vz
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992741AbXDTNEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992787AbXDTNEl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:04:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992741AbXDTNEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 09:04:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGS006C0SBR5400@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Apr 2007 09:04:39 -0400 (EDT)
In-reply-to: <1177058540390-git-send-email-junkio@cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45101>

On Fri, 20 Apr 2007, Junio C Hamano wrote:

> Originally I thought it would take too long to check out many
> files and to prevent people from getting bored, I added progress
> meter.  But it feels a bit too noisy; let's disable it.

For large checkouts, say after a big clone, that might be quite long to 
check out large amount of files.

What about looking at the number of files checked out after say 2 
seconds, and if it is still below 50% of the total then turn on the 
progress display?


Nicolas
