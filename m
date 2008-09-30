From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Improve git-log documentation wrt file filters
Date: Tue, 30 Sep 2008 12:25:53 -0700
Message-ID: <20080930192553.GI21310@spearce.org>
References: <1222785372-32336-1-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:27:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkksE-0006kB-KI
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbYI3TZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYI3TZy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:25:54 -0400
Received: from george.spearce.org ([209.20.77.23]:33576 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYI3TZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:25:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7B1673835F; Tue, 30 Sep 2008 19:25:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222785372-32336-1-git-send-email-madduck@madduck.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97148>

"martin f. krafft" <madduck@madduck.net> wrote:
> The need for "--" in the git-log synopsis was previously unclear and
> confusing. This patch makes it a little clearer.
 
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 0446bad..b7409f8 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -8,7 +8,7 @@ git-log - Show commit logs
>  
>  SYNOPSIS
>  --------
> -'git log' <option>...
> +'git log' [<options>] [<since>..<until>] [[--] <path>...]

This part is really useful.

>  DESCRIPTION
>  -----------
> @@ -57,8 +57,10 @@ include::diff-options.txt[]
>  	Note that only message is considered, if also a diff is shown
>  	its size is not included.
>  
> -<path>...::
> -	Show only commits that affect any of the specified paths.
> +-- <path>...::
> +	Show only commits that affect any of the specified paths. To
> +        prevent confusion with options and branch names, paths should be
> +        prefixed with "-- " to separate them from options or refnames.

Indentation here looks wrong, especially on the last two lines.

I'm also not sure we want to say "-- <path>" in the header for
this section.  The -- is optional but I'm reading this as though it
is required.  Maybe "... paths can be prefixed with -- ..." instead?

-- 
Shawn.
