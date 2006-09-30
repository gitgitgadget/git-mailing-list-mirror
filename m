From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE qgit-1.5.2] bug fix release
Date: Sat, 30 Sep 2006 08:30:03 +0200
Message-ID: <e5bfff550609292330s68f309dcodb6617e006002f61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 30 08:30:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTYMd-00026p-FS
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 08:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWI3GaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWI3GaG
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 02:30:06 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:45230 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751070AbWI3GaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 02:30:04 -0400
Received: by py-out-1112.google.com with SMTP id n25so1577354pyg
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 23:30:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y+aG/zRRp0KZWBTOXe6N1lEFkDw6d3Qa6I9AllCV6zPBCZqQF7e1ERPhBqPDzcFWmwVZPvzZ2fQQ7WR07W746EGXXx9x0yMfswLuQSaufORanZuU3Q/ya6+YHD/LRFT4UdxzAEIhcW+0I/pU9XHsZXLav8GS6pAL/Ns3BzA0x5A=
Received: by 10.35.37.13 with SMTP id p13mr2151958pyj;
        Fri, 29 Sep 2006 23:30:03 -0700 (PDT)
Received: by 10.35.42.9 with HTTP; Fri, 29 Sep 2006 23:30:03 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28139>

This is mostly a bug fix release.

Fixes are all over the place but most important are the fixes to code
range filtering.

Code range filtering is when you select some text in file viewer and
want to view the list of revisions that modified that code range.

Download tarball from http://www.sourceforge.net/projects/qgit

or directly from git public repository
git://git.kernel.org/pub/scm/qgit/qgit.git


Please refer to http://digilander.libero.it/mcostalba/ for additional
information.

	Marco


ChangeLog from 1.5.1

- fix a memory leak in case annotation is closed while processing
- fix a rare segfault due to a race in annotation code
- fix commit when the change in working dir is a file deletion
- fix file list is not cleared when changing to revision with no files
- load file history without --topo-order option
- fix bold file content after removing range filter
- fix range filter miscalculation
- fixed two bugs in range filter code
- fix file view font to match main view one
- fix date/time column title issues
- fix a very rare hang on exit
- refactor exceptions handling code
