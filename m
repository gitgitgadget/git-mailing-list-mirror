From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC][PATCH] Fix assumption that git is installed in a standard
 place on the remote end ssh
Date: Tue, 19 Jun 2007 01:16:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706190114110.4059@racer.site>
References: <20070615150351.GH14677@menevado.ms.com>
 <Pine.LNX.4.64.0706151628180.31972@reaper.quantumfyre.co.uk>
 <20070615154000.GK14677@menevado.ms.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Kevin Green <Kevin.T.Green@morganstanley.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 02:16:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0ROx-0003HT-4y
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 02:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762258AbXFSAQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 20:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762138AbXFSAQx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 20:16:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:36292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761980AbXFSAQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 20:16:53 -0400
Received: (qmail invoked by alias); 19 Jun 2007 00:16:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 19 Jun 2007 02:16:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185DewILo05TVQNeRIz0nICAlicuVFvAN23Xrx3b9
	bFX58pRu12434k
X-X-Sender: gene099@racer.site
In-Reply-To: <20070615154000.GK14677@menevado.ms.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50428>

Hi,

On Fri, 15 Jun 2007, Kevin Green wrote:

> I'm thinking I like the env var idea much more though.  I can just 
> export it in my shell and it works in both cases.

And it completely breaks down when you have more than one remotes. Or when 
you cd to another project with another remote. Or etc. IOW it is fragile.

Clearly, the config approach is the only one which makes sense. This 
information is so closely coupled to a specific remote that you should 
store it right where you store all the other remote information, too.

Ciao,
Dscho
