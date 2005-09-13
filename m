From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Define relative .git/objects/info/alternates semantics.
Date: Tue, 13 Sep 2005 12:31:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509131224290.23242@iabervon.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org> <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
 <52irx7cnw5.fsf@cisco.com> <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
 <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509112038020.3242@g5.osdl.org> <7vk6hl4fd9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 18:30:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFDdh-0002AB-Gh
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 18:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVIMQ1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVIMQ1f
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 12:27:35 -0400
Received: from iabervon.org ([66.92.72.58]:58372 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964855AbVIMQ1b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 12:27:31 -0400
Received: (qmail 32530 invoked by uid 1000); 13 Sep 2005 12:31:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2005 12:31:38 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6hl4fd9.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8472>

On Tue, 13 Sep 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Yes. We should probably have some well-defined meaning for relative paths
> > in there regardless (eg just define that they are always relative to the
> > main GIT_OBJECT_DIRECTORY or something).
> >
> > That would also allow mirrors to mirror the git archives in different 
> > places, without upsetting the result (as long as they are mirrored 
> > together).
> >
> > 		Linus
> 
> This patch is request-for-comments.  I have experimented it and
> have a feeling that it may be more intuitive to make it relative
> to $project.git/ directory, instead of $project.git/objects as
> you originally suggested, in which case a maintainer tree would
> have "../../torvalds/linux-2.6.git/objects" instead (one less
> dotdot), and if nobody objects that is probably what I'll end up
> doing.

It seems odd to have the "objects" at the end and not be starting from 
"objects". I suspect that the most intuitive thing would be for something 
under $project.git/info to be .git to .git, while something under 
.git/objects/info should be objects to objects.

	-Daniel
*This .sig left intentionally blank*
