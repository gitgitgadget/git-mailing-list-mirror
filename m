From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 10 Jan 2007 22:50:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701102241230.4964@xanadu.home>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
 <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 04:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4qxG-0000Uk-1h
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 04:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbXAKDuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 22:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXAKDuE
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 22:50:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33923 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbXAKDuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 22:50:01 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBO007NDQNCOG30@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Jan 2007 22:50:00 -0500 (EST)
In-reply-to: <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36546>

On Wed, 10 Jan 2007, Junio C Hamano wrote:

> * jc/detached-head (Tue Jan 9 20:39:09 2007 -0800) 9 commits

I want to say that this is really great and well done.

> * sp/describe (Wed Jan 10 06:39:47 2007 -0500) 1 commit
>  - Chose better tag names in git-describe after merges.
> 
> Slowing it down by 4x is very unfortunate.  I think there is a
> better way to walk the ancestry than doing one at a time to
> count the commits, but I did not have enough time to look at
> this today.

However git-describe is certainly not a frequent and speed critical 
operation, and 
even if it cannot be sped up then waiting 300 ms more won't really 
affect one's workflow that badly.


Nicolas
