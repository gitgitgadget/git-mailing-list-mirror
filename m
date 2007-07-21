From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 22:25:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707212224480.14781@racer.site>
References: <7vodi7vtct.fsf@assigned-by-dhcp.cox.net> 
 <200707210815.l6L8F2Da032066@mi0.bluebottle.com>  <7vr6n2upwv.fsf@assigned-by-dhcp.cox.net>
 <4d8e3fd30707211157l1be243basfb259082b7aa8160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-2022-JP?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 23:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICMSN-0000cR-N2
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 23:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761419AbXGUVZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 17:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761128AbXGUVZk
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 17:25:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:52017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760669AbXGUVZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 17:25:40 -0400
Received: (qmail invoked by alias); 21 Jul 2007 21:25:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 21 Jul 2007 23:25:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ksIJrWYHkZCExK1W7neCUMW845ViJNVwNfFRfiz
	5O0P5yoXR7+4Tn
X-X-Sender: gene099@racer.site
In-Reply-To: <4d8e3fd30707211157l1be243basfb259082b7aa8160@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53188>

Hi,

On Sat, 21 Jul 2007, Paolo Ciarrocchi wrote:

> On 7/21/07, Junio C Hamano <gitster@pobox.com> wrote:
> 
> paolo@paolo-desktop:~/git-gui-i18n$ ls
> git-gui.sh  GIT-VERSION-GEN  lib  Makefile  po
> 
> 
> >  - Run 'make' once, to get po/git-gui.pot generated;
> 
> paolo@paolo-desktop:~/git-gui-i18n$ make
> GITGUI_VERSION = 0.8.GITGUI
>    * new locations or Tcl/Tk interpreter
>    GEN git-gui
>    BUILTIN git-citool
>    INDEX lib/
> 
> paolo@paolo-desktop:~/git-gui-i18n$ ls po/
> de.msg  de.po  glossary.csv  ja.msg  ja.po
> 
> There is "po/git-gui.pot" file in my repository.

My fault.  I was rebasing Junio's patch on top of Christian's new series.  
Alas, the PO_TEMPLATE was no longer created by default.

Should be fixed now.

Thanks,
Dscho
