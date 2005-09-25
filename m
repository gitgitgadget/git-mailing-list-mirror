From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 07:47:08 +0100
Message-ID: <200509250747.08411.alan@chandlerfamily.org.uk>
References: <20050924160641.60151.qmail@web26307.mail.ukl.yahoo.com> <200509250732.06754.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Sun Sep 25 08:47:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJQI2-0000VI-DQ
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 08:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVIYGrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 02:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVIYGrG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 02:47:06 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:39373
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751195AbVIYGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 02:47:05 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EJQHw-0000gr-3D; Sun, 25 Sep 2005 07:47:04 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <200509250732.06754.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9259>

On Sunday 25 Sep 2005 07:32, Alan Chandler wrote:
...
> However when I run make I get errors of the form shown below (QSettings
> errors) and eventually the compile stage fails.
>
> /usr/share/qt3/bin/uic -o src/rangeselectbase.h src/rangeselectbase.ui
> /usr/share/qt3/bin/uic -impl rangeselectbase.h -o
> src/uic_rangeselectbase.cc src/rangeselectbase.ui
> /usr/share/qt3/bin/moc -o src/moc_rangeselectbase.cc src/rangeselectbase.h
> QSettings: error creating /.qt
> QSettings: error creating /.qt
> QSettings: error creating /.qt
> QSettings: error creating /.qt
> QSettings: error creating /.qt
> QSettings::sync: filename is null/empty
> QSettings: error creating /.qt
> QSettings::sync: filename is null/empty
> QSettings: error creating /.qt
> QSettings::sync: filename is null/empty
> g++ -O2 -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/include/qt3
> -I/usr/share/qt3/include -c -o src/git_startup.o src/git_startup.cpp
> src/git_startup.cpp: In member function `void Git::parseReadFromStdout()':
> src/git_startup.cpp:473: error: jump to label `resume'
> src/git_startup.cpp:439: error:   from here
> src/git_startup.cpp:467: error:   crosses initialization of `newCommits*nc'
> scons: *** [src/git_startup.o] Error 1
> scons: building terminated because of errors.
> make: *** [all] Error 2
> alan@kanger qgit-0.95 $

Although the QSettings are still there, fixing up git_startup.cpp as per 
Pasky's patch fixed it for me

Sorry for the noise.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
