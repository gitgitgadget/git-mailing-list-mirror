From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [ANNOUNCE qgit-0.94]
Date: Sat, 10 Sep 2005 20:33:01 +0200
Message-ID: <20050910183301.GQ15165MdfPADPa@greensroom.kotnet.org>
References: <20050910171633.1179.qmail@web26303.mail.ukl.yahoo.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 10 20:34:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEAAM-0006wN-2t
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 20:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVIJSd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIJSd1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 14:33:27 -0400
Received: from smtp14.wxs.nl ([195.121.6.28]:17373 "EHLO smtp14.wxs.nl")
	by vger.kernel.org with ESMTP id S932087AbVIJSd1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2005 14:33:27 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp14.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IMM00KLZ672JP@smtp14.wxs.nl> for git@vger.kernel.org; Sat,
 10 Sep 2005 20:33:02 +0200 (CEST)
Received: (qmail 25952 invoked by uid 500); Sat, 10 Sep 2005 18:33:01 +0000
In-reply-to: <20050910171633.1179.qmail@web26303.mail.ukl.yahoo.com>
To: Marco Costalba <mcostalba@yahoo.it>
Mail-followup-to: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org,
 catalin.marinas@gmail.com
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8258>

On Sat, Sep 10, 2005 at 10:16:33AM -0700, Marco Costalba wrote:
> If you have problems with the sources (Debian users should set QTDIR before compile) 
> you can download a binary: http://digilander.libero.it/mcostalba/qgit

I'd prefer compiling it myself, but I get this error:

bash-3.00$ make
scons
scons: Reading SConscript files ...
scons: done reading SConscript files.
scons: Building targets ...
g++ -O2 -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/include/qt3 -I/usr/lib/qt3/include -c -o src/annotate.o src/annotate.cpp
src/annotate.cpp: In member function `void Annotate::run(const QString&, 
   QStringList&, AnnotateHistory&)':
src/annotate.cpp:60: error: `count' undeclared (first use this function)
src/annotate.cpp:60: error: (Each undeclared identifier is reported only once 
   for each function it appears in.)
src/annotate.cpp: In member function `void 
   Annotate::getReachability(ReachList&, const QString&, QStringList&)':
src/annotate.cpp:161: error: `append' undeclared (first use this function)
src/annotate.cpp:169: error: `last' undeclared (first use this function)
src/annotate.cpp: In member function `QString Annotate::getRoot(const QString&, 
   const ReachList&)':
src/annotate.cpp:228: error: `count' undeclared (first use this function)
src/annotate.cpp: In member function `void Annotate::printReachList(const 
   ReachList&)':
src/annotate.cpp:303: error: `count' undeclared (first use this function)
src/annotate.cpp: In member function `QString Annotate::getAuthor(const 
   QString&, QStringList&, int)':
src/annotate.cpp:337: error: no matching function for call to `QString::remove(
   char)'
/usr/lib/qt3/include/qstring.h:497: error: candidates are: QString& 
   QString::remove(unsigned int, unsigned int)
scons: *** [src/annotate.o] Error 1
scons: building terminated because of errors.
make: *** [all] Error 2

ReachList doesn't seem to be defined anywhere.

skimo
