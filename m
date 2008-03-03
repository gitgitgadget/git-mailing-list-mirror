From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Mon, 03 Mar 2008 13:26:42 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803031320180.2899@xanadu.home>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:27:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFNp-0005Wy-5w
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbYCCS0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbYCCS0o
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:26:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16700 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYCCS0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:26:43 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX60084438I7100@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Mar 2008 13:26:43 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75962>

On Mon, 3 Mar 2008, Matthieu Moy wrote:

> A merge is not necessarily with a remote branch, it can be with any
> commit object.
> ---
>  Documentation/git-merge.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 0c9ad7f..193c9c0 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -68,7 +68,8 @@ HOW MERGE WORKS
>  ---------------
>  
>  A merge is always between the current `HEAD` and one or more
> -remote branch heads, and the index file must exactly match the
> +commit objects (usually, branch head or tag), and the index file must
> +exactly match the
>  tree of `HEAD` commit (i.e. the contents of the last commit) when
>  it happens.  In other words, `git-diff --cached HEAD` must
>  report no changes.

I don't like this wording.  Using "object" here wouldn't help avoiding 
Paolo's confusion at all.

You don't really merge a commit _object_.
You merge with one or more other commits, tipycally identified by a 
branch name or a tag.


Nicolas
