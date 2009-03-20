From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] import-tars: separate author from committer
Date: Fri, 20 Mar 2009 07:43:52 -0700
Message-ID: <20090320144352.GZ23521@spearce.org>
References: <1237543070-4909-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 15:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkfyP-0003ci-UW
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 15:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbZCTOnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 10:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbZCTOny
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 10:43:54 -0400
Received: from george.spearce.org ([209.20.77.23]:58648 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCTOny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 10:43:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CE2B538221; Fri, 20 Mar 2009 14:43:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1237543070-4909-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113965>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> The import-tars script is typically employed to (re)create the past
> history of a project from stored tars. Although assigning authorship in
> these cases can be a somewhat arbitrary process, it makes sense to set
> the author to whoever created the tars in the first place (if it's
> known), and (s)he can in general be different from the committer
> (whoever is running the script).
> 
> Implement this by having separate author and committer data, making them
> settable from the usual GIT_* environment variables.
> ---
> 
> Or should I have made the ENV access a separate patch?

Looks fine to me.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
