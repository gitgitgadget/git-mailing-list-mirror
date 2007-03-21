From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 16:35:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703211630160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
 <20070321051406.GW96806@codelabs.ru> <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070321115004.GB14837@codelabs.ru> <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070321144008.GE14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 21 16:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU2qD-0000MZ-IH
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 16:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXCUPfH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 11:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbXCUPfG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 11:35:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:56396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932368AbXCUPfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 11:35:05 -0400
Received: (qmail invoked by alias); 21 Mar 2007 15:35:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 21 Mar 2007 16:35:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3YsJU8tG3/gRSGCGMVg9cLOUYaar/e+p+a18jEJ
	vxb7dKY6wLwq9X
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070321144008.GE14837@codelabs.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42797>

Hi,

I will make my point very clear now:

People like you compile the source not so much to develop _in_ Git, but 
_with_ Git. So, you are likely to "./configure && make install".

For something like "./configure && make install", it makes tons of sense 
to check which dependencies are there, and which are not. Then, depending 
if it is possible to compile (or install) only parts of Git, because some 
dependencies are not met, ./configure can figure out what flags to set.

Now, if you have no X11 installed (and consequently no Tk), it is very 
easy for ./configure to find out what to do.

However, if you state that you want to have no gui (and you state it as 
such), you are not caring if X11 is installed or not! And ./configure 
cannot figure out what you want, based on what it finds, since it cannot 
read your mind. At least that is what I expect.

Now, enough talk, if my point is still not clear enough, I'll just let it 
be.

Ciao,
Dscho
