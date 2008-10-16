From: Nicolas Pitre <nico@cam.org>
Subject: Re: Detached checkout will clobber branch head when using symlink HEAD
Date: Thu, 16 Oct 2008 16:47:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810161646550.26244@xanadu.home>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <alpine.LFD.2.00.0810161619330.26244@xanadu.home>
 <1224188939.2796.22.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Matt Draisey <matt@draisey.ca>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:49:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZmN-0008B9-E1
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbYJPUrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919AbYJPUrz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:47:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37778 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbYJPUrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:47:55 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8U000VSN3OOQ40@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 16 Oct 2008 16:47:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1224188939.2796.22.camel@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98425>

On Thu, 16 Oct 2008, Matt Draisey wrote:

> On Thu, 2008-10-16 at 16:20 -0400, Nicolas Pitre wrote:
> > A symlink HEAD and detached checkouts are simply incompatible.
> 
> Not necessarily.  The symlinking code will unlink the original inode
> each time it creates a new symlink anyway.  It is simply a matter of
> creating a new file in its place.

True.  I didn't think it all through initially.


Nicolas
