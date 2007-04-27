From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] [PATCH] git-mirror - exactly mirror another repository
Date: Fri, 27 Apr 2007 00:39:41 -0400
Message-ID: <20070427043941.GM5942@spearce.org>
References: <20070427020601.22991.13792.stgit@rover> <20070427020606.22991.14661.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIFt-0007xS-9h
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbXD0EkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbXD0EkW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:40:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47203 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbXD0Ejs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:39:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HhIFD-0007AB-U0; Fri, 27 Apr 2007 00:39:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5397820FBAE; Fri, 27 Apr 2007 00:39:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070427020606.22991.14661.stgit@rover>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45687>

Petr Baudis <pasky@suse.cz> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e0aff53..e05e4c5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -513,6 +513,12 @@ log.showroot::
>  	Tools like gitlink:git-log[1] or gitlink:git-whatchanged[1], which
>  	normally hide the root commit will now show it. True by default.
>  
> +mirror.allowed::
> +	If true, gitlink:git-mirror[1] will be allowed to run on the
> +	repository.  Please see its documentation for all the implications.
> +
> +mirror.
> +

Uhhh.... what's that mirror. line for?

> +++ b/git-mirror.perl

Otherwise, Ack'd.

-- 
Shawn.
