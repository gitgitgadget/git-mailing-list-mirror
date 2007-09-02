From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-gui i18n status?
Date: Sun, 2 Sep 2007 13:29:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021322130.28586@racer.site>
References: <20070901042924.GE18160@spearce.org> <Pine.LNX.4.64.0709020003480.28586@racer.site>
 <20070902014242.GJ18160@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Stimming <stimming@tuhh.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Nanako Shiraishi <nanako3@bluebottle.com>,
	Michele Ballabio <barra_cuda@katamail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Xudong Guan <xudong.guan@gmail.com>,
	Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Irina Riesen <irina.riesen@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 14:30:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRoaa-0008HB-Mi
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 14:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966433AbXIBM3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966305AbXIBM3S
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 08:29:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:45278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966421AbXIBM3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 08:29:15 -0400
Received: (qmail invoked by alias); 02 Sep 2007 12:29:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 02 Sep 2007 14:29:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TVeNMwUiTncQxtNQUKdCbrCYo875iV7g3F0Cu+P
	lhorckXnNDvinv
X-X-Sender: gene099@racer.site
In-Reply-To: <20070902014242.GJ18160@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57320>

Hi,

On Sat, 1 Sep 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I'll also try to bug Christian into looking through the output of
> > 
> > 	git grep \" -- \*.sh \*.tcl | grep -vwe mc -e bind | less
> > 
> > to make sure that we did not forget a string.  ATM the output consists 
> > of 300+ lines, so it is a bit boring.  Maybe I can improve that 
> > command, too...

I'll have a look at them; no need to have them in the initial i18n commit, 
right?  Especially since the translations cannot contain them yet.

Ciao,
Dscho

P.S.: I seem to remember that Christian is away, so maybe we should just 
move forward.  So I'll first prepare the patch series (minus the changes 
you have in pu).
