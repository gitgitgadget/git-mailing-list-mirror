From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Initial Chinese translation
Date: Sun, 22 Jul 2007 12:39:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221233330.14781@racer.site>
References: <11850629362012-git-send-email-xudong.guan@gmail.com>
 <7vhcnxtgvw.fsf@assigned-by-dhcp.cox.net> <20070722073519.GV32566@spearce.org>
 <7vhcnwsvzd.fsf@assigned-by-dhcp.cox.net> <20070722085338.GA18268@xguan-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Xudong Guan <xudong.guan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 13:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICZmw-0005lO-7v
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 13:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbXGVLji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 07:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764962AbXGVLji
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 07:39:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:40251 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764714AbXGVLj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 07:39:28 -0400
Received: (qmail invoked by alias); 22 Jul 2007 11:39:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 22 Jul 2007 13:39:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SXtxaJY0Srg+xrMD9VqeXwy09KMphULedq8RuaE
	GIzEZwoaZuXCMX
X-X-Sender: gene099@racer.site
In-Reply-To: <20070722085338.GA18268@xguan-laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53249>

Hi,

On Sun, 22 Jul 2007, Xudong Guan wrote:

> On 01:06 Sun 22 Jul     , Junio C Hamano wrote:
> > Yeah, I was hinting to rename this file to zh_CN.po from day
> > one.
> 
> I agree.
> 
> I am new to the patch-in-email way of doing things. If I could do
> better, please give me hints. Can I push directly to mob? Like:
> $ git clone http://repo.or.cz/r/git-gui/git-gui-i18n
> hack hack hack ....
> $ git push http://repo.or.cz/r/git-gui/git-gui-i18n master:mob

Almost:

$ git push mob@repo.or.cz:/srv/git/git-gui/git-gui-i18n.git master:mob

If it says that you might want to pull first, please consider pulling from 
mob with

$ git pull http://repo.or.cz/r/git-gui/git-gui-i18n.git/ mob

or rebasing with

$ git fetch http://repo.or.cz/r/git-gui/git-gui-i18n.git/ mob
$ git rebase FETCH_HEAD

> >From 936787ddbdeaf0bcecbb1359179dae90c20418b0 Mon Sep 17 00:00:00 2001
> From: Xudong Guan <xudong.guan@gmail.com>
> Date: Sun, 22 Jul 2007 09:41:12 +0100
> Subject: [PATCH] git-gui: renamed po/zh.po -> po/zh_CN.po

Thanks.  Applied.

Before applying, I usually compile test, and it seems like just one 
translation is missing: Apply/Revert Hunk.  Could you please add that, 
too?  Thank you.

> ---
>  po/zh.po    |  250 -----------------------------------------------------------
>  po/zh_CN.po |  250 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Just a tip for the next time: the git diff family -- including 
format-patch -- knows about renames, when you call it with "-M".  The 
patch will be much shorter then, saying that there was a rename.  It is 
not turned on by default, since only Git knows about this extension for 
the time being.  But that's what we're using, so no problem there.

Ciao,
Dscho
