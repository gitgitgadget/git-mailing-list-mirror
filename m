From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Newbie questions regarding jgit
Date: Wed, 12 Nov 2008 23:36:54 +0100
Message-ID: <200811122336.55408.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0OLs-0007Ff-L1
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYKLWhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYKLWg7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:36:59 -0500
Received: from mail.dewire.com ([83.140.172.130]:18277 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbYKLWg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:36:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CE0D0147D0ED;
	Wed, 12 Nov 2008 23:36:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCxliTu19lWO; Wed, 12 Nov 2008 23:36:56 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 41EC38028B5;
	Wed, 12 Nov 2008 23:36:56 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100824>

(resend without HTML)
tisdag 11 november 2008 22:12:58 skrev Farrukh Najmi:
> 
> I should clarify that I am not using eclipse nor am I using any GUI. My 
> objective is to have Java API access to git from within a servlet using 
> jgit. At present, all I have to go on is javadoc and its not clear where 
> to begin if I simply wish to create, read and update files in a git repo 
> from within the servlet java code.
>
We do not have a tutorial. The JUnit tests are the best examples on 
how to use the API today. I did some experiement wit J2EE and created
some jsp tags, but that's for JSP only and mostly experimental. To
comply with the JEE spec one should create a resource manager for
Git to deal with scalability when many users try to access repos.

> > I am git newbie and looking to use jgit in a servlet endpoint.
> >
> > Where can I find a public maven repo for gjit? It seems there is one 
> > somewhere because of the following file in src tree:
> >
> > jgit-maven/jgit/pom.xml

We do not use maven ourselves right now, though that might change, so
there is not public maven repository for jgit just yet. What do I need to
do to set it up?

> >
> > For now I have built the jar using /make_jgit.sh and installed the pom 
> > manually using m
> >
> > mvn install:install-file -DpomFile=jgit-maven/jgit/pom.xml 
> > -Dfile=jgit.jar

The pom.xml works for building jgit. cd to the mave dir and type mvn
and watch it build (and run unit tests if you ask it to).

-- robin
