From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 04:36:17 -0400
Message-ID: <20070326083617.GG13247@spearce.org>
References: <20070326073502.GD44578@codelabs.ru> <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkgy-0000Li-U3
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbXCZIgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbXCZIgZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:36:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46516 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbXCZIgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:36:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVkgb-0005kn-O6; Mon, 26 Mar 2007 04:36:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E50A220FBAE; Mon, 26 Mar 2007 04:36:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43132>

Junio C Hamano <junkio@cox.net> wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > Remove unnecessary '-S' option that enabled less to chop long lines.
> > It used to provide some confusion at least for the 'git diff':
> > "Where are my long lines? Are they missed from the patch?".
> 
> It is not "unnecessary", but only "what _you_ are not used to".
> As this breaks expectentions of people already familiar with
> what git does by default, I cannot take this patch.

Hear hear.  I completely agree with Junio.  I (and a number of
other users that I work with) expect this behevaior by default.

-- 
Shawn.
