From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui-i18n: Fix translation of the context menu
Date: Mon, 23 Jul 2007 10:58:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231057550.14781@racer.site>
References: <Pine.LNX.4.64.0707221719430.14781@racer.site>
 <20070723035122.GB32566@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 11:58:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICugc-0000Ar-2C
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 11:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758802AbXGWJ6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 05:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758796AbXGWJ6h
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 05:58:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:52373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758650AbXGWJ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 05:58:36 -0400
Received: (qmail invoked by alias); 23 Jul 2007 09:58:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 23 Jul 2007 11:58:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aecYfsQXa1WUN51nqgCdaO1IpK7k9k6Qq0G4dB1
	BdCFWcrg4CsVBy
X-X-Sender: gene099@racer.site
In-Reply-To: <20070723035122.GB32566@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53419>

Hi,

On Sun, 22 Jul 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > diff --git a/git-gui.sh b/git-gui.sh
> > index 075a2b9..52170ee 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -2457,9 +2457,9 @@ bind_button3 $ui_diff "
> >  	set cursorX %x
> >  	set cursorY %y
> >  	if {\$ui_index eq \$current_diff_side} {
> > -		$ctxm entryconf $ui_diff_applyhunk -label [mc {Unstage Hunk From Commit}]
> > +		$ctxm entryconf $ui_diff_applyhunk -label \"[mc "Unstage Hunk From Commit"]\"
> 
> That's the wrong change to do here, as you are going to eval
> the result of the translation.  If the translation had a Tcl
> special character (\, $, [) in it then we'd actually execute that.
> Instead the [ should be escaped:
> 
> > +		$ctxm entryconf $ui_diff_applyhunk -label \[mc "Unstage Hunk From Commit"\]
> 
> But you aren't a Tcl programmer, so its OK.  ;-)

Heh.

Thanks,
Dscho
