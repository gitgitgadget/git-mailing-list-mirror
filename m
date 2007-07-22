From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sun, 22 Jul 2007 02:12:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707220212280.14781@racer.site>
References: <7vodi7vtct.fsf@assigned-by-dhcp.cox.net>
 <200707210815.l6L8F2Da032066@mi0.bluebottle.com> <7vr6n2upwv.fsf@assigned-by-dhcp.cox.net>
 <4d8e3fd30707211157l1be243basfb259082b7aa8160@mail.gmail.com>
 <Pine.LNX.4.64.0707212224480.14781@racer.site> <7vvecdtlf1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?utf-8?B?44GX44KJ44GE?= =?utf-8?B?44GX44Gq44Gq44GT?= 
	<nanako3@bluebottle.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICQ0i-0008Ut-As
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 03:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbXGVBNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 21:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbXGVBNV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 21:13:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:37714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752365AbXGVBNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 21:13:20 -0400
Received: (qmail invoked by alias); 22 Jul 2007 01:13:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 22 Jul 2007 03:13:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+j2v4fGoijGmzvYV9HriKgQRl77WKegZfbIOkI/3
	eXZVdiEAkhYORs
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvecdtlf1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53210>

Hi,

On Sat, 21 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> paolo@paolo-desktop:~/git-gui-i18n$ ls po/
> >> de.msg  de.po  glossary.csv  ja.msg  ja.po
> >> 
> >> There is "po/git-gui.pot" file in my repository.
> >
> > My fault.  I was rebasing Junio's patch on top of Christian's new series.  
> > Alas, the PO_TEMPLATE was no longer created by default.
> >
> > Should be fixed now.
> 
> Note that if everybody agrees that the division of labor between
> the developer, the i18n coordinator and translators I suggested
> in the earlier message is the way to go, po/git-gui.pot should
> be managed by the i18n coordinator and revision tracked in-tree.
> Simple "make" should not try to update it for ordinary people,
> but we can have a "i18n coordinator only" maintenance target to
> update it.
> 
> That way, translators do not have to touch anything other than
> their own po/xx.po files.

Done.

Ciao,
Dscho
