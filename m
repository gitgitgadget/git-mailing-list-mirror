From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 17:37:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701231506.32396.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231624.41716.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 17:37:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9OeE-0002k8-9a
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 17:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbXAWQhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 11:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbXAWQhX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 11:37:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:51884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932898AbXAWQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 11:37:22 -0500
Received: (qmail invoked by alias); 23 Jan 2007 16:37:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 23 Jan 2007 17:37:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701231624.41716.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37548>

Hi,

On Tue, 23 Jan 2007, Andy Parkins wrote:

> On Tuesday 2007 January 23 15:20, Johannes Schindelin wrote:
> 
> > MinGW and cygwin differ in one very important point: cygwin needs an extra
> > dll, MinGW does not.
> >
> > However, the development environment is still console-based, with a bash
> > so you can run configure and simple bash scripts. It is definitely more
> > catering to Unix types than Windows types.
> >
> > So yes, there is a bash, and there is a less, and there is perl.
> 
> Those are just tools for MinGW though aren't they?  They aren't needed to run 
> the final executable object?  MinGW just spits out a native windows .exe - 
> i.e. plain windows.

Yes. But it _does_ have a dependency on perl and bash. For example, when 
you merge git-merge-one-file is spawned -- a bash script.

> There is no reason to suppose that joe-random-developer will have bash, 
> less and perl, even if they do have git.  Which was kind of the point I 
> was making - there is no pager to rely on in Windows, so why not just 
> drop it.  Okay, so MinGW comes with some nice UNIXy tools, but MinGW is 
> the compiler, not the environment.

You reminded me that I was not precise enough: MSYS provides the UNIXy 
tools, and the compiler, MinGW is just the headers and import libraries.

And while we already depend on bash and friends -- which we put into 
GIT_EXEC_PATH -- we can ship more: "less".

> Am I still misunderstanding?  I'm looking out for the time when
> 
> C:\SomePath> git commit -a
> 
> will work (I know - it's a long way off yet).

You need an editor, that is for sure, but it is not _that_ far off. Thanks 
to Johannes Sixt, committing works already (if you don't encounter the 
same problem starting vi as I do).

Ciao,
Dscho
