From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 18:56:03 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003211837300.14365@iabervon.org>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>  <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>  <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>  <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
  <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>  <alpine.LNX.2.00.1003201724270.14365@iabervon.org> <f3271551003202236j2698a65bi3c7e29ee8a3cd1e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 23:56:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtU47-0005Np-7A
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 23:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab0CUW4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 18:56:06 -0400
Received: from iabervon.org ([66.92.72.58]:57747 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab0CUW4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 18:56:05 -0400
Received: (qmail 9378 invoked by uid 1000); 21 Mar 2010 22:56:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2010 22:56:03 -0000
In-Reply-To: <f3271551003202236j2698a65bi3c7e29ee8a3cd1e1@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142869>

On Sun, 21 Mar 2010, Ramkumar Ramachandra wrote:

> Hi,
> 
> > The structure for remote helpers should be that each foreign system has a
> > single helper which git can call with instructions on what to do (both for
> > foreign-to-git and for git-to-foreign operations). So 3 and 4 have to be
> > functions of the same program, and it's probably best for 2 and 5 and
> > maybe 1 to also be part of this program.
> 
> I've attached a small image specifying the relationship between
> various components. I plan to include a more elaborate version of this
> in my final proposal. Is this what you had in mind?

Mostly, except that I think it should be possible to avoid having 
git-remote-svn actually link to the git core, because the git core should 
be taking care of everything git-specific for you. Of course, the git core 
also provides a bunch of useful C library code that you may want to use, 
such as a nice string buffer implementation, so you may want to link to 
git even if you don't actually need it, if licenses are suitable and it 
would be convenient.

	-Daniel
*This .sig left intentionally blank*
