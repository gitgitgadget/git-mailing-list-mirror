From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 16:33:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221629080.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> 
 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> 
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> 
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> 
 <44720C66.6040304@gentoo.org>  <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
  <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>  <20060522214128.GE16677@kiste.smurf.noris.de>
  <Pine.LNX.4.64.0605221516500.3697@g5.osdl.org>
 <46a038f90605221623g25325e71hf3faf0a6a6ca628a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 23 01:34:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJut-0004zB-J0
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWEVXeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEVXeV
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:34:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbWEVXeV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:34:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MNXBtH005336
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 16:33:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MNX624018211;
	Mon, 22 May 2006 16:33:08 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605221623g25325e71hf3faf0a6a6ca628a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20554>



On Tue, 23 May 2006, Martin Langhoff wrote:
> 
> I really don't think that using the local cvs binary is a problem at
> all. In my experience, the thing is fairly fast and optimized when you
> ask it to perform file-oriented questions and that's all we do,
> really.

Fair enough. My worry was mainly that the cvs server was doing something 
stupid, but I suspect most of the fork/exec's are probably from the 
cvsimport perl script itself.

> In any case, we have it already -- parsecvs does it quite well (modulo
> memory leaks!) and I've used it several times in conjunction with
> cvsimport. Just perform the initial import with parsecvs and then
> 'track' the remote project with cvsimport.

I didn't get parsecvs working when I tried it a long time ago, and Donnie 
reported that it ran out of memory, so I didn't even really consider it. 
I'd love for it to work well, and it may be reasonable to do really big 
imports on multi-gigabyte 64-bit machines (after all, they aren't _hard_ 
to find any more, and you only need to do it once).

That said, it still seems pretty stupid to require that much memory just 
to import from CVS.

		Linus
