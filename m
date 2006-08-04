From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix crash when GIT_DIR is invalid
Date: Sat, 5 Aug 2006 00:42:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608050041230.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608041745500.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virl8jpnw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 00:42:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G98NF-0007FV-Dx
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161542AbWHDWma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161544AbWHDWma
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:42:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:1250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161542AbWHDWm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 18:42:29 -0400
Received: (qmail invoked by alias); 04 Aug 2006 22:42:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 05 Aug 2006 00:42:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virl8jpnw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24855>

Hi,

On Fri, 4 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >  	bad_dir_environ:
> > -		if (!nongit_ok) {
> > +		if (nongit_ok) {
> >  			*nongit_ok = 1;
> 
> *BLUSH*  How could I have missed something like this...

It's too easy. I actually reviewed that patch, saw that I did the same 
(not!), and hit the bug...

Ciao,
Dscho "errare humanum est" --
