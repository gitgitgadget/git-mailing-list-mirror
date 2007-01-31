From: "Mark Levedahl" <fastestspinner@hotmail.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 16:00:04 +0000
Message-ID: <BAY13-F166A2E33293EA2B17FAB3CD0A50@phx.gbl>
References: <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: git@vger.kernel.org, paulus@samba.org
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Jan 31 17:04:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHsb-0004ea-9b
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393AbXAaQAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965398AbXAaQAJ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:00:09 -0500
Received: from bay0-omc3-s41.bay0.hotmail.com ([65.54.246.241]:58186 "EHLO
	bay0-omc3-s41.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965393AbXAaQAH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jan 2007 11:00:07 -0500
Received: from hotmail.com ([64.4.31.16]) by bay0-omc3-s41.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 31 Jan 2007 08:00:07 -0800
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 31 Jan 2007 08:00:06 -0800
Received: from 12.109.151.100 by by13fd.bay13.hotmail.msn.com with HTTP;
	Wed, 31 Jan 2007 16:00:04 GMT
X-Originating-IP: [12.109.151.100]
X-Originating-Email: [fastestspinner@hotmail.com]
X-Sender: fastestspinner@hotmail.com
In-Reply-To: <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 31 Jan 2007 16:00:06.0703 (UTC) FILETIME=[E059CBF0:01C74550]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38264>

The current gitk is completely broken on Windows using the current Active 
State Tcl/Tk release as well: the display is very similar to what is shown 
on cygwin. The basic problem seems to be that Tk's geometry manager is 
buggy, on all platforms, not just cygwin. I found many variations of the 
gitk layout that broke on Linux in similar ways to the breakage on cygwin on 
my way to creating this patch (including ones that worked on Cygwin/Windows 
but not on Linux). So, arguments to the effect of "get the native Tcl/Tk" or 
"update Cygwin's Tcl/Tk, the old one is broken" just don't hold up.

Mark Levedahl


>From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>To: Mike Nefari <fastestspinner@hotmail.com>
>CC: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
>Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
>Date: Wed, 31 Jan 2007 16:17:17 +0100 (CET)
>
>Hi,
>
>On Wed, 31 Jan 2007, Mike Nefari wrote:
>
> > The gitk gui layout was completely broken on Cygwin.
>
>This was noted before. I tried to argue with Paulus (now Cc'ed, as per
>SubmittingPatches) that he should include it in gitk. Somehow this did not
>have the effect intended be me.
>
>I also verified that with my Tcl/Tk installation on MacOSX, a patch like
>this was needed. IIRC Paulus argued that I should get a native TclTk,
>which is supposed to work (though not with the paths on Cygwin, oh well).
>
>Oh, and it is also needed for MinGW. But I guess it will remain unfixed.
>

_________________________________________________________________
Turn searches into helpful donations. Make your search count. 
http://click4thecause.live.com/search/charity/default.aspx?source=hmemtagline_donation&FORM=WLMTAG
