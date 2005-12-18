From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE qgit-1.0rc1]
Date: Sun, 18 Dec 2005 18:45:30 +0100
Message-ID: <43A5A03A.1060109@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Dec 18 18:48:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo2cb-0003mm-7z
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 18:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbVLRRpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 12:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbVLRRpj
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 12:45:39 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:22421 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965236AbVLRRpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2005 12:45:38 -0500
Received: (qmail 50246 invoked from network); 18 Dec 2005 17:45:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=X4+yOjZKQxEYn1aMpnjawS8wrIWa33IFqda6HAZGt4I8BPiHsUOgTQXkJrQAkXkzWhZtFKJt8kp87Aio69fsbPTn+f6HPvztSD/aF4EAZiTlA0sSOKC0xRSomPwG1Uw2oct4FHnM7HDM4X9iimKyH1I0a7kG01X8RZnagcl7Adc=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.44.24.75 with plain)
  by smtp015.mail.yahoo.com with SMTP; 18 Dec 2005 17:45:37 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13797>

A good amount of small fixes and just few non intrusive features
added, biggest one are speed-up of ref reading at startup, a per
repository charset encoding using i18n.commitencoding git config
variable and an annotation progress bar.

I plan to relase 1.0 for end of next week, so I would like to catch
last minutes bugs with this rc1.

Thanks to Pavel and Junio for fixes and suggestions.


DOWNLOAD

Download tarball from sourceforge as usual:
http://prdownloads.sourceforge.net/qgit/qgit-1.0rc1.tar.bz2?download

Or directly from git repository:
http://digilander.libero.it/mcostalba/qgit.git

With Junio help, I setup the repository to work both with cg-clone and
git-clone and also
tags fetching is available now ;-)


INSTALLATION

You need scons and qt-mt developer libs, version 3.3.4 or better,
already installed.

qgit is NOT compatible with Qt4.

On some platforms (Debian) you should set QTDIR before to compile.

- unpack tar file
- make
- make install

qgit will be installed in $HOME/bin


CHANGELOG

- reselect current revision after a refresh or a tree filter/un-filter
- speed up startup refs reading deferring tag messages fetching
- print offending command line when running commands synchronously
- added fancy annotation progress bar
- use git variable i18n.commitencoding to store charset codec name
- converted to use git-peek-remote to read refs: slower but cleaner
- added python and perl file icons in tree view
- fix a long standing bug that filters out error reporting when a
  process writes to stderr
- fix tree filtering when tree selected item is not visible
- fix error getting file sha
- add wait cursor while opening tree directory
- fix issue with mouse right-click that could freeze the UI in some cases
- always load names cache file if present
- fix graph in (rare) case of initial rev to be a fork
- fix enable/disable 'view diff' and 'view file' menus policy
- fix multi-tag commits display in status bar
- remove PGP signature from tag message
- fix file viewer sometimes opens on a wrong file when file is tree selected


Marco

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
