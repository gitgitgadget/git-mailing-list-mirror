From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:41:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610181736320.1971@xanadu.home>
References: <200610180057.25411.jnareb@gmail.com>
 <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
 <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
 <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
 <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJAS-0002Db-OR
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbWJRVlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423011AbWJRVlh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:41:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30193 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1423009AbWJRVlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:41:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00A7MPLCIU20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 17:41:36 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29274>

On Wed, 18 Oct 2006, Linus Torvalds wrote:

> There are bigger reasons to _never_ allow packs to contain deltas to 
> outside of themselves:
> 
>  - there's no point. 

Remember what I said earlier: "If there are advantages to do so then 
maybe."  So far there are none.

>    You could end up with a situation where you get two packs from two 
>    different sources, and they contain deltas to _each_other_, and you 
>    have no way of actually generating the object itself any more.

To me this is the real killer.

Shawn was talking about a different issue though.


Nicolas
