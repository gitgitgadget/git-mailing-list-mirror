From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 19:06:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608311904520.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F6D016.4050007@users.sourceforge.net>
 <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <44F6F478.1070708@users.sourceforge.net>
 <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <44F71557.1080404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 19:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIpzZ-0004zX-Hd
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 19:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHaRGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWHaRGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 13:06:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:5532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932392AbWHaRGF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 13:06:05 -0400
Received: (qmail invoked by alias); 31 Aug 2006 17:06:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 31 Aug 2006 19:06:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jorma Karvonen <karvjorm@users.sourceforge.net>
In-Reply-To: <44F71557.1080404@users.sourceforge.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26269>

Hi,

On Thu, 31 Aug 2006, Jorma Karvonen wrote:

> I tried
> 
> make configure
> 
> and got an error message:
> 
> /bin/sh: curl-config: command not found
> make: **** No rule to make target `configure'. Stop.

Okay. I deem this a bug in our Makefile.

Could you please try "autoconf" and _then_ "./configure"?

Hth,
Dscho
