From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Documentation: Add create-ignore to git svn manual
Date: Sun, 4 May 2008 21:04:19 -0700
Message-ID: <20080505040419.GA13122@untitled>
References: <1209940390-22622-1-git-send-email-hendeby@isy.liu.se> <1209940390-22622-2-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon May 05 06:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsrwu-0003eO-9J
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYEEEEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 00:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYEEEEY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:04:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40663 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbYEEEEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 00:04:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A71462DC08B;
	Sun,  4 May 2008 21:04:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1209940390-22622-2-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81223>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> 
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  Documentation/git-svn.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index bec9acc..f4ba105 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -188,6 +188,12 @@ All arguments are passed directly to `git blame'.
>  	commit.  All merging is assumed to have taken place
>  	independently of git-svn functions.
>  
> +'create-ignore'::
> +
> +	Recursively finds the svn:ignore property on directories and
> +	creates matching .gitignore files. The resulting files are staged to
> +	be committed, but are not committed.
> +
>  'show-ignore'::
>  	Recursively finds and lists the svn:ignore property on
>  	directories.  The output is suitable for appending to
> -- 
> 1.5.5.1.246.gafa4
