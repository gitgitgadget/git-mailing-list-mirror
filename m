From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Workaround for strange cmp bug
Date: Wed, 9 Aug 2006 15:42:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091540040.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608091221550.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bc65gk0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608091309590.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 15:42:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAoK9-0002kz-Ut
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 15:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWHINmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 09:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWHINmO
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 09:42:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:35233 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750802AbWHINmN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 09:42:13 -0400
Received: (qmail invoked by alias); 09 Aug 2006 13:42:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 09 Aug 2006 15:42:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0608091309590.1800@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25122>

Hi,

On Wed, 9 Aug 2006, Johannes Schindelin wrote:

> On Wed, 9 Aug 2006, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > [ a whole lot about the output of cmp when calling a test with -v ]

Thinking about it again, I remember replacing 'cmp' by 'diff -u' quite a 
few times, because the output of the latter was even more helpful... And 
besides, 'diff -u' is not broken in my setup ;-)

Ciao,
Dscho
