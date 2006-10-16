From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Mon, 16 Oct 2006 09:27:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610160925580.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
 <7vac3xzbze.fsf@assigned-by-dhcp.cox.net> <egtu1r$813$1@sea.gmane.org>
 <Pine.LNX.4.64.0610151433310.17085@xanadu.home>
 <7v64ekyikn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 15:28:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZSW8-0008IW-Hs
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 15:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJPN14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWJPN14
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 09:27:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:7369 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750700AbWJPN1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 09:27:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J78006NADEI9FM1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Oct 2006 09:27:55 -0400 (EDT)
In-reply-to: <7v64ekyikn.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28958>

On Sun, 15 Oct 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > As for pack v4... My opinion is that nothing justifies it so far.  So if 
> > I can convince Junio there shouldn't be any v4 just yet.
> 
> The only concern I have is the commit walkers (rsync has the
> same problem as well but we honestly do not care).  They just
> grab existing packs and try to use them.  I have been wondering
> if it might be safer to mark the delta-base-offset encoded packs
> v4 to make sure the clients would get "I know only v2 and v3 but
> you fed me v4" message.

It'll get "this pack contains an unknown object type" kind of message, 
which is almost as good IMHO, with the same end result.


Nicolas
