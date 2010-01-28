From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Thu, 28 Jan 2010 02:45:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001280244430.4985@pacific.mpi-cbg.de>
References: <878wbln0oa.fsf@users.sourceforge.net> <20100128005142.GK5452@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 02:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaJLm-000893-5w
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 02:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab0A1BjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 20:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512Ab0A1BjH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 20:39:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:43620 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755279Ab0A1BjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 20:39:06 -0500
Received: (qmail invoked by alias); 28 Jan 2010 01:39:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 28 Jan 2010 02:39:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/B/oAh9zvBujch/0X3DRXvLkTKWBGSnSMGkWS7AG
	Ux5olWuqTKzh4e
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100128005142.GK5452@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138218>

Hi,

On Wed, 27 Jan 2010, Shawn O. Pearce wrote:

> Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
> > 
> > This patch enables the use of themed Tk widgets with Tk 8.5 and above.
> > These make a significant difference on Windows in making the
> > application appear native. On Windows and MacOSX ttk defaults to the
> > native look as much as possible. On X11 the user may select a theme
> > using the TkTheme XRDB resource class by adding an line to the
> > .Xresources file. The set of installed theme names is available using
> > the Tk command 'ttk::themes'. The default on X11 is similar to the current
> > un-themed style - a kind of thin bordered motif look.
> > 
> > A new git config variable 'gui.usettk' may be set to disable this if
> > the user prefers the classic Tk look. Using Tk 8.4 will also avoid the
> > use of themed widgets as these are only available since 8.5.
> > 
> > Some support is included for Tk 8.6 features (themed spinbox and native
> > font chooser for MacOSX and Windows).
> 
> Thanks.  I've been running with this pretty much all day today;
> it seems sane.  I'll probably push it shortly.

Thanks.  Can you notify me when you do so?  I will merge into 4msysgit.git 
directly then.

Ciao,
Dscho
