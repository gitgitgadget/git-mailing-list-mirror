From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 11:39:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 17:39:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZr2L-0001YA-0V
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 17:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWJQPjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWJQPjW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 11:39:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18491 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751151AbWJQPjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 11:39:21 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A006K1E5K9EL4@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 11:39:20 -0400 (EDT)
In-reply-to: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29088>

On Mon, 16 Oct 2006, Junio C Hamano wrote:

> I'm still a bit under the weather and do not have enough
> concentration to dig into the problem tonight, but I noticed
> that something in "next", most likely the delta-base-offset
> patchset, broke git-index-pack:
> 
> $ X=ec0c3491753e115e1775256f6b7bd1bce4dea7cd
> $ wget http://www.kernel.org/pub/scm/git/git.git/objects/pack/pack-$X.pack
> $ ~/git-master/bin/git-index-pack pack-$X.pack
> ec0c3491753e115e1775256f6b7bd1bce4dea7cd
> $ git-index-pack pack-$X.pack
> fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has unresolved deltas

Using the tip of the "next" branch (git version 1.4.2.4.gf9fe) I just 
cannot reproduce this problem at all.  I always get a good index and 
ec0c3491753e115e1775256f6b7bd1bce4dea7cd back.


Nicolas
