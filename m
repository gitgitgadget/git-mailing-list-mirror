From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems with GIT under Windows - "not uptodate"
Date: Wed, 2 Sep 2009 00:56:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909020052550.8306@pacific.mpi-cbg.de>
References: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost> <loom.20090901T184650-434@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, david.hagood@gmail.com
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MicFo-00066J-3H
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 00:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbZIAWy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 18:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbZIAWy6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 18:54:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:54869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755335AbZIAWy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 18:54:57 -0400
Received: (qmail invoked by alias); 01 Sep 2009 22:54:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 02 Sep 2009 00:54:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NMEltiSzNXNsasfW2pL6N7vgp+nR1PEANsGZ/9o
	KvTR2NNbVq8/IE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20090901T184650-434@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127562>

Hi,

Eric, is there any good reason you neglect netiquette?  I re-added David 
to the Cc: list.

On Tue, 1 Sep 2009, Eric Raible wrote:

>  <david.hagood <at> gmail.com> writes:
> 
> > Error: Entry "Some file name" not uptodate: cannot merge.
> > 
> > We've tried "git reset --hard; git pull ." We've tried "git reset --hard;
> > git checkout -f master". Neither seems to fix this.
> 
> http://article.gmane.org/gmane.comp.version-control.git/122862

To summarize: the suggestion is "rm .git/index && git reset --hard".

I have to stress the same point as in "reset --hard considered harmful" a 
while back, though.

Actually, I started writing a patch to provide "git checkout --fix-crlf" 
some weeks ago, but I constantly run out of time to finish it.

Ciao,
Dscho
