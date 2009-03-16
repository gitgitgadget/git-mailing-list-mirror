From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 02/10] Rename the objectsUrl in the nested
	HttpObjectDB to
Date: Mon, 16 Mar 2009 13:25:13 -0700
Message-ID: <20090316202513.GS22920@spearce.org>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@sparce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:26:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJOX-00036E-TW
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241AbZCPUZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760321AbZCPUZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:25:16 -0400
Received: from george.spearce.org ([209.20.77.23]:59105 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759236AbZCPUZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:25:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B430138211; Mon, 16 Mar 2009 20:25:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113377>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> It is used for looking at alternate objects, so name it such

No SOB?

But I disagree with this name change.  Its pointing at the
objects directory of a repository.  It may also be used to
point at an alternate when opening an alternate, in which
case it points at the alternate's objects directory.

IMHO, objectsUrl is the right name for this.

> ---
>  .../org/spearce/jgit/transport/TransportHttp.java  |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
> index fe4a437..38d26b3 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
> @@ -112,15 +112,15 @@ public void close() {
>  	}
>  
>  	class HttpObjectDB extends WalkRemoteObjectDatabase {
> -		private final URL objectsUrl;
> +		private final URL alternateObjectsUrl;

-- 
Shawn.
