From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 13:39:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291338370.13507@racer.site.net>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com>
 <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com> <483E4E3C.90805@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 29 14:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1hRb-0004RS-9H
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 14:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYE2Mkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbYE2Mkb
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 08:40:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:56600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751710AbYE2Mka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 08:40:30 -0400
Received: (qmail invoked by alias); 29 May 2008 12:40:29 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 29 May 2008 14:40:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+00UNOABO0bamEEV16Wjro2Mgl0c3+6dRh6PKmNr
	aG4ac7PK+WO4PT
X-X-Sender: gene099@racer.site.net
In-Reply-To: <483E4E3C.90805@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83191>

Hi,

On Thu, 29 May 2008, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > This is not meant for application to the mainline.  It allows your git 
> > to refuse to create a blob whose name is "nul".
> 
> It's not just about "nul"; these won't work either: "aux", "prn", "con", 
> "com\d+", "lpt\d+", neither do "$one_of_these.$some_extension". And all 
> of that regardless of the case!
> 
> See http://msdn.microsoft.com/en-us/library/aa365247(VS.85).aspx
> 
> Definitely, we don't ever want to have such special-casing somewhere in 
> git.

I think that the standard methods, namely checking by hook, should be good 
enough.

Ciao,
Dscho
