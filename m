From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 21:52:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082151570.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802081905580.11591@racer.site> <foihu9$110$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1000686062-1202507535=:11591"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNb9l-0007EK-O9
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYBHVwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYBHVwK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:52:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:50469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752105AbYBHVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 16:52:08 -0500
Received: (qmail invoked by alias); 08 Feb 2008 21:52:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp020) with SMTP; 08 Feb 2008 22:52:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oSsAEHe8oUp+5uczzehJ0nwxvj4voAh6EuJvSqR
	ii9HcpfVDt6Y80
X-X-Sender: gene099@racer.site
In-Reply-To: <foihu9$110$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73157>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1000686062-1202507535=:11591
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

[I'll just Cc you, out of the goodness of my heart.]

On Fri, 8 Feb 2008, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Fri, 8 Feb 2008, Jan Holesovsky wrote:
> 
> >> +     struct stat st;
> >> +     const char remote_alt_file_name[] = "info/remote_alternates";
> > 
> > <bikeshedding>maybe remote-alternates (note the dash instead 
> > of the underscore)</bikeshedding>
> 
> Why not in info/alternates?

Again, to make the distinction clear.

Also note that info/alternates is used by the http transport (which would 
then break semi-silently, because I expect that you usually put git:// 
urls into remote-alternates).

Ciao,
Dscho

---1463811741-1000686062-1202507535=:11591--
