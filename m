From: Nicolas Pitre <nico@cam.org>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 10:23:43 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701241020590.3011@xanadu.home>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
 <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
 <7vps94fweq.fsf@assigned-by-dhcp.cox.net>
 <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 16:23:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9jyW-00016V-K4
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 16:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXAXPXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 10:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbXAXPXp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 10:23:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41073 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXAXPXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 10:23:44 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCD008KGPFJBF90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Jan 2007 10:23:43 -0500 (EST)
In-reply-to: <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37645>

On Wed, 24 Jan 2007, Junio C Hamano wrote:

> However, I suspect that we could do better with Shawn's new
> fangled describe implementation that actually counts the
> distance between what is described and the tag.  We could add
> "number of commits since the tag" somewhere, to describe:
> 
> 	v2.6.20-rc5-256-g419dd83
>         v2.6.20-rc5-217-gde14569
> 
> to say that the first one has 256 commits accumulated since the
> given tag "v2.6.20-rc5" and the second one has only 217
> commits, to get the sense of how busy the development activity
> is.
> 
> Is it useful?  That is something I am not sure.

I think this would be really nice to have even if not absolutely useful.


Nicolas
