From: Marc Weber <marco-oweber@gmx.de>
Subject: git-svn is there a way to track non standard layouts?
Date: Mon, 19 May 2008 23:03:43 +0200
Message-ID: <20080519210343.GA27761@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 23:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyCXC-0001Bu-GY
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbYESVDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbYESVDt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 17:03:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:33938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751896AbYESVDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 17:03:48 -0400
Received: (qmail invoked by alias); 19 May 2008 21:03:45 -0000
Received: from pD9E08D42.dip.t-dialin.net (EHLO nixos) [217.224.141.66]
  by mail.gmx.net (mp012) with SMTP; 19 May 2008 23:03:45 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/0TQs9hG30sdIufJw/pTU4Jvg8ZuUybvATZ4eTB0
	uh/PmUP2RGM5u/
Received: by nixos (sSMTP sendmail emulation); Mon, 19 May 2008 23:03:43 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82450>

I've got a directory layout looking like this:
A/{trunk,server}
B/{trunk,server}
C/{trunk,server}

Where A,B,C are small variations of the same project (adjusted to
different customers).

Can I tell git-svn to track those 6 directories or do I have to change
the svn layout to

A/{trunk,branches/server}
B/{trunk,branches/server}
C/{trunk,branches/server}

and use git-svn clone 3 times?

Sincerly Marc Weber
