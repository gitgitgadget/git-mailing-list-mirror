From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 00:07:19 -0700 (PDT)
Message-ID: <20050925070719.67119.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 09:08:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJQbo-00037Q-8a
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 09:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVIYHHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 03:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVIYHHV
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 03:07:21 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:8382 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751186AbVIYHHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 03:07:20 -0400
Received: (qmail 67121 invoked by uid 60001); 25 Sep 2005 07:07:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CjLabSkGoE9QYvQCBiO2gq5eM+J/HQLhbX4maj7dB0+xxbJPpQpnGVeXw1wSQ13ROWFYi+3GdkBtC7eerKTUDluIObYQU7Phgtm/xtcyiwjqUrkIPdX2x1C6iyOaKPMCN5Io7oaeMXPh+OuG8OC046gzI2gscfbYODyWaiJMN6k=  ;
Received: from [151.38.74.126] by web26309.mail.ukl.yahoo.com via HTTP; Sun, 25 Sep 2005 00:07:19 PDT
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9260>

Alan Chandler wrote:

>On Sunday 25 Sep 2005 07:32, Alan Chandler wrote:
>...
>
>>However when I run make I get errors of the form shown below (QSettings
>>errors) and eventually the compile stage fails.
>>
>>/usr/share/qt3/bin/uic -o src/rangeselectbase.h src/rangeselectbase.ui
>>/usr/share/qt3/bin/uic -impl rangeselectbase.h -o
>>src/uic_rangeselectbase.cc src/rangeselectbase.ui
>>/usr/share/qt3/bin/moc -o src/moc_rangeselectbase.cc src/rangeselectbase.h
>>QSettings: error creating /.qt
>>QSettings: error creating /.qt
>>QSettings: error creating /.qt
>>QSettings: error creating /.qt
>>QSettings: error creating /.qt
>>QSettings::sync: filename is null/empty
>>QSettings: error creating /.qt
>>QSettings::sync: filename is null/empty
>>QSettings: error creating /.qt
>>QSettings::sync: filename is null/empty
>>g++ -O2 -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/include/qt3
>>-I/usr/share/qt3/include -c -o src/git_startup.o src/git_startup.cpp
>>src/git_startup.cpp: In member function `void Git::parseReadFromStdout()':
>>src/git_startup.cpp:473: error: jump to label `resume'
>>src/git_startup.cpp:439: error:   from here
>>src/git_startup.cpp:467: error:   crosses initialization of `newCommits*nc'
>>scons: *** [src/git_startup.o] Error 1
>>scons: building terminated because of errors.
>>make: *** [all] Error 2
>>alan@kanger qgit-0.95 $
>
>
>Although the QSettings are still there, fixing up git_startup.cpp as per 
>Pasky's patch fixed it for me
>

QSettings are there from day one :-<
I am not able to let them disappear.....very bad. In any case should be harmless.

This morining I have updated the downloads with Pasky's patch.

Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
