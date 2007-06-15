From: Raimund Bauer <ray007@gmx.net>
Subject: Re: [RFC][PATCH] Fix assumption that git is installed in a
	standard place on the remote end ssh
Date: Fri, 15 Jun 2007 17:54:19 +0200
Message-ID: <1181922859.8626.7.camel@localhost>
References: <20070615150351.GH14677@menevado.ms.com>
	 <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk>
	 <20070615154000.GK14677@menevado.ms.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzE8L-0005YW-Ds
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbXFOPyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 11:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbXFOPyY
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:54:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:50606 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753920AbXFOPyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 11:54:23 -0400
Received: (qmail invoked by alias); 15 Jun 2007 15:54:21 -0000
Received: from p5498BE65.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.190.101]
  by mail.gmx.net (mp056) with SMTP; 15 Jun 2007 17:54:21 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1/h53NisAHhJ8nMXfKYEKCcaUIRoFLTj6lr2iLFGR
	gYb23CrResXLwx
In-Reply-To: <20070615154000.GK14677@menevado.ms.com>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50271>

On Fri, 2007-06-15 at 11:40 -0400, Kevin Green wrote:
> I'm thinking I like the env var idea much more though.  I can just export it
> in my shell and it works in both cases.  I could of course alias the commands
> so I don't have to keep typing it everytime, but that's more painful still...

do 'git config --help' and check the options

remote.<name>.receivepack
remote.<name>.uploadpack

> --Kevin

-- 
best regards

  Ray
