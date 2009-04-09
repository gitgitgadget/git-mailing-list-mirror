From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RESEND [PATCH 1/1] Ensure consistent usage of
	mergetool.keepBackup
Date: Thu, 9 Apr 2009 08:30:33 -0700
Message-ID: <20090409153033.GN23604@spearce.org>
References: <cfb81044a29899f9dd0b46f10447243632c50c94.1239108064.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Thu Apr 09 17:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrwEd-0004EZ-06
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 17:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935326AbZDIPah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 11:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935324AbZDIPag
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 11:30:36 -0400
Received: from george.spearce.org ([209.20.77.23]:51733 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbZDIPae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 11:30:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DB01338211; Thu,  9 Apr 2009 15:30:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cfb81044a29899f9dd0b46f10447243632c50c94.1239108064.git.ferry.huberts@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116173>

Ferry Huberts <ferry.huberts@pelagic.nl> wrote:
> In several places merge.keepBackup is used i.s.o.
> mergetool.keepBackup. This patch makes it all
> consistent.
> 
> Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
> ---
> This patch is rebased on v1.6.2.2
> 
>  contrib/difftool/git-difftool.txt |    2 +-
>  git-gui/git-gui.sh                |    2 +-
>  git-gui/lib/mergetool.tcl         |    2 +-
>  git-mergetool.sh                  |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

git-gui patches should be sent by themselves as they apply to
git-gui.git which is then merged into git.git every so often.

Yesterday I broke the git-gui part out by hand and applied it to
git-gui.git.  You should break this patch down and send Junio the
non-git-gui half so he can more easily apply it to git.git.
 
-- 
Shawn.
