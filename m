From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Tue, 30 May 2006 16:07:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> 
 <44720C66.6040304@gentoo.org>  <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
  <447215D4.5020403@gentoo.org>  <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
  <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org> 
 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com> 
 <447B7669.8050805@gentoo.org> <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 31 01:09:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlDL8-0004Mx-3P
	for gcvg-git@gmane.org; Wed, 31 May 2006 01:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWE3XJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 19:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWE3XJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 19:09:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbWE3XJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 19:09:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4UN7p2g029379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 May 2006 16:07:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4UN7ljh001656;
	Tue, 30 May 2006 16:07:47 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21049>



On Wed, 31 May 2006, Martin Langhoff wrote:
> 
>  gitview
>  http://git.catalyst.net.nz/gitweb?p=gentoo.git;a=summary

Heh. I think you should enable caching in your apache config. 

And maybe we should make that part of the gitweb docs. Without a caching 
web-server, gitweb is pretty slow, but it caches _beautifully_.

That gentoo repo has a lot of "duplicate" commits that cvsps will mark as 
two separate commits because there's one commit for the files, and one 
commit for whatever the "Manifest" file is. I wonder if those commits 
should generally be merged or something. 

That said, things like that are most easily fixed as a git->git update 
(along with adding name translation), which can avoid re-writing the 
trees.

			Linus
