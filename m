From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: fix typo in lib/blame.tcl
Date: Thu, 27 Sep 2007 22:14:09 -0400
Message-ID: <20070928021409.GS3099@spearce.org>
References: <200709271453.25772.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 04:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib5Mz-0001xF-Kv
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 04:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791AbXI1COO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 22:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbXI1COO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 22:14:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41443 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784AbXI1CON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 22:14:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ib5Md-00077V-Sg; Thu, 27 Sep 2007 22:14:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CCA5120FBAE; Thu, 27 Sep 2007 22:14:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709271453.25772.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59351>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> diff --git a/lib/blame.tcl b/lib/blame.tcl
> index a911c3c..00ecf21 100644
> --- a/lib/blame.tcl
> +++ b/lib/blame.tcl
> @@ -905,7 +905,7 @@ method _open_tooltip {cur_w} {
>  		set author_time {}
>  		catch {set author_name $header($cmit,author)}
>  		catch {set summary     $header($cmit,summary)}
> -		catch {set author_time [foramt_date $header($cmit,author-time)]}
> +		catch {set author_time [format_date $header($cmit,author-time)]}

Shame on me.  Thanks for the fix.  :-)

-- 
Shawn.
