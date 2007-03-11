From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/8] Switch to run_command_v_opt in revert
Date: Sat, 10 Mar 2007 20:46:40 -0500
Message-ID: <20070311014640.GB10343@spearce.org>
References: <20070310082728.GA4133@spearce.org> <Pine.LNX.4.63.0703101755090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 02:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQD96-0002sN-MX
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbXCKBqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbXCKBqp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:46:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56860 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932425AbXCKBqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:46:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQD8p-00061X-KL; Sat, 10 Mar 2007 20:46:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBF2920FBAE; Sat, 10 Mar 2007 20:46:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703101755090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41893>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 10 Mar 2007, Shawn O. Pearce wrote:
> > Another change by me is removing the va_list variants of run_command,
> > one of which is used by builtin-revert.c.  To avoid compile errors
> > I'm refactoring builtin-revert to use the char** variant instead,
> > as that variant is staying.
> 
> I did not realize that -revert and -cherry-pick would be the only users...

I didn't realize how little those functions were used either until
I started poking around in there.  I'm actually shocked that your
builtin-revert rewrite was the only one using it.  ;-)

-- 
Shawn.
