From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Wed, 28 Feb 2007 00:52:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280051160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcrb3l8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702280019340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5y3b2fr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMC7k-00028c-8Z
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbXB0Xwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXB0Xwi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:52:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:44743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752643AbXB0Xwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:52:37 -0500
Received: (qmail invoked by alias); 27 Feb 2007 23:52:36 -0000
X-Provags-ID: V01U2FsdGVkX18YJ89s89sY5waaQ2Gp85cFzQ28nPZXXgKXrb4uUV
	O/ZQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk5y3b2fr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40852>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I personally am not very happy that "reflog show @{now}" gives relative 
> >> date and not the full datestamp.
> >
> > $ git log -g @{now} 
> 
> I said "reflog show" because I wanted to have oneline and abbrev.

Ah. Yes.

However, when I look at reflogs, usually I know an approximate relative 
date of the commit I am looking for. I _do_ arithmetic in my head, only 
that base-60 is a little slow...

Ciao,
Dscho
