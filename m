From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] bash completion: refactor --strategy completion
Date: Fri, 6 Mar 2009 08:32:33 -0800
Message-ID: <20090306163233.GL16213@spearce.org>
References: <20090306161657.GJ16213@spearce.org> <1236357044-55479-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfczr-0007m4-VR
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZCFQcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbZCFQcf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:32:35 -0500
Received: from george.spearce.org ([209.20.77.23]:52602 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbZCFQcf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:32:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 839D738211; Fri,  6 Mar 2009 16:32:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236357044-55479-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112465>

Jay Soffian <jaysoffian@gmail.com> wrote:
> The code to complete --strategy was duplicated between _git_rebase and
> _git_merge, and is about to gain a third caller (_git_pull). This patch
> factors it into its own function.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> How about like this intead? This way 3/3 doesn't need to be adjusted. The
> interdiff is:

Yup, that works too!

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
>  contrib/completion/git-completion.bash |   38 ++++++++++++++++---------------
>  1 files changed, 20 insertions(+), 18 deletions(-)

-- 
Shawn.
