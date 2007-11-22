From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk's copy pasteboard doesn't persist after it quits
Date: Thu, 22 Nov 2007 16:01:05 -0500
Message-ID: <20071122210105.GY14735@spearce.org>
References: <DFBFC631-01BF-4D2D-BCF3-3FC376479CB2@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvJDw-0000IS-Ip
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 22:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbXKVVBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 16:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXKVVBK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 16:01:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35188 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbXKVVBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 16:01:09 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IvJAQ-0000Vp-LV; Thu, 22 Nov 2007 16:00:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 808DA20FBAE; Thu, 22 Nov 2007 16:01:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <DFBFC631-01BF-4D2D-BCF3-3FC376479CB2@steelskies.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65845>

Jonathan del Strother <maillist@steelskies.com> wrote:
> On OS X, if I load gitk, copy a sha1, then quit, the sha1 isn't put  
> into the system-wide pasteboard.  It's definitely copied - I can paste  
> it back into the sha1 field - but it seems to be some sort of local  
> pasteboard that's specific to gitk
> 
> If I switch to another app, the sha1 is stored in the pasteboard  
> correctly, and I can then quit gitk and still have it available.  I'm  
> guessing that gitk (or Tcl/Tk) is syncing with the system-wide  
> pasteboard on focus change, but not on quit.

I've seen this not just on Mac OS X but also on Windows.  It seems
like Tk wipes the clipboard clean on exit, so I've just learned to
not exit a Tk application until I'm done with the clipboard...

-- 
Shawn.
