From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:10:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180005250.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>  <4A899495.8050902@gnu.org>  <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
  <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>  <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>  <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com> 
 <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de> <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAOo-0005pI-EM
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136AbZHQWJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757830AbZHQWJp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:09:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:41513 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751632AbZHQWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 18:09:44 -0400
Received: (qmail invoked by alias); 17 Aug 2009 22:09:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 18 Aug 2009 00:09:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Juy8JJz2Jp3yrkLT4K+bgYvdm9zayPCc+3ES5t1
	qLyjj5PZIqqHei
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126298>

Hi,

On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:

> On Mon, Aug 17, 2009 at 11:05 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > You are putting an undue burden on the already overloaded maintainer.
> 
> Sorry, but I'm a bit lost now. What maintainer are we talking about now? 
> Junio?

I was talking about me, as maintainer of msysGit.

> As I would be providing a turn-key CMake build system, the only burden I 
> would be putting on the maintainer would be learning CMake.
> 
> Given that I'm providing a comprehensive (100+ slides) CMake tutorial
> ( http://www.elpauer.org/stuff/learning_cmake.pdf ) , which I use in
> my CMake workshops, I think I'm making that burden a bit lighter.
> 
> If the next git conference is somewhere in Europe, I could also fly
> there and we'd have a CMake tutorial, if people would feel more
> comfortable that way.

This is exactly what I mean by burden.  Why do I have to learn a new 
system, and suffer the hassle of integrating it into the current build 
system, which works quite well thankyouverymuch?

Never run a changing system.

> > Well, let's see if you can provide a /src/cmake/release.sh that 
> > compiles CMake from scratch, and _then_ I'll look into CMake again.
> 
> Again, I'm a bit lost. What '/src/cmake/release.sh' are we talking about 
> now? Would that be part of CMake or git ?

Maybe this:

http://article.gmane.org/gmane.comp.version-control.git/126286

and this:

http://repo.or.cz/w/msysgit.git?a=blob;f=src/curl/release.sh;h=d7516cbf6e92af4de138ce405d88561fbe1e92a8;hb=968336eddac1874c56cd934d10783566af5a3e26

helps.

To quote myself (as you appear to have missed that):

	Having said that, a CMake-based system _in addition_ to what is 
	tried-and-tested to be able to support all those different kinds of 
	Microsoft Visual Studio (took me 3 attempts to write that without a 
	Freudian) would be welcome, _if_ you succeed in making it compile out
	of the box on msysGit.

	By out-of-the-box I mean: you send a patch that adds 
	/src/cmake/release.sh, I apply the patch (after briefly scanning 
	that it	does not install a backdoor on a machine that is not even
	mine, and therefore will never see even a single of my passwords
	typed in), run it, it compiles installs and commits cmake and cmake
	works.

Short form: if you make it easy for me, I will look at it again, if you 
make it hard on me, you will just have done to me what you now try 
to avoid yourself: wasted time.

Ciao,
Dscho
