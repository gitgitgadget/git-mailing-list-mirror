From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui Error
Date: Wed, 14 Feb 2007 21:40:14 -0500
Message-ID: <20070215024014.GA29865@spearce.org>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org> <20070214060041.GA31871@spearce.org> <20070214174635.GA21612@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHWXo-0003KD-Te
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbXBOCkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 21:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbXBOCkW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:40:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57592 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869AbXBOCkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 21:40:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHWXX-0004fB-Sj; Wed, 14 Feb 2007 21:40:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B59DC20FBAE; Wed, 14 Feb 2007 21:40:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070214174635.GA21612@auto.tuwien.ac.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39792>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> I'm missing the possibility to base a new branch on a tag.
> The following adds a tag drop down to the new branch dialog:

Yea, again, laziness on my part.  :-) You could enter the tag name
in the SHA-1 expression field, but having it as a picklist may
make sense.
 
> --- git-gui.sh  2007-02-14 08:51:38.025781229 +0000
> +++ git-gui     2007-02-14 10:50:13.618870598 +0000
> @@ -1916,11 +1916,25 @@
>         return [lsort -unique $all_trackings]
>  }

Unfortunately this patch has severe whitespace damage.  All of the
tabs were received here as spaces, so nothing applies.

>  proc do_create_branch_action {w} {
>         global all_heads null_sha1 repo_config
>         global create_branch_checkout create_branch_revtype
>         global create_branch_head create_branch_trackinghead
>         global create_branch_name create_branch_revexp
> +        global create_branch_tag

The indentation does not line up here.  All of the existing context
lines were indented with just one tab, until the whitespace damage
noted above.

-- 
Shawn.
