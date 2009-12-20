From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Sun, 20 Dec 2009 14:16:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912201412420.4985@pacific.mpi-cbg.de>
References: <87my1ev4gi.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Dec 20 14:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMLa8-0004dd-3s
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 14:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbZLTNMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 08:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbZLTNMO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 08:12:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:59568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754827AbZLTNMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 08:12:12 -0500
Received: (qmail invoked by alias); 20 Dec 2009 13:12:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 20 Dec 2009 14:12:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bTK4OXMWbHGBotTFOgEAYpRb5IusXr3I24mhail
	NOiX+Q7lw2sUjP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87my1ev4gi.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135529>

Hi,

On Sun, 20 Dec 2009, Pat Thoyts wrote:

>  This patch enables the use of themed Tk widgets with Tk 8.5 and above.
>  These make a significant difference on Windows in making the application
>  appear native. The gui.usettk git config variable may be set to disable
>  this if the user prefers the classic Tk look.
>
>  On Windows and MacOSX ttk defaults to the native look as much as possible.
>  On X11 the user may select a theme using the TkTheme XRDB resource class.

Maybe you could describe a quick way to set that resource?

>  Some support is included for Tk 8.6 features (themed spinbox and native
>  font chooser for MacOSX and Windows).
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> 
> There is a screenshot of this running on Windows 7 at
> http://www.patthoyts.tk/screenshots/git-gui-win32.png
> It has been tested on Linux but not on MacOSX yet.

Please put this paragraph after the "---". Oh, and could you also include 
a screenshot without ttk?

As to the patch: it is huge.  I suspect that it would be easier to read 
and verify if it was done in two patches: the first one introducing helper 
procs that replace the existing repeated code, and a second patch that 
modifies only the helper procs to handle ttk if desired.  You did that 
with pad_label, but that proc is not defined in a central place, but 
limited to about.tcl.

Hmm?

Thanks,
Dscho
