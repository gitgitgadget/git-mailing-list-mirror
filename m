From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Mon, 23 Oct 2006 17:55:06 -0400
Message-ID: <20061023215506.GB8344@spearce.org>
References: <11616396262982-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 23 23:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc7lN-00026L-Sp
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWJWVzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWJWVzM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:55:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:21137 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752032AbWJWVzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 17:55:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gc7l5-0000GF-Pf
	for git@vger.kernel.org; Mon, 23 Oct 2006 17:54:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3772A21269E; Mon, 23 Oct 2006 17:55:07 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11616396262982-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29888>

Lars Hjemli <hjemli@gmail.com> wrote:
[snip]
> ---
>  Makefile         |    3 +-
>  builtin-branch.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h        |    1 +
>  git-branch.sh    |  131 --------------------------------
>  git.c            |    1 +
>  5 files changed, 221 insertions(+), 132 deletions(-)
[snip]
> diff --git a/git-branch.sh b/git-branch.sh
> deleted file mode 100755
> index 4379a07..0000000
> --- a/git-branch.sh
> +++ /dev/null
> @@ -1,131 +0,0 @@
[snip 131 lines]

Aside from compatability with non-Git tools...

Wouldn't it make more sense to just include the full SHA1 of the
file we are deleting rather than the entire 131 line negative diff?

-- 
Shawn.
