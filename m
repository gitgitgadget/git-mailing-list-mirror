From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH next] git-notes: fix printing of multi-line notes
Date: Tue, 13 Jan 2009 23:40:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901132339270.3586@pacific.mpi-cbg.de>
References: <496CF21C.2050500@trolltech.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1966567884-1231886415=:3586"
Cc: git@vger.kernel.org, junio@pobox.com
To: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrwJ-0004rB-8J
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbZAMWj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbZAMWj0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:39:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:45594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753721AbZAMWjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:39:25 -0500
Received: (qmail invoked by alias); 13 Jan 2009 22:39:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 13 Jan 2009 23:39:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JxNQK9gYJ9D4OeVCyFLR7RceIQHhPt2tYck6vsL
	nXAxFPH5pyhEYC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496CF21C.2050500@trolltech.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105554>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1966567884-1231886415=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 13 Jan 2009, Tor Arne Vestbø wrote:

> The line length was read from the same position every time,
> causing mangled output when printing notes with multiple lines.
> 
> Also, adding new-line manually for each line ensures that we
> get a new-line between commits, matching git-log for commits
> without notes.
> 
> Signed-off-by: Tor Arne Vestbø <tavestbo@trolltech.com>
> ---

Patch looks good, so 

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

For extra browny points, you could add a test with multi-line notes.

Ciao,
Dscho
--8323328-1966567884-1231886415=:3586--
