From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 08:40:26 +0100
Message-ID: <20100321074026.GD2557@m62s10.vlinux.de>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com> <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 08:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtFm2-0000Lm-3a
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 08:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981Ab0CUHkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 03:40:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:39027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750838Ab0CUHkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 03:40:31 -0400
Received: (qmail invoked by alias); 21 Mar 2010 07:40:29 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp046) with SMTP; 21 Mar 2010 08:40:29 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19TqNUX8HFTtFCB5U2ztic1RM6aXHyPpR1l3wKjyO
	P0sA3FLNU8xkc/
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 12752D4006; Sun, 21 Mar 2010 08:40:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142794>

On Sun, Mar 21, 2010 at 02:04:40AM +0530, Ramkumar Ramachandra wrote:
> Hi,
> 
> I just prepared another revision of my proposal- I've tried to be
> clearer about the objective, and included a timeline this time. Note
> that I've also changed the name from native-git-svn to git-remote-svn,
> as recommended by Sverre.
> 

...
 
> == The Technicalities ==
> I've discussed the project with Sverre Rabbelier at length over email.
> The plan is to build component-wise. The distinct components are:
> 1. An SVN client that uses libsvn to fetch/ push revisions to a remote
> SVN repository.
> 2. An exporter for SVN repositories, which will extract all the
> relevant revision history and metadata to import into Git.

Isn't that called an importer? At least if I am looking from the Git side
it imports a SVN repository.

> 3. A remote helper for Git that takes the data from this SVN exporter,
> and uses git-fast-import to create corresponding commits in Git.

Dito.

> 4. Another remote helper to export commit data and metadata from Git
> to import into SVN.
     ^^^^^^
     export

> 5. An importer for SVN, which will create revisions in SVN
        ^^^^^^^
        exporter
> corresponding to commits in Git.

I have to admit, I like your proposal. Your first points sound a little bit too
negative for my taste considering git svn serves me well on my day job, but
fair enough.

--
Peter
