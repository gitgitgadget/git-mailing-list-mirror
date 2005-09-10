From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE qgit-0.94]
Date: Sat, 10 Sep 2005 10:16:33 -0700 (PDT)
Message-ID: <20050910171633.1179.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 10 19:19:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EE90E-0001OX-AR
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 19:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVIJRQz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 13:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVIJRQz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 13:16:55 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:3992 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751058AbVIJRQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 13:16:54 -0400
Received: (qmail 1181 invoked by uid 60001); 10 Sep 2005 17:16:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dgjO9hwmJwkw+NYDDeTLpWGdYJzuvUEnKkA22oke6Beq1rH4sQss/zbHHaoNScjAH0IePlaaTyUIj2fAjAh5h5F3ksuwcupCceGxj6Wx2sWH1aIJ/EsQ5zPK736iDn3iJ/p25Vrx0XM90Louj3XQ/1v2LwNs/GMrzrlUGg3vA6M=  ;
Received: from [151.38.102.245] by web26303.mail.ukl.yahoo.com via HTTP; Sat, 10 Sep 2005 10:16:33 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8256>

With the help and feedback from Catalin qgit now support integration
with StGIT:

-Visualization of applied/unapplied patches in main view

-Push/pop patches with a mouse right click on selected items. 
 Push supports also multi-selection. (NOTE: you need a clean tree)

- Commit changes to a new patch or refresh the topmost patch. 
  Commit on StGIT has the same behavior of committing on pure 
  git, i.e. it is possible to chose the single files to commit/refresh.

- Apply/fold external patches through StGIT


Other important, under the hood, improvment is perfromance. QGit is much more faster 
then previous release. On my box it's the fastest tool (not that there are many ;-) ) 
to load the complete git linux tree.

Download link is as usual:
http://prdownloads.sourceforge.net/qgit/qgit-0.94.tar.bz2?download

But now there is also a git archive: 
http://digilander.libero.it/mcostalba/qgit.git

Please use 'cg-clone http://digilander.libero.it/mcostalba/qgit.git' if interested,
git pull currently downloads only empty directories. Peraphs it has to do with curl 
parameters and the settings of the site server but I didn't had the time to look closer.

If you have problems with the sources (Debian users should set QTDIR before compile) 
you can download a binary: http://digilander.libero.it/mcostalba/qgit


Complete changelog below

- added integration with StGIT:
   1)Visualization of applied and unapplied patches in main view.
   2)Interface to push/pop patches by a mouse right click on selected items
     Push supports also multi-selection
   3)Interface to new/refresh patches
   4)Interface to patch import/fold 

- big performance improvements. qgit has been tuned for performance and responsiveness

- updated annotate to show only interesting commits, i.e. no empty merges

- added refresh command by F5 or file->refresh to quick reload archive

- added a setting to disable background load of file names and load only on demand. Can be
  useful in case of big archives and low memory. Warning, browsing of commits and
  annotation function are greatly slowed down

- updated to recent git big rename

- various small bug fixes and GUI tweaks



	Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
