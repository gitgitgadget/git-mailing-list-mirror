From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 14:55:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121453150.27959@racer.site>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?= <eirbjo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 15:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2T0n-0003mk-V0
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 15:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbXLLOzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 09:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXLLOzp
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 09:55:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:60225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751334AbXLLOzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 09:55:44 -0500
Received: (qmail invoked by alias); 12 Dec 2007 14:55:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 12 Dec 2007 15:55:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MSlgApSuM6qhuW/QGMcBIXCv2dsULvnMYbB6gdg
	t3AlqMuQmF0hR4
X-X-Sender: gene099@racer.site
In-Reply-To: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68042>

Hi,

On Wed, 12 Dec 2007, Eirik Bj?rsn?s wrote:

> I'm developing a piece of software that grabs logs from various types of 
> SCMs and presents (hopefully) useful information about the history.
> 
> My current approach with Git is do a "git clone --n" and then parse the 
> output of "git log". To check for updates I do a "git pull" followed by 
> a new "git log".
> 
> This approach works fine, but cloning the whole repository just to get 
> the change log seems like a somewhat inefficient use of bandwidth and 
> storage.
> 
> What I would like to do is to fetch just the change log information
> from the remote repository.
> 
> (Using the "CVS done right" tool I can do this with: "svn log --xml -v
> -r<last, HEAD> http://svn.example.com/")
> 
> I haven't found a way to do this using the Git command line tools.

It is not possible to get just the metadata.  Remember, svn can do it only 
since the repository is purely remote.  And git is a SCM (source code 
management system), not a CMV (commit metadata viewer).

You might be able to cobble up something that works accessing gitweb, but 
it might be even more inefficient.

Ciao,
Dscho
