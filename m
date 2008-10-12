From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Sun, 12 Oct 2008 11:38:55 -0700
Message-ID: <20081012183855.GA5255@spearce.org>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:41:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5sQ-0002fY-T1
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbYJLSi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYJLSi5
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:38:57 -0400
Received: from george.spearce.org ([209.20.77.23]:57270 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYJLSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:38:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AFB683835F; Sun, 12 Oct 2008 18:38:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98045>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> When a tracked file was hard linked, we used to break the hard link
> whenever Git writes to that file.  Make that optional.

Why would anyone want to do this?

I cannot fathom why a user wants this much rope to hang themselves
with...

 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 173386e..7bfe431 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -207,6 +207,10 @@ core.symlinks::
>  	file. Useful on filesystems like FAT that do not support
>  	symbolic links. True by default.
>  
> +core.keepHardLinks::
> +	If true, do not break hard links by deleting and recreating the
> +	files.  Off by default.
> +
>  core.gitProxy::
>  	A "proxy command" to execute (as 'command host port') instead
>  	of establishing direct connection to the remote server when

-- 
Shawn.
