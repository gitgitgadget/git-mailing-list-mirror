From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 10:07:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060225174047.0e9a6d29.akpm@osdl.org>  <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
  <20060225210712.29b30f59.akpm@osdl.org>  <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
  <20060226103604.2d97696c.akpm@osdl.org>  <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
  <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 10:08:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDeLw-0001Id-80
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 10:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWB0JHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 04:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWB0JHO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 04:07:14 -0500
Received: from mail.gmx.de ([213.165.64.20]:53170 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932329AbWB0JHM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 04:07:12 -0500
Received: (qmail invoked by alias); 27 Feb 2006 09:07:10 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp010) with SMTP; 27 Feb 2006 10:07:10 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: MIke Galbraith <efault@gmx.de>
In-Reply-To: <1141008633.7593.13.camel@homer>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16831>

Hi,

there is a good reason not to enable the no-whitespace-at-eol checking in 
pre-commit by default (at least for *all* files) for git development:

	Python.

Just do a "/ $" in git-merge-recursive.py. These whitespaces are not an 
error, but a syntactic *requirement*.

Hth,
Dscho
