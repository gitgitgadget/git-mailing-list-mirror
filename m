From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Tags not transferred with git pull?
Date: Fri, 4 Nov 2005 10:57:06 -0500
Message-ID: <20051104155706.GA2473@delft.aura.cs.cmu.edu>
References: <20051104155314.GB23790@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 17:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY3wX-0007xu-4B
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 16:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbVKDP50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 10:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbVKDP50
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 10:57:26 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:13213 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1161149AbVKDP5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 10:57:25 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1EY3wA-0000kO-00; Fri, 04 Nov 2005 10:57:06 -0500
To: Erik Mouw <erik@harddisk-recovery.com>
Mail-Followup-To: Erik Mouw <erik@harddisk-recovery.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051104155314.GB23790@harddisk-recovery.nl>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11137>

On Fri, Nov 04, 2005 at 04:53:14PM +0100, Erik Mouw wrote:
> Is it OK that the latest git (0.99.9c) doesn't get the tags
> (refs/tags/*) when doing a git pull? It's getting a bit of a nuisance
> to do a separate rsync to get them right.

You don't need to fall back on rsync,

    git fetch --tags

Jan
