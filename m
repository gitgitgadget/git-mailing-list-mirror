From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not verify filenames in a bare repository
Date: Sat, 20 Jan 2007 02:05:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200205011.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eoqc09$454$2@sea.gmane.org>
 <Pine.LNX.4.63.0701200149010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz4ebjoc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84gS-0006Nr-Qs
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbXATBGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbXATBGB
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:06:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:54027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965056AbXATBGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:06:00 -0500
Received: (qmail invoked by alias); 20 Jan 2007 01:05:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 20 Jan 2007 02:05:58 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4ebjoc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37237>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> This feels very sane.  Thanks.

I changed my mind. A saner check would be if the current directory starts 
with GIT_DIR, so that even (cd .git; git show HEAD) still works.

> A handful tests to make sure it catches the cases wants to catch and it 
> does not hiccup with the cases it shouldn't catch would be appropriate, 
> though.

Sure. I'll resend in a few minutes.

Ciao,
Dscho
