From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE] qgit 1.0
Date: Fri, 30 Dec 2005 11:24:03 +0100
Message-ID: <43B50AC3.5000307@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Fri Dec 30 11:24:35 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsHQx-0007gP-Oh
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 11:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVL3KYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 05:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVL3KYO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 05:24:14 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:8373 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750725AbVL3KYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2005 05:24:14 -0500
Received: (qmail 81334 invoked from network); 30 Dec 2005 10:24:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=ZjLkYzM55HZ+fkfzdNFRaYjm9tI0m5WpXDMqizueP8Bc7lBWmmEzX6gUBPEkrlSynikZrYst5M+4b/9SciRo8iujgl/+d2sMZglJQ4ORUl3/u09A/RsWcQ91y4pLcQs8CSRW1ojw6jGzuvV/unWPqEGh7FJqgomJ+FN2tueijoM=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.44.27.217 with plain)
  by smtp011.mail.yahoo.com with SMTP; 30 Dec 2005 10:24:10 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14111>

qgit, a git GUI viewer.

With qgit you will be able to browse revisions history, view patch content and changed
files, graphically following different development branches.


FEATURES

  - View revisions, diffs, files history, files annotation, archive tree.

  - Commit changes visually cherry picking modified files.

  - Apply or format patch series from selected commits, drag and
    drop commits between two instances of qgit.

   - qgit implements a GUI for the most common StGIT commands like push/pop
    and apply/format patches. You can also create new patches or refresh
    current top one using the same semantics of git commit, i.e. cherry picking
    single modified files.


NEW IN THIS RELEASE

 From the last release candidate qgit has undergone an heavy stress test by me
and Pavel. We have found and fixed many crash bugs.
These bugs may not be exploitable by a 'normal' use of the tool, anyway we
feel qgit is pretty stable now.

Another, important, fix is a nasty and subtle 'data missing while loading' bug.
This one, reported and debugged by Pavel Roskin, is due to an elusive race and
is visible only on some platforms and only under certain conditions.

Thanks to everybody who helped qgit with patches and suggestions and particularly to Pavel.


DOWNLOAD

TARBALL: http://prdownloads.sourceforge.net/qgit/qgit-1.0.tar.bz2?download
GIT: http://digilander.libero.it/mcostalba/qgit.git
BINARY (against Qt3.3): http://digilander.libero.it/mcostalba/qgit

Links page: http://digilander.libero.it/mcostalba/


INSTALLATION

You need scons and qt-mt developer libs, version 3.3.4 or better, already installed.

qgit is NOT compatible with Qt4.

On some platforms (Debian) you should set QTDIR before to compile.

- unpack tar file
- make
- make install

qgit will be installed in $HOME/bin


CHANGELOG (from qgit-1.0rc2)

- check 'sign off' setting flag for patch apply too

- fix a crash when getting annotation under stress test [by Pavel Roskin]

- fix crash in file viewer under stress test

- use 'Head' to label current branch, use 'Branch' otherwise

- fix crash when quickly refreshing repo (F5) with tree viewer open

- fix a race: cancel pending annotation before to update the state.

- reuse of invalid lastItem in MainImpl::appendHistCommit [by Pavel Roskin]

- fix a missing/corrupted data bug in git reading functions (very bad!)

- fix missed tree selection in same cases

- fix regression: file viewer broken with deleted files

- fix crash when closing qgit while starting up

- fix a crash when closing file viewer before file content is loaded

- fix regression: codecs settings broken

- ensure current rev is visible when opening diff viewer

- defer author date transformation to increase loading speed

- various small fixes and GUI tweaks

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
