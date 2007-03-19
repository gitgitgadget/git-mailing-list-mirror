From: Nicolas Pitre <nico@cam.org>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 11:16:11 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191115180.18328@xanadu.home>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org>
 <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org>
 <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org>
 <20070319032130.GF11371@thunk.org> <20070319035351.GI20658@spearce.org>
 <alpine.LFD.0.83.0703182355570.18328@xanadu.home>
 <20070319062525.GH11371@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 16:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTJap-0007kz-H5
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 16:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965856AbXCSPQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965862AbXCSPQO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 11:16:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54236 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965856AbXCSPQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 11:16:13 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF500CO5P2ZZ9D0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 11:16:12 -0400 (EDT)
In-reply-to: <20070319062525.GH11371@thunk.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42625>

On Mon, 19 Mar 2007, Theodore Tso wrote:

> On Mon, Mar 19, 2007 at 12:08:47AM -0400, Nicolas Pitre wrote:
> > If the meaning of HEAD changed (although indirectly) because HEAD 
> > happens to point to the branch that just got updated then logically the 
> > HEAD reflog should be updated too.  On the other hand the HEAD reflog 
> > should reflect operations performed on HEAD.  Since the push updates the 
> > branch directly it is not exactly performing some operation on HEAD 
> > since HEAD could point anywhere and that wouldn't change the push at 
> > all.
> > 
> > Meaning that for the discussion of pushing to a non-bare repository with 
> > a dirty working tree... If the branch being pushed into is not pointed 
> > to by HEAD then no consideration what so ever about the working tree 
> > should be made, and no update to the HEAD reflog made of course.
> 
> Right, but if the branch being pointed to is pointed to by HEAD I
> would argue that the reflog for HEAD should be updated, since
> operations that reference HEAD will see a new commit, and and it will
> be confusing when "git reflog" shows no hint of the change.
> 
> Of couse, if the branch being pushed to isn't one which is pointed by
> HEAD, of course HEAD's reflog shouldn't be updated.

I think we're saying the exact same thing.


Nicolas
