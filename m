From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Documentation: Add missing git svn commands
Date: Mon, 19 May 2008 19:01:43 -0700
Message-ID: <20080520020143.GB9904@hand.yhbt.net>
References: <48320380.6090200@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Daniel Berlin <dberlin@dberlin.org>
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue May 20 04:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyHBV-0007mB-Cd
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 04:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbYETCBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 22:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYETCBq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 22:01:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37867 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbYETCBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 22:01:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A3FF62DC08B;
	Mon, 19 May 2008 19:01:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48320380.6090200@isy.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82459>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

Looks correct, thanks.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> 
> I sent this one out about a week ago and haven't heard anything about 
> it.  Did it just get lost in the noise, or is it just not 
> interesting/incorrect in some way?

Sorry I've been very busy lately and haven't been feeling well, either.
I'll try to get around to the rest of the outstanding git-svn stuff as
soon as I get better.

> /Gustaf
> 
>  Documentation/git-svn.txt |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index f4ba105..c02f220 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -189,10 +189,10 @@ All arguments are passed directly to `git blame'.
>  	independently of git-svn functions.
> 
>  'create-ignore'::
> -
>  	Recursively finds the svn:ignore property on directories and
>  	creates matching .gitignore files. The resulting files are staged to
> -	be committed, but are not committed.
> +	be committed, but are not committed. Use -r/--revision to refer to a
> +	specfic revision.
> 
>  'show-ignore'::
>  	Recursively finds and lists the svn:ignore property on
> @@ -216,6 +216,19 @@ All arguments are passed directly to `git blame'.
>  	argument.  Use the --url option to output only the value of the
>  	'URL:' field.
> 
> +'proplist'::
> +	Lists the properties stored in the Subversion repository about a
> +	given file or directory.  Use -r/--revision to refer to a specific
> +	Subversion revision.
> +
> +'propget'::
> +	Gets the Subversion property given as the first argument, for a
> +	file.  A specific revision can be specified with -r/--revision.
> +
> +'show-externals'::
> +	Shows the Subversion externals.  Use -r/--revision to specify a
> +	specific revision.
> +
>  --
> 
>  OPTIONS
> -- 
-- 
Eric Wong
