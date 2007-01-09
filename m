From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit4 aka qgit ported to Windows
Date: Tue, 9 Jan 2007 22:14:00 +0100
Message-ID: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jan 09 22:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4OII-00082c-Qe
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXAIVOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXAIVOD
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:14:03 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:7644 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371AbXAIVOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:14:00 -0500
Received: by py-out-1112.google.com with SMTP id a29so4290074pyi
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 13:14:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sv5sn0v5njx8zmG3a6E6TPs1jQsChnMSjVS9/4xhDaize5F+FoLjIIokD4fBVV6AJoyB/hJxhOr+ffUwGxNnp1rtOMK/cmOcgIKE/D0yJ3OL4G0O+59q7zk5j/DCgL8n9CsGleMQu7OoXpbQYlTjWlVLPMqoklEmSOVfTIo8Sho=
Received: by 10.35.27.1 with SMTP id e1mr35466865pyj.1168377240340;
        Tue, 09 Jan 2007 13:14:00 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 13:14:00 -0800 (PST)
To: "GIT list" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36401>

I have setup, (thanks Pasky) the repository

     git://repo.or.cz/qgit4.git


With an experimental version of qgit, called qgit4.

Features are the same of qgit-1.5.4  release but has been ported under
Qt4.2 libraries from Qt3, this means that could be compiled and run as
a Windows native application.

Qt4.2 is available as GPL for non commercial purposes also for Windows platform.

So what you need is:

1) Qt4.2 already packaged with MinGW for windows
(http://www.trolltech.com/developer/downloads/qt/windows)

2) Cygwin with git files

3) qgit sources from the above public repository

4) Compile using qmake that will build proper Makefile for you

    - qmake qgit.pro
    - make
    - (make install is supported only under Linux at the moment)

5) Open a terminal with cmd.exe, add Qt and MinGW bin dirs to PATH
(already added if you run the ready to use Qt command prompt menu that
comes with Qt installation), add cygwin bin directory to PATH,
something like:

               set PATH=%PATH%;C:\cygwin\bin\directory


6) Start qgit.exe

7) Have fun

NOTE NOTE: DO NOT RUN from a cygwin terminal, as I said qgit it's a
*native* Windows application when compiled with Qt4.2 so you don't
need that.

Well, I have tried to run from a cygwin terminal and it works almost
the same (of course you need to add Qt and MinGW bin dirs to path as
always) but it's much slower and has some little issues with the
different paths conventions.

NOTE: This is 'alpha' quality software, not all features are already
working so be prepared to few surprises.

Marco

P.S: Of course the same sources work (better) also under Linux.
