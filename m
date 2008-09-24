From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/5] git-gui: Squash populate_{push,fetch}_menu to
	populate_remotes_menu
Date: Thu, 25 Sep 2008 00:23:57 +0200
Message-ID: <20080924222357.GK10544@machine.or.cz>
References: <20080924221249.037449176@suse.cz> <20080924221732.257739465@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 00:25:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KicnG-00024q-09
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 00:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbYIXWX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbYIXWX7
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 18:23:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58555 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbYIXWX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 18:23:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 31EFE393A2DD; Thu, 25 Sep 2008 00:23:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080924221732.257739465@suse.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96704>

On Thu, Sep 25, 2008 at 12:12:52AM +0200, pasky@suse.cz wrote:
> The meat of the routines is now separated to add_fetch_entry() and
> add_push_entry(). This refactoring will allow easy implementation of adding
> individual remotes later.
> 
> This patch has been sponsored by Novartis.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Sorry, this patch slipped through from another series ;-) - please
disregard.

Also, the PATCH 4/5 has slight dependency on the git-gui remotes series,
but the change to git-gui/lib/remote_add.tcl can just be trimmed if this
would be to go in earlier.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
