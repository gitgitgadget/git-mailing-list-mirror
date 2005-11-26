From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE qgit-0.97.3]
Date: Sat, 26 Nov 2005 13:39:10 +0100
Message-ID: <4388576E.3080705@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 26 13:41:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfzMI-0001kG-Dk
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 13:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVKZMkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVKZMkr
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 07:40:47 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:48035 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932143AbVKZMkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 07:40:46 -0500
Received: (qmail 63167 invoked from network); 26 Nov 2005 12:40:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=oPyrbPX6VR0N2a8QV0vKz8GyqJz8y50ZUVavLOFuFaGT6U12O5h7auFE5rat3sGQ+1VLBrF0tD6qSsWvVMq1FmEVb524WzIFppSLUFghfec2e50ronuAXZAk9IZsdh8ruJNRR567F9NZXIXao51YVTzY0XjKbp3LM4A2mUja8lo=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.44.27.208 with plain)
  by smtp018.mail.yahoo.com with SMTP; 26 Nov 2005 12:40:43 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12780>

qgit, a git GUI viewer.

With qgit you will be able to browse revisions history, view patch 
content and changed files, graphically following different development 
branches.


FEATURES

  - View revisions, diffs, files history, files annotation, archive tree.

  - Commit changes visually cherry picking modified files.

  - Apply or format patch series from selected commits, drag and
    drop commits between two instances of qgit.

  - qgit implements a GUI for the most common StGIT commands like
    push/pop and apply/format patches. You can also create new patches
    or refresh current top one using the same semantics of git commit,
    i.e. cherry picking single modified files.


NEW IN THIS RELEASE

This is mainly a fix release with only some little nice features added 
(see changelog below).

Due to some good fixes and stability improvements I suggest to update.

qgit is now in '(almost) just fixes' mode to be in good shape for the 
time of git 1.0 is out, then I will relase qgit 1.0


DOWNLOAD

The page with all the download links is:
http://digilander.libero.it/mcostalba/


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

- qgit now works from subdirectories.

- added 'save file as' feature. To save on disk selected tree files.

- added support for tag messages. When tagging a revision it is
   possible to add a message, this will be shown in status bar, togheter
   with tag name, when a tagged revision is selected.

- added support for tag delete.

- rewritten file/annotate viewer to be more stable when user changes
   request while updating. Now should be possible to safely browse
   through logs and archive tree without waiting for update to finish.

- do not assume git bins directory is in $PATH. Use 'git --exec-path'.

- fix possibly wrong description for revs with no commit messages
   nor subjects

- fix annotate viewer to update correctly with 'jump to rev' function

- fix diff viewer to always center on selected file

- fix regression, bad annotation of deleted files

- various GUI tweaks and small fixes.


      Marco



	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
