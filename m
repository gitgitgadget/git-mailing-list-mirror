From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Fri, 8 Jun 2007 23:07:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706082305490.4059@racer.site>
References: <1181338730800-git-send-email-krh@redhat.com> 
 <Pine.LNX.4.64.0706082249040.4059@racer.site> <1181340320.30683.30.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1893779252-1181340469=:4059"
Cc: git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwmfh-0001bf-CW
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968826AbXFHWLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968811AbXFHWLA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:11:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:37775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S968664AbXFHWK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:10:59 -0400
Received: (qmail invoked by alias); 08 Jun 2007 22:10:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 09 Jun 2007 00:10:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mnPcM+bmmpDfZmr4ELcYHtN89d5LZTfsU4cmGjp
	PJcUMizznX8xiR
X-X-Sender: gene099@racer.site
In-Reply-To: <1181340320.30683.30.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49511>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1893779252-1181340469=:4059
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Jun 2007, Kristian Høgsberg wrote:

> FWIW, I'm going to send an updated version of the patch that should also 
> pass the test suite.  The previous version always only creates annotated 
> tags.

As it happens, jasam also worked on a relatively extensive test script.

You might want to test it:

	http://repo.or.cz/w/git/builtin-gsoc.git

Branch is "builtin-tag", the test script is t/t7400-tag.sh.

Ciao,
Dscho


--8323584-1893779252-1181340469=:4059--
