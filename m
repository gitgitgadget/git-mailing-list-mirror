From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: [PATCH] Support incremental pack files
Date: Fri, 23 Feb 2007 11:32:55 -0500
Message-ID: <20070223163255.GA26731@spearce.org>
References: <20070223071344.GA21107@auto.tuwien.ac.at> <alpine.LRH.0.82.0702231040510.27932@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 23 17:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKdME-0008Ln-GT
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 17:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123AbXBWQdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 11:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933137AbXBWQdP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 11:33:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50984 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933123AbXBWQdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 11:33:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HKdLq-0000Md-4y; Fri, 23 Feb 2007 11:32:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 63FE720FBAE; Fri, 23 Feb 2007 11:32:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.82.0702231040510.27932@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40448>

Nicolas Pitre <nico@cam.org> wrote:
> One thing that is too expensive in GIT is rev-list --objects --all (or 
> equivalent) used to list objects to pack.  But Shawn and I have a plan 
> to fix that at some point... (if only I can find some spare time to 
> write more code for it).

Ditto.  ;-)

I have been pretty swamped this week, but plan on working on packv4
prototype code today and this weekend.  (BTW, I did get the string
code, its useful, thanks!)

-- 
Shawn.
