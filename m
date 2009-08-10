From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: remove warning when deleting correctly merged
	remote branch
Date: Mon, 10 Aug 2009 08:47:21 -0700
Message-ID: <20090810154720.GV1033@spearce.org>
References: <20090615211956.GB8065@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaX6d-0007zZ-3S
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbZHJPrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZHJPrU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:47:20 -0400
Received: from george.spearce.org ([209.20.77.23]:47040 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbZHJPrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:47:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0D33D381FD; Mon, 10 Aug 2009 15:47:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090615211956.GB8065@macbook.lan>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125468>

Heiko Voigt <hvoigt@hvoigt.net> wrote:
> If the user wants to delete a remote branch and selects the correct
> "merged into" we should not warn that "Recovering deleted branches is
> difficult". For local branches we do the same already.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  git-gui/lib/remote_branch_delete.tcl |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)

Thanks, applied.
 
-- 
Shawn.
