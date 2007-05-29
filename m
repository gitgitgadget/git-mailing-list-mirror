From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's new in git-gui.git
Date: Tue, 29 May 2007 13:18:36 +0200
Message-ID: <20070529111836.GW4489@pasky.or.cz>
References: <20070528224949.GC7044@spearce.org> <20070529041108.GG7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 29 13:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hszj5-0000pz-Vd
	for gcvg-git@gmane.org; Tue, 29 May 2007 13:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbXE2LSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 07:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbXE2LSi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 07:18:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34859 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351AbXE2LSi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 07:18:38 -0400
Received: (qmail 3149 invoked by uid 2001); 29 May 2007 13:18:36 +0200
Content-Disposition: inline
In-Reply-To: <20070529041108.GG7044@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48684>

On Tue, May 29, 2007 at 06:11:08AM CEST, Shawn O. Pearce wrote:
> Apparently the Linux folks have this new fangled inotify thing
> that is also good at telling applications about changed files.
> It seems the hg folks are using it to speed up "hg status" by
> having a background daemon keep track of which files are dirty,
> and which aren't.

How well does this play with NFS? I'm working at two places and at both
have my ~ on NFS and sometimes touch the working tree from various
machines. Would the inotify-based approach silently fail here? Or does
inotify just refuse to work on NFS? Quick google search suggests the
former, which is more than ok for informative purposes but big problem
if you actually _rely_ on the inotify to keep your index up-to-date.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
