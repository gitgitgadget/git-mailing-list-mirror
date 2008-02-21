From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bisect: "won't bisect on seeked tree"
Date: Thu, 21 Feb 2008 00:33:07 -0500
Message-ID: <20080221053307.GA2887@spearce.org>
References: <1203571214.24456.6.camel@homer.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:33:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS448-0006HC-W5
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbYBUFdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYBUFdL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:33:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32849 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYBUFdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:33:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JS43R-0006bQ-EX; Thu, 21 Feb 2008 00:33:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7EE7A20FBAE; Thu, 21 Feb 2008 00:33:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1203571214.24456.6.camel@homer.simson.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74598>

Mike Galbraith <efault@gmx.de> wrote:
> I have no idea how tree became "seeked", but would love to know how to
> "un-seek" it so I can proceed with a bisection.  Help?

I think you are already in the middle of a bisect.

Try "git bisect reset" first to get out of the current bisect before
starting another one.

-- 
Shawn.
