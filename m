From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mysterious error message
Date: Fri, 26 Sep 2008 14:01:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20593.1222378418@as220.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Sgouros <tomfool@as220.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 13:56:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjBvz-0002k1-B4
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 13:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbYIZLzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 07:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbYIZLzW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 07:55:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:37294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751138AbYIZLzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 07:55:21 -0400
Received: (qmail invoked by alias); 26 Sep 2008 11:55:20 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 26 Sep 2008 13:55:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wzclJp+8wvfFp/wR8HJsbFiE00yfRaeL/Pq6XRJ
	PiSfr/c9PMtJir
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20593.1222378418@as220.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96847>

Hi,

On Thu, 25 Sep 2008, Tom Sgouros wrote:

> I receive the following error message when I try to do a 'git push':
> 
>   tomfool@toms-box:hpl$ git push
>   updating 'refs/heads/master'
>     from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
>     to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
>    Also local refs/remotes/origin/master
>   Generating pack...
>   Done counting 10 objects.
>   Deltifying 10 objects...
>   error: pack-objects died with strange error
>   unpack eof before pack header was fully read
>   ng refs/heads/master n/a (unpacker error)
>   error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
>   tomfool@toms-box:hpl$

I got this message when I tried to push a project with submodules to a 
server which had submodule-ignorant git installed.  Maybe it's that?

Ciao,
Dscho
