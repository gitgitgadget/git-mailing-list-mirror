From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.6
Date: Sat, 18 Jun 2005 03:38:05 -0700 (PDT)
Message-ID: <20050618103805.8461.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: berkus@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 18 12:33:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djad3-0003o3-FT
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 12:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFRKiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 06:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVFRKiN
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 06:38:13 -0400
Received: from web26302.mail.ukl.yahoo.com ([217.146.176.13]:28817 "HELO
	web26302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261291AbVFRKiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 06:38:06 -0400
Received: (qmail 8463 invoked by uid 60001); 18 Jun 2005 10:38:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sv178FF4gmGogXLIWF9+LYtTRa+bhSYEeEg+R1EXOsBakxviC1v/1DhXnlCyarl6SL7lco+UL7B7ClfVNYrCFrcAue1C7z9Wy2k5mDwicW8ppEwNFQkAUfx3PgDJiezv3LGOUzchlhdh0xBvs1P58voP+ziGMebdCSrYNreyG50=  ;
Received: from [151.42.103.167] by web26302.mail.ukl.yahoo.com via HTTP; Sat, 18 Jun 2005 03:38:05 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is qgit-0.6, a git GUI viewer

New in this version:

- added annotate

- added color highlighting to selected diff target

- added color to file list: green new file, red removed one

- fixed locale visualizations

- fixed correct git-rev-list range handling

- fixed center on deleted files in diff viewer

- fixed disappearing files when reloading (nasty one)

- clean up of diff target logic

- added README

You can download from 
http://prdownloads.sourceforge.net/qgit/qgit-0.6.tar.bz2?download

To try qgit:

1) Unpack downloaded file
2) make
3) cd bin
4) copy qgit bin file anywhere in your path

Some (updated) screenshots at:
http://sourceforge.net/project/screenshots.php?group_id=139897

A word on annotate: In file viewer, after a while :-), the file contents will change to show the
annotations. Annotations are calculated in background so it may takes some time to show (it
depends mostly on fetching history patches with git-diff-tree -p ). History is snapshotted to
actual loaded data so peraphs you need qgit to have loaded an interesting amount of data before
calling file viewer.


I think all known (to me) problems should be fixed now. Apart from the new annotate function, a
bit experimental, qgit should be quite usable. 
So if you find some bugs/issues/inconsistencies/ etc.. please drop me a line.


Marco




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
