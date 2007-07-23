From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] describe: add option --dirty
Date: Mon, 23 Jul 2007 03:58:34 -0400
Message-ID: <20070723075834.GK32566@spearce.org>
References: <87odi3mxtl.wl@mail2.atmark-techno.com> <7vsl7fmwud.fsf@assigned-by-dhcp.cox.net> <20070723070818.GI32566@spearce.org> <87lkd7mu71.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICsoZ-0002WZ-QP
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbXGWH6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079AbXGWH6l
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:58:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45626 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbXGWH6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:58:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICsoM-0006Pp-Oy; Mon, 23 Jul 2007 03:58:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9863720FBAE; Mon, 23 Jul 2007 03:58:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87lkd7mu71.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53409>

Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> From the comments I'd add an option "--workinig-tree" instead of
> --dirty to describe the working tree.  because that, the special case,
> is what we want after all,
> 
> synopsis would be:
> 
> 	SYNOPSIS
> 	--------
> 	'git-describe' [--all] [--tags] [--contains] [--abbrev=<n>]
> 	               [--candidates=<n>] [--debug]
> 	               --working-tree | <committish>...
> 	    :
> 	    :
> 	--working-tree::
> 		Describe the working tree instead of committishes.  if the
> 		working tree is dirty, the describe string will have "-dirty"
> 		appended.
> 	
> 		As you can assume from the name, this option requires working
> 		tree; running it on a bare repository will fail.
> 
> what do you think?

That's reasonable.  It seems like a lot of work in core Git just
to avoid a small chunk of shell, but I think almost everyone has
that same small chunk of shell in their build scripts...

-- 
Shawn.
