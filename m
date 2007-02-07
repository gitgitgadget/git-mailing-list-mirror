From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Wed, 7 Feb 2007 15:55:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 07 15:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEoDT-0007j3-2L
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 15:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161348AbXBGO4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 09:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161347AbXBGO4A
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 09:56:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:41435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161350AbXBGOz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 09:55:59 -0500
Received: (qmail invoked by alias); 07 Feb 2007 14:55:58 -0000
X-Provags-ID: V01U2FsdGVkX18IEyU09RAIy3dhfhDBV3OvxdyKglOqOJTFWp+FDz
	mDpw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C9E470.7030609@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38926>

Hi,

On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:

> I had a try to see whether I could make GUB
> also produce a MinGW installer for Git.

Great!

> You can download the result at 
> 
> http://lilypond.org/mingit/mingit-1.4.9993-1.mingw.exe
> 
> the odd version number was because I was too lazy to write code
> to extract the version number from the repository automatically.
> 
> I don't actually have a windows copy, so it's basically untested.
> However, I did succeed in running rev-list in wine.

I played a little with it. IMHO it makes no sense to use it without a 
bash, and without less. For example,

	$ git init
	$ git add git.exe
	$ git status
	$ git commit -a -m initial
	$ git show HEAD

do not produce any output when issued in cmd.

Also, many scripts rely on bash and/or perl, so you'd have to include 
them, too.

> PS. I'd be interested in comments on using GUB from others.
> GUB is a cross-compiling build tool, probably best described
> as a "Poor Man's Conary".
>  
> Once I have the boilerplate code committed, building this 
> installer should amount to  
> 
>   darcs get  http://lilypond.org/vc/gub.darcs/ gub
>   cd gub
>   make -f Makefile.mingit bootstrap mingw

I'll try that if I get the time.

> (yes, GUB itself is still hosted in Darcs. Shoot me.)

I will.

Ciao,
Dscho
