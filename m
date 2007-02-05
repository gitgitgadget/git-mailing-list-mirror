From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/8] bash: Remove short option completions for branch/checkout/diff.
Date: Mon, 5 Feb 2007 04:19:28 -0500
Message-ID: <20070205091928.GA14234@spearce.org>
References: <20070204073817.GA17603@spearce.org> <7vr6t6rycz.fsf@assigned-by-dhcp.cox.net> <20070205024704.GB12917@spearce.org> <200702051016.16785.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 10:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE00f-0004Ru-UM
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 10:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXBEJTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 04:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbXBEJTf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 04:19:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39426 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbXBEJTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 04:19:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HE00Y-0008MP-3I; Mon, 05 Feb 2007 04:19:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 65F4820FBAE; Mon,  5 Feb 2007 04:19:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702051016.16785.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38736>

Jakub Narebski <jnareb@gmail.com> wrote:
> It would be nice to have long option for each git command single 
> character (short) option, for example --patch as long option to 
> git-diff-tree -p option, etc.

Sure.  And I'd support them when possible in the bash completion.

But I think that sort of change to git should wait for a real
command line option parser.  What we have now makes things a
tad painful.

-- 
Shawn.
