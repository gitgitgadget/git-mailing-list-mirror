From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add commit.editor configuration variable
Date: Thu, 19 Jul 2007 02:23:02 -0400
Message-ID: <20070719062302.GG32566@spearce.org>
References: <11848235881723-git-send-email-aroben@apple.com> <7v7iox3oz8.fsf@assigned-by-dhcp.cox.net> <47EE39C7-0D57-48EC-B5A0-C10E49997E32@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 08:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPPt-0007zK-7v
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbXGSGXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXGSGXJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:23:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39811 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbXGSGXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:23:08 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBPPk-0005y2-Av; Thu, 19 Jul 2007 02:23:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D425420FBAE; Thu, 19 Jul 2007 02:23:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47EE39C7-0D57-48EC-B5A0-C10E49997E32@apple.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52943>

Adam Roben <aroben@apple.com> wrote:
> On Jul 18, 2007, at 11:08 PM, Junio C Hamano wrote:
> 
> >I do not think commit.editor is a good name.  Wouldn't we want
> >that customized editor for "git tag -a" as well?  Probably
> >core.editor would come nicely next to core.pager we already
> >have.
> 
>    I considered core.editor, but if it's an editor that is *only*  
> used for commit messages then that seems to be a too-general name, and  
> something like core.commit_message_editor seemed far too long. Any  
> suggestions?
> 
>    I had forgotten about "git tag -a" -- I will add support for that  
> as well.

We only launch an editor for three reasons: commit messages, tag
messages and git-rebase -i.  If we were to ever add a new editor
using thingy, odds are the user would want the same editor by
default for that too.

So please, core.editor, and also use it in git-rebase--interactive.

-- 
Shawn.
