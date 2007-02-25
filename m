From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-1.5.5
Date: Sun, 25 Feb 2007 18:58:12 +0100
Message-ID: <e5bfff550702250958n6cddc5b5lec4badf1f7fc8231@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 18:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNdb-0007BH-B7
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbXBYR6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbXBYR6O
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:58:14 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:42073 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973AbXBYR6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:58:13 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1034725nze
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 09:58:12 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VRcjQPq9D6lRfE9G5kdHohg9OmeNrZN9cknRrrB5gvkz5wGMkD6ebOEFIU1p/2mYGIctGroHS0wBCk6gZEYNNriwMEkcZXCIwMQQp/bF5ys8aqfNcmm3+2D3sxqOsrDXX5V8cjc4w8kavClIlAedCIzJupb1rW4C0+bmaIHDE6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AnGQ/hWyQnLRz5CxUBmZIxlKIRNJx+3SgfYs3FQinkZALjR9R+O5onQeUb11+n3LKUxc6CcztBYB0S1J9a0Ogz8E7w84iDrlgYidOjrcjqqbEHeNGCYSTeMGUsNq1t9zSAaIJ+hdRW5x0dePxNtYjpXcG3bsHdoBip9JaUpSotQ=
Received: by 10.115.17.1 with SMTP id u1mr625187wai.1172426292115;
        Sun, 25 Feb 2007 09:58:12 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 25 Feb 2007 09:58:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40563>

qgit is a git repository GUI browser. This is mostly a bug fix release.

Due to a change in git-rev-list output in git version 1.5 and above in
case of commit encoding information old version of qgit are no more
compatible and big issues in revision list view are possible under
some circumstances.

So an upgrade to this release is strongly suggested for all the users
of new version of git (1.5 and above).

Download tarball from http://www.sourceforge.net/projects/qgit or
directly from git public repository
git://git.kernel.org/pub/scm/qgit/qgit.git

Please refer to http://digilander.libero.it/mcostalba/ for additional
information.

	Marco

P.S: There is also a Qt4 version (works under Windows) downloadable
from git://repo.or.cz/qgit4.git  it is a little bit experimental
tough.



ChangeLog from 1.5.4

- fix a spurious double popup menu in rare cases

- add support to show user info in Edit->Settings->Commit

- file names cache optimization: reduce load time by 35% and memory by 30%

- fix opening a repo from a read-only filesystem

- filter out StGIT bases in our tag list

- use light orange for remote branches (Pavel Roskin)

- add 'Remote branches' context sub menu

- fix disappearing merge files list when browsing revs

- delay cache loading a little bit and fix a bug

- fix a parsing error in case of combined merges

- support new git text encoding policy in log messages

- fix a subtle bug that could lead to miss an update event

- fix bug in revisions loading sequence numbers

- fix parsing in case of revision headers with extended information

- fix stripping of comments in commit dialog message
