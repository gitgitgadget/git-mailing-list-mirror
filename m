From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [TopGit] Check for pre-commit hook existence.
Date: Sun, 3 Aug 2008 16:26:44 +0200
Message-ID: <20080803142644.GB10151@machine.or.cz>
References: <20080803031424.GV32184@machine.or.cz> <20080803141030.GC11179@maggie.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:27:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeYl-0005Rg-JN
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbYHCO0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbYHCO0q
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:26:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55640 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbYHCO0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:26:46 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A1D7D393A36E; Sun,  3 Aug 2008 16:26:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080803141030.GC11179@maggie.localnet>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91242>

On Sun, Aug 03, 2008 at 10:14:01PM +0800, Russell Steicke wrote:
> Running tg in a repo without an active pre-commit hook fails
> saying
> 
>   grep: .git/hooks/pre-commit: No such file or directory
>   cat: .git/hooks/pre-commit: No such file or directory
> 
> Even "tg help" does this!  So add extra checks for existence
> of the pre-commit hook.

Thanks, applied.

				Petr "Pasky" Baudis
