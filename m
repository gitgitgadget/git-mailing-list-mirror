From: Ingo Molnar <mingo@elte.hu>
Subject: Re: qgit-0.6
Date: Sun, 19 Jun 2005 15:05:42 +0200
Message-ID: <20050619130542.GA18325@elte.hu>
References: <20050618103805.8461.qmail@web26302.mail.ukl.yahoo.com> <20050619130035.GA15355@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, berkus@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 19 15:06:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjzV4-0001Md-7i
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 15:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVFSNLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 09:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVFSNLj
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 09:11:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23685 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262228AbVFSNJw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 09:09:52 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id B7D8631F1DE;
	Sun, 19 Jun 2005 15:03:15 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id AC4361FC2; Sun, 19 Jun 2005 15:06:21 +0200 (CEST)
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050619130035.GA15355@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


on FC4 the build is quite noisy. Not a big issue because it otherwise 
builds and works fine:

scons -Q
/usr/lib/qt-3.3/bin/uic -o src/diffbase.h src/diffbase.ui
/usr/lib/qt-3.3/bin/uic -impl diffbase.h -o src/uic_diffbase.cc src/diffbase.ui
/usr/lib/qt-3.3/bin/moc -o src/moc_diffbase.cc src/diffbase.h
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/uic_diffbase.o src/uic_diffbase.cc
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_diffbase.o src/moc_diffbase.cc
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/diffimpl.o src/diffimpl.cpp
/usr/lib/qt-3.3/bin/uic -o src/filebase.h src/filebase.ui
/usr/lib/qt-3.3/bin/uic -impl filebase.h -o src/uic_filebase.cc src/filebase.ui
/usr/lib/qt-3.3/bin/moc -o src/moc_filebase.cc src/filebase.h
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/uic_filebase.o src/uic_filebase.cc
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_filebase.o src/moc_filebase.cc
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/fileimpl.o src/fileimpl.cpp
/usr/lib/qt-3.3/bin/uic -o src/mainbase.h src/mainbase.ui
/usr/lib/qt-3.3/bin/uic -impl mainbase.h -o src/uic_mainbase.cc src/mainbase.ui
/usr/lib/qt-3.3/bin/moc -o src/moc_mainbase.cc src/mainbase.h
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
QSettings: error creating /.qt
QSettings::sync: filename is null/empty
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/git.o src/git.cpp
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/uic_mainbase.o src/uic_mainbase.cc
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_mainbase.o src/moc_mainbase.cc
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/mainimpl.o src/mainimpl.cpp
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/qgit.o src/qgit.cpp
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/thread.o src/thread.cpp
/usr/lib/qt-3.3/bin/moc -o src/moc_diffimpl.cc src/diffimpl.h
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_diffimpl.o src/moc_diffimpl.cc
/usr/lib/qt-3.3/bin/moc -o src/moc_fileimpl.cc src/fileimpl.h
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_fileimpl.o src/moc_fileimpl.cc
/usr/lib/qt-3.3/bin/moc -o src/moc_git.cc src/git.h
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_git.o src/moc_git.cc
/usr/lib/qt-3.3/bin/moc -o src/moc_mainimpl.cc src/mainimpl.h
g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib/qt-3.3/include -c -o src/moc_mainimpl.o src/moc_mainimpl.cc
g++ -o bin/qgit src/uic_diffbase.o src/moc_diffbase.o src/diffimpl.o src/uic_filebase.o src/moc_filebase.o src/fileimpl.o src/git.o src/uic_mainbase.o src/moc_mainbase.o src/mainimpl.o src/qgit.o src/thread.o src/moc_diffimpl.o src/moc_fileimpl.o src/moc_git.o src/moc_mainimpl.o -L/usr/lib/qt-3.3/lib -lqt-mt
