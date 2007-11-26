From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: patches
Date: Mon, 26 Nov 2007 02:27:45 +0000
Message-ID: <20071126022745.GI23820@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 03:28:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwThe-0002tt-Rf
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 03:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbXKZC1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 21:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXKZC1s
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 21:27:48 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45391 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbXKZC1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 21:27:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IwThJ-00044m-IY; Mon, 26 Nov 2007 02:27:45 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66036>

There's some more user-manual stuff in the git repository at

  ssh://linux-nfs.org/~bfields/exports/git.git maint

J. Bruce Fields (4):
      user-manual: define "branch" and "working tree" at start
      user-manual: failed push to public repository
      user-manual: clarify language about "modifying" old commits
      user-manual: recovering from corruption

 Documentation/user-manual.txt |  225 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 201 insertions(+), 24 deletions(-)

--b.

commit 1cdade2c4cb27f648a98d326ef3db523b6afafa7
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Sat Mar 3 22:53:37 2007 -0500

    user-manual: recovering from corruption
    
    Some instructions on dealing with corruption of the object database.
    
    Most of this text is from an example by Linus, identified by Nicolas
    Pitre <nico@cam.org> with a little further editing by me.
    
    Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>

commit 7cb192eab0251911e2ca77d4ecceb621dd2d34f5
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Sun Nov 25 19:01:57 2007 -0500

    user-manual: clarify language about "modifying" old commits
    
    It's important to remember that git doesn't really allowing "editing" or
    "modifying" commits, only replacing them by new commits.  Redo some of
    the language to make this clearer.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

commit 81eb417ad423ef7e8d088d517f89d3bda92f9c06
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Sun Nov 25 17:54:19 2007 -0500

    user-manual: failed push to public repository
    
    More details on the case of a failed push to a public (non-shared)
    repository.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

commit 0c4a33b54f3dbb9fa8cd2f5cf0e2a6363849d899
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Sun Nov 25 13:53:37 2007 -0500

    user-manual: define "branch" and "working tree" at start
    
    Some explanation here might help.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
