From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 11:12:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271109130.27959@racer.site>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1226811028-1196161965=:27959"
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyNL-0002lV-1S
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbXK0LMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbXK0LMv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:12:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:53329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752456AbXK0LMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:12:51 -0500
Received: (qmail invoked by alias); 27 Nov 2007 11:12:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 27 Nov 2007 12:12:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Awg1fBBgAQsBl8JtjIeS0Xm4eHEBQ96cO5vyBFr
	jQt9aNXwB+Vr+6
X-X-Sender: gene099@racer.site
In-Reply-To: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66185>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1226811028-1196161965=:27959
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 Nov 2007, しらいしななこ wrote:

> Quoting Andreas Ericsson <ae@op5.se>:
> 
> > "git pull --rebase" already has an implementation. Dscho cooked one up
> > which I've been using since then. It works nicely.
> 
> What is the reason that the option was not added to the official git?  
> Was it coded poorly, buggy or were there some other issues?

It is very well possible that it was coded poorly ;-)

The main reason, I believe, was that some old-timers who know the 
implications said that it would encourage a wrong workflow.  One thing 
that could go possibly wrong, for example, is to rebase commits that you 
already published.

So AFAICT it was deemed not only giving people rope, but making that rope 
look like a necklace to them.

Ciao,
Dscho

---1463811741-1226811028-1196161965=:27959--
