From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Workaround for strange cmp bug
Date: Thu, 10 Aug 2006 10:20:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101016590.13885@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608091221550.1800@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bc65gk0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608091309590.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1049649413-1155198036=:13885"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 10:20:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5mT-0003Hj-Qv
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 10:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWHJIUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 04:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWHJIUi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 04:20:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:43438 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751445AbWHJIUi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 04:20:38 -0400
Received: (qmail invoked by alias); 10 Aug 2006 08:20:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 10 Aug 2006 10:20:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0608091309590.1800@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25169>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1049649413-1155198036=:13885
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 9 Aug 2006, Johannes Schindelin wrote:

> On Wed, 9 Aug 2006, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > The cmp(1) (cmp (GNU diffutils) 2.8.7) distributed with openSUSE 
> > > 10.1 has a subtle "shortcoming":
> 
> Okay, I will try to fix the distribution. I only thought it was worthwhile 
> spreading the workaround for other poor souls.

Got it. The problem is that diffutils-2.8.7-15 and -18 (which seem to be 
the same...) have cherry-picked a "fix" from CVS (cmp-eof-dev-null.diff), 
which is wrong. It was fixed in diffutils CVS, and I submitted a bug 
report in openSUSEÂ's bugzilla.

So, look out for diffutils-2.8.7-15 on openSUSE (although it only breaks 
the _tests_, not git itself!).

Ciao,
Dscho

---1148973799-1049649413-1155198036=:13885--
