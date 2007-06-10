From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Date: Sun, 10 Jun 2007 01:54:30 -0700
Message-ID: <20070610085430.GA17255@prophet.net-ronin.org>
References: <20070608100831.GA2335@cip.informatik.uni-erlangen.de> <7vodjqkazp.fsf@assigned-by-dhcp.cox.net> <7vk5uekagd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJdf-0001qs-2R
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbXFJJXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbXFJJXG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:23:06 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:40499 "EHLO
	prophet.net-ronin.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbXFJJXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:23:05 -0400
X-Greylist: delayed 1704 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2007 05:23:04 EDT
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1HxJBu-0005NY-00; Sun, 10 Jun 2007 01:54:30 -0700
Content-Disposition: inline
In-Reply-To: <7vk5uekagd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49696>

On Fri, Jun 08, 2007 at 03:27:30AM -0700, Junio C Hamano wrote:
> How did you get your repository into such a state to begin with?

It's kinda odd to see this thread, as I hit this issue today, as well.

If you need another test case, the cvsps git repo shows this too:

ramune/lycaeum:git: git clone  http://ydirson.free.fr/soft/git/cvsps.git
<snip checkout messages>
ramune/lycaeum:git: cd cvsps
ramune/lycaeum:cvsps: ls
ramune/lycaeum:cvsps: git checkout -f
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of HEAD.
fatal: just how do you expect me to merge 0 trees?
ramune/lycaeum:cvsps: cat .git/HEAD
ref: refs/heads/master
ramune/lycaeum:cvsps: ls .git/refs/head/master
ls: .git/refs/head/master: No such file or directory

-- DN
Daniel
