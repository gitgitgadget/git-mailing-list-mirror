From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push does not work properly on git over http server
Date: Tue, 10 Feb 2009 11:41:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101140360.10279@pacific.mpi-cbg.de>
References: <20090210101951.2v9ltl1rqqskoc44@correo.alumnos.unican.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: javier.martinc@alumnos.unican.es
X-From: git-owner@vger.kernel.org Tue Feb 10 11:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWq49-0001Np-0C
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbZBJKkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZBJKkl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:40:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:51970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750904AbZBJKkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 05:40:41 -0500
Received: (qmail invoked by alias); 10 Feb 2009 10:40:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 10 Feb 2009 11:40:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qW+gl8i4qrw4e79HAVNhLhjW7UOZ/O/h0kRPa5Q
	eCl7vHijXd8mlO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210101951.2v9ltl1rqqskoc44@correo.alumnos.unican.es>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109198>

Hi,

On Tue, 10 Feb 2009, javier.martinc@alumnos.unican.es wrote:

> And have started developing and creating a new branch with several commits:
> 
> git checkout -b visstrim v2.6.22
> 
> 
> Then I would like to push my new branch to the remote server:
> git push --all origin
> Fetching remote heads...
>   refs/
>   refs/tags/
>   refs/heads/
> 'refs/heads/visstrim': up-to-date

Why does it say "up-to-date"?  Maybe it is?

> 'refs/heads/master': up-to-date
> 
> But then I do:
> git branch -r
>   origin/HEAD
>   origin/master

Probably a "git fetch" solves the issue.

Yes, http-push has been neglected.

Ciao,
Dscho
