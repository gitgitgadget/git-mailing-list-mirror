From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui wording suggestions
Date: Fri, 27 Jul 2007 00:40:09 -0400
Message-ID: <20070727044009.GF20052@spearce.org>
References: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHci-0007gl-NZ
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXG0EkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbXG0EkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:40:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50665 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbXG0EkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:40:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEHcY-0002Eg-8s; Fri, 27 Jul 2007 00:40:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2710B20FBAE; Fri, 27 Jul 2007 00:40:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53883>

Christian Stimming <stimming@tuhh.de> wrote:
> Unifiy wording to say "to stage" instead of "to add" always.
...
> With this patch I'd propose to talk every only about "stage" instead  
> of "add". IMHO that's just the logical conclusion of the above wording  
> decision. What do you think?

Yes, I agree.  This is a necessary change, the current wording is
very confusing.  I would apply this earlier than the other i18n
stuff, but this patch is written based upon the current i18n work.
:-|

> diff --git a/git-gui.sh b/git-gui.sh
> index 3536d38..fd8b4b4 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1824,12 +1824,12 @@ if {[is_enabled multicommit] || [is_enabled  
> singlecommit]} {
>   	lappend disable_on_lock \
>   		[list .mbar.commit entryconf [.mbar.commit index last] -state]
> 
> -	.mbar.commit add command -label [mc "Add To Commit"] \
> +	.mbar.commit add command -label [mc "Stage To Commit"] \
>   		-command do_add_selection
>   	lappend disable_on_lock \
>   		[list .mbar.commit entryconf [.mbar.commit index last] -state]
...

-- 
Shawn.
