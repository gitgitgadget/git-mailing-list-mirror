From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Fri, 22 Dec 2006 23:34:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061222221913.GA3071@cepheus>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1043184935-1166826885=:19693"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:34:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsyY-0002RS-N2
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbWLVWer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbWLVWer
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:34:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:37800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752686AbWLVWeq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:34:46 -0500
Received: (qmail invoked by alias); 22 Dec 2006 22:34:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 22 Dec 2006 23:34:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061222221913.GA3071@cepheus>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35239>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1043184935-1166826885=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Dear Mr Zeisberg,

On Fri, 22 Dec 2006, Uwe Kleine-König wrote:

> Johannes Schindelin wrote:
> > Note that we do not go the full nine yards: we could also check that
> > the character is encoded with the minimum amount of bytes, as pointed
> > out by Uwe Kleine-Koenig.
> While we're talking about UTF-8 in commit-logs:  I'd prefer to have my
> name properly written with o-umlaut.

I did this because I have no easy way to input UTF-8, and because I am 
lazy, and because I did not know how many times this patch has to be 
revised.

Apart from that, it seems that the checking of UTF-8 is actually quite 
simple, and we could even copy it from 
http://www.cl.cam.ac.uk/~mgk25/ucs/utf8_check.c, where the check you 
proposed is included.

But I had enough of UTF-8 for a day.

Ciao,
Dscho

---1148973799-1043184935-1166826885=:19693--
