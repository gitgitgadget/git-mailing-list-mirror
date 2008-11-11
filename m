From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem with git gui on cygwin.
Date: Tue, 11 Nov 2008 09:05:57 -0800
Message-ID: <20081111170557.GI2932@spearce.org>
References: <loom.20081111T155614-227@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Jensen <jhjjhjjhj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:08:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzwhw-0001oV-HP
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYKKRF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbYKKRF6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:05:58 -0500
Received: from george.spearce.org ([209.20.77.23]:44820 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYKKRF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:05:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 77250381FF; Tue, 11 Nov 2008 17:05:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20081111T155614-227@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100651>

Jim Jensen <jhjjhjjhj@gmail.com> wrote:
> I have been trying to use git for a small project using cygwin.  I copied my
> repository from one windows XP system to a Vista system using a usb drive.  On
> the new system when I use "git gui" I get a pop up that says "Git directory not
> found: .git"
> 
> This happens with git gui and gitk.  The command line programs I tried, git show
> and git status appear to work.

Huh.  Sounds like the Tcl/Tk process isn't spawning the Cygwin git
process in the right directory or something.  Weird that both git-gui
and gitk are giving you errors; usually its git-gui that is being
paranoid about the repository structure and gitk works just fine.

You can try starting `git gui --trace` and see if that tells you
any more detail, but it doesn't show cwd so it may not be all that
useful to help you debug it.

-- 
Shawn.
