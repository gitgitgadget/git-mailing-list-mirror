From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: author/commit counts
Date: Sat, 23 Dec 2006 15:22:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612231521340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0612230001590.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Randy Dunlap <rdunlap@xenotime.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 15:22:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy7lf-0001U4-RS
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbWLWOW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbWLWOW2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:22:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:45335 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752789AbWLWOW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:22:28 -0500
Received: (qmail invoked by alias); 23 Dec 2006 14:22:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 23 Dec 2006 15:22:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0612230001590.18171@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35316>

Hi,

On Sat, 23 Dec 2006, Nicolas Pitre wrote:

> 	git log --author=<blah> | git shortlog -s

Note that the builtin shortlog reuses the fine revision walking machinery:

	git shortlog --author=<blah> -n -s

works like a charm.

Ciao,
Dscho
