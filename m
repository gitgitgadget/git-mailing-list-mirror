From: Eric Wong <normalperson@yhbt.net>
Subject: do_switch()-enabled SVN binaries for git-svn
Date: Tue, 22 May 2007 02:36:02 -0700
Message-ID: <20070522093602.GB17099@muzzle>
References: <86abvylihb.fsf@lola.quinscape.zz> <20070522091619.GA17099@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 22 11:36:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqQmm-0005N0-GO
	for gcvg-git@gmane.org; Tue, 22 May 2007 11:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbXEVJgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbXEVJgF
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 05:36:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38512 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbXEVJgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 05:36:04 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C80A67DC0A5;
	Tue, 22 May 2007 02:36:02 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 22 May 2007 02:36:02 -0700
Content-Disposition: inline
In-Reply-To: <20070522091619.GA17099@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48089>

Eric Wong <normalperson@yhbt.net> wrote:
> If recompiling SVN is feasible for you and the branches (as a fresh
> checkout) are as big as trunk, I highly recommend the do_switch patch
> for SVN which lets you transfer only a delta between the branch/tag
> point of trunk:
> 
> http://svn.haxx.se/dev/archive-2007-01/0936.shtml

In case you're using Debian x86-32, I've uploaded .deb packages
(with full, Debian sources) here:

http://git-svn.bogomips.org/svn/

The patch by itself is available here:

http://git-svn.bogomips.org/svn/switch-editor-perl.diff

-- 
Eric Wong
