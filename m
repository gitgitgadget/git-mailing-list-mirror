From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] utf8.c: speculatively assume utf-8 in
 strbuf_add_wrapped_text()
Date: Sat, 20 Feb 2010 10:14:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002201012300.20986@pacific.mpi-cbg.de>
References: <4B7F0D08.6040608@lsrfire.ath.cx> <4B7F0EBC.4060209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-607678211-1266657297=:20986"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 20 10:08:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NilK2-0007Fw-17
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 10:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0BTJIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 04:08:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:41547 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754471Ab0BTJIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 04:08:14 -0500
Received: (qmail invoked by alias); 20 Feb 2010 09:08:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 20 Feb 2010 10:08:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WzFQD1jCWkNX5dZcCP0IM0j3iv+TTCD6mDOb0c/
	PVcUXl5vNvDaeB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B7F0EBC.4060209@lsrfire.ath.cx>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140521>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-607678211-1266657297=:20986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 19 Feb 2010, René Scharfe wrote:

> Missing: numbers for a non-utf-8 repo.

Since the wrapping code only makes sense for UTF-8, I consider it a pilot 
error to try to rewrap non-UTF-8 messages. So I think you are safe.

All of the patches look good to me,
Dscho

--8323328-607678211-1266657297=:20986--
