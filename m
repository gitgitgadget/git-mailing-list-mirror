From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-1.2rc1
Date: Sat, 8 Apr 2006 11:44:37 +0200
Message-ID: <e5bfff550604080244y40b36292ja5cfecac28e1e749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 11:44:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FS9zy-0004o1-Aa
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 11:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWDHJoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 05:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDHJoi
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 05:44:38 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:29456 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751411AbWDHJoi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 05:44:38 -0400
Received: by wproxy.gmail.com with SMTP id 36so498798wra
        for <git@vger.kernel.org>; Sat, 08 Apr 2006 02:44:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JYt/FEWEqsXmlIouNOmQNCYclpjIry/zipKnbWKm2hWxQs7jxZRsQsEV5J50SONhvpZKFl21ZiF/32jhpDD/vWDOyteY9ek8b9bP0L8EehyCbOtaoU4/VzC2cHuYrTt9oRR1a6LbkTvffnByuzdYDafPfhuqTh2Hy2bN0hQYiLA=
Received: by 10.65.253.12 with SMTP id f12mr2913764qbs;
        Sat, 08 Apr 2006 02:44:37 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 8 Apr 2006 02:44:37 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18513>

qgit is a very fast git GUI viewer with a lot of features .

The biggest new feature this time is *code range filtering*

Select a file and  open the file/annotation viewer, then wait for
annotation finished and then select a history revision just to be sure
annotation info is displayed.

You will see the new 'filter' button (in annotation window tool
bar, not in main view tool bar) enabled. Press it and the file history
will be shrinked to show only revisions that modified the selected lines.

Selected code region is also highlighted for better browsing.
Filter button is a toggle button, so just press again it to release the filter.

NOTE NOTE: Range filtering it's  _slippery_   code, there are a lot of
subtle details involved, so may be something it's still missing/bogous,
qgit-1.2rc1 it's here to let properly test before final release.


DOWNLOAD

Tarball is at
http://prdownloads.sourceforge.net/qgit/qgit-1.2rc1.tar.bz2?download

Git archive is at
http://digilander.libero.it/mcostalba/scm/qgit.git

See http://digilander.libero.it/mcostalba/  for detailed download information.


INSTALLATION

To install from tarball use:

./configure
make
make install-strip

To install from git archive:

autoreconf -i
./configure
make
make install-strip

Or check the shipped README for detailed information.

CHANGELOG

 - add support for code range filtering

- much improved graph for partial repos views. Use new --boundary
git-rev-list option

- pressing ESC in startup dialog make application to quit

- add support for quick open of latest visited repositories

- add support for launching an external diff viewer

- speed-up git commands execution using usleep() in external program launcher

- highlight filter matches in revision logs

- add git version compatibility check

- fix duplicated unapplied patches in StGIT when qgit is called with
--all option

- fix run from subdirectory regression


             Marco
