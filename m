From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Compiling Git in Mac OS X Leopard
Date: Thu, 7 Feb 2008 02:23:59 -0500
Message-ID: <20080207072359.GR24004@spearce.org>
References: <E9380AA8-2E38-4733-9940-FFD51BB84700@maisniemi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sami Maisniemi <sami@maisniemi.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN183-0006LM-22
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 08:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbYBGHYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 02:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbYBGHYE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 02:24:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58660 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbYBGHYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 02:24:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JN172-0005Gl-FN; Thu, 07 Feb 2008 02:24:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 91AA120FBAE; Thu,  7 Feb 2008 02:23:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <E9380AA8-2E38-4733-9940-FFD51BB84700@maisniemi.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72903>

Sami Maisniemi <sami@maisniemi.net> wrote:
> I tried to compile Git in Mac OS X Leopard, because I was unable to  
> find any precompiled binaries. However, the compilation was aborted  
> due to the following error:
> 
> msgfmt --statistics --tcl po/de.po -l de -d po/
> make[1]: msgfmt: Command not found
> make[1]: *** [po/de.msg] Error 127
> make: *** [all] Error 2
> 
> It seems that the makefile uses an application called msgfmt that is  
> not available in Mac OS X Leopard. What is application msgfmt and why  
> it is required? Is there any kind of workaround available?

Use:

	make NO_MSGFMT=1

to use the msgfmt work-somewhat-alike that ships with git, for this
exact purpose.  Newer versions than what you are trying to build
should be automatically detecting if msgfmt isn't available and
falling back to that work-somewhat-alike version.   gitgui-0.9.2,
which ships with git 1.5.4, does have that fallback.

-- 
Shawn.
