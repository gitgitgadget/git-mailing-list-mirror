From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [SCuMD]
Date: Thu, 27 Aug 2009 16:41:38 +0200
Message-ID: <200908271641.38368.robin.rosenberg.lists@dewire.com>
References: <4A965799.6050204@gmx.de> <4A965A1D.3060104@op5.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Christian Senkowski <csenkowski@gmx.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MghG2-0005Nj-U3
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 17:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbZH0PvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 11:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZH0PvR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 11:51:17 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:51341 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828AbZH0PvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 11:51:16 -0400
X-Greylist: delayed 4167 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2009 11:51:16 EDT
Received: from sleipner.localnet (90.232.71.229) by pne-smtpout2-sn1.fre.skanova.net (7.3.140.3)
        id 4A2D61FD0070309E; Thu, 27 Aug 2009 16:41:43 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4A965A1D.3060104@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127166>

torsdag 27 augusti 2009 12:04:13 skrev Andreas Ericsson <ae@op5.se>:
> Christian Senkowski wrote:
> > Hi,
> > 
> > I cloned SCuMD directly via git and started it but got following error:
> > 
> > ~/scumd$ ./run.sh
> > Exception in thread "main" java.lang.NoClassDefFoundError:
> > com.asolutions.scmsshd.SCuMD
> >    at gnu.java.lang.MainThread.run(libgcj.so.90)
> > Caused by: java.lang.ClassNotFoundException:
> > com.asolutions.scmsshd.SCuMD not found in
> > gnu.gcj.runtime.SystemClassLoader{urls=[file:depend/lib/jgit.jar,file:depend/lib/minasshd.jar,file:lib/aopalliance-1.0.jar,file:lib/bcprov-jdk15-140.jar,file:lib/commons-io-1.4.jar,file:lib/commons-logging-1.0.4.jar,file:./,file:lib/jline-0.9.1.jar,file:lib/jline-0.9.94.jar,file:lib/jpam-1.1.jar,file:lib/jsch-0.1.40.jar,file:lib/jzlib-1.0.7.jar,file:lib/log4j-1.2.13.jar,file:lib/slf4j-api-1.5.2.jar,file:lib/slf4j-log4j12-1.4.3.jar,file:lib/spring-beans-2.5.5.jar,file:lib/spring-context-2.5.5.jar,file:lib/spring-core-2.5.5.jar],
> > parent=gnu.gcj.runtime.ExtensionClassLoader{urls=[], parent=null}}
> >    at java.net.URLClassLoader.findClass(libgcj.so.90)
> >    at gnu.gcj.runtime.SystemClassLoader.findClass(libgcj.so.90)
> >    at java.lang.ClassLoader.loadClass(libgcj.so.90)
> >    at java.lang.ClassLoader.loadClass(libgcj.so.90)
> >    at gnu.java.lang.MainThread.run(libgcj.so.90)
> > 
> > 
> > Please help me out :)
> > 

Short answer: Don't run things with GCJ unless you make sure it works
with SUN's java or OPENJDK first. If it still doesn't work ask the GCJ
people for help.

> Please refer to the SCuMD mailing list for this SCuMD related question.

Their README file refers to the Git mailing list. Hence the tag, Kind'o like
JGit, which they depend upon.

-- robin
