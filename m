From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor
	for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Mon, 10 Aug 2009 08:52:07 -0700
Message-ID: <20090810155207.GW1033@spearce.org>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 17:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXAZ-0001Sk-14
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbZHJPwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZHJPwI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:52:08 -0400
Received: from george.spearce.org ([209.20.77.23]:40063 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZHJPwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:52:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A908B381FD; Mon, 10 Aug 2009 15:52:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125470>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
> ---
>  .../src/org/spearce/jgit/lib/AnyObjectId.java      |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
> index acb3cb5..015042a 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
> @@ -448,6 +448,12 @@ public final String name() {
>  	}
>  
>  	/**
> +	 * @return string form of the SHA-1, in lower case hexadecimal.
> +	 */
> +	public final String getName() {
> +		return name();
> +	}

Obviously you didn't compile test this in JGit:

./org/spearce/jgit/revwalk/RevTag.java:206: getName() in
org.spearce.jgit.revwalk.RevTag cannot override getName() in
org.spearce.jgit.lib.AnyObjectId; overridden method is final

:-(

-- 
Shawn.
