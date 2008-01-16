From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 15:34:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161531030.17650@racer.site>
References: <478E1FED.5010801@web.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1778829055-1200497659=:17650"
Cc: git@vger.kernel.org
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFAHz-000119-8J
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 16:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYAPPeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 10:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbYAPPeW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 10:34:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:32914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751283AbYAPPeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 10:34:22 -0500
Received: (qmail invoked by alias); 16 Jan 2008 15:34:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 16 Jan 2008 16:34:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+jtZZVux+siaC5DcTsLyC1D79hMME0WTw+iox7I
	iHhULcB4+J5/GH
X-X-Sender: gene099@racer.site
In-Reply-To: <478E1FED.5010801@web.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70690>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1778829055-1200497659=:17650
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 16 Jan 2008, Mark Junker wrote:

> I have some files like "Lüftung.txt" in my repository. The strange thing is
> that I can pull / add / commit / push those files without problem but
> git-status always complains that thoes files are untraced (but not missing).

This is a known problem.  Unfortunately, noone has implemented a fix, 
although if you're serious about it, I can point you to threads where it 
has been hinted how to solve the issue.

FWIW the issue is that Mac OS X decides that it knows better how to encode 
your filename than you could yourself.

Ciao,
Dscho
---1463811741-1778829055-1200497659=:17650--
