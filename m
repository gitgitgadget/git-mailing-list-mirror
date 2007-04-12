From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Document the GIT branches -> CVS modules mapping more prominently
Date: Thu, 12 Apr 2007 15:05:51 -0700
Message-ID: <7v3b35jlj4.fsf@assigned-by-dhcp.cox.net>
References: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
	<11763896683800-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc7Qb-0007sF-8y
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 00:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030810AbXDLWFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 18:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030814AbXDLWFx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 18:05:53 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57751 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030810AbXDLWFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 18:05:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412220552.HQMH1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 18:05:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mN5r1W00g1kojtg0000000; Thu, 12 Apr 2007 18:05:52 -0400
In-Reply-To: <11763896683800-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Thu, 12 Apr 2007 16:54:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44358>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Add a note about the branches -> modules mapping to LIMITATIONS because
> I really think it should be noted there and not just at the end of
> the installation step-by-step HOWTO.
>
> I used "git branches" there and changed "heads" to "branches" in
> my section about database configuration. I'm reluctant to replace
> all occourences of "head" with "branch" though because you always
> have to say "git branch" because CVS also has the concept of
> branches. You can say "head" though, because there is no such
> concept in CVS. In all the existing occourences of head other than
> the one I changed I think "head" flows better in the text.

Ah, I tend to agree.  Mind if I applied only the first hunk then?

>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  Documentation/git-cvsserver.txt |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
>  Caused by me thinking about Junio's comment.
>  Better patches welcome but my motivation to try to write clear
>  and concise sentences in English is depleted for now,
>  so no critical comments without patches, plz :)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index 9fbaf75..3615ce5 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -31,6 +31,10 @@ over pserver for anonymous CVS access.
>  
>  CVS clients cannot tag, branch or perform GIT merges.
>  
> +git-cvsserver maps GIT branches to CVS modules. This is very different
> +from what most CVS users would expect since in CVS modules usually represent
> +one or more directories.
> +
>  INSTALLATION
>  ------------
>  
> @@ -110,7 +114,7 @@ Example:
>  Database Backend
>  ----------------
>  
> -git-cvsserver uses one database per git head (i.e. CVS module) to
> +git-cvsserver uses one database per git branch (i.e. CVS module) to
>  store information about the repository for faster access. The
>  database doesn't contain any persitent data and can be completly
>  regenerated from the git repository at any time. The database
> -- 
> 1.5.1
