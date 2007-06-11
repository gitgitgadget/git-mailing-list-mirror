From: "Alex R.M. Turner" <aturner@plexq.com>
Subject: Problem with a push
Date: Mon, 11 Jun 2007 16:32:47 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
Reply-To: plexq@plexq.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 23:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxrVQ-0005n8-PL
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXFKVct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXFKVct
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:32:49 -0400
Received: from www.mintpixels.com ([72.51.39.73]:33147 "EHLO www.plexq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbXFKVcs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:32:48 -0400
Received: by www.plexq.com (Postfix, from userid 500)
	id 13DCE7FC118; Mon, 11 Jun 2007 16:32:48 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by www.plexq.com (Postfix) with ESMTP id 0F0967F0AC0
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 16:32:47 -0500 (CDT)
X-X-Sender: aturner@www.mintpixels.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49888>


I get the following error when pushing after a merge:

updating 'refs/heads/master'
  from c18f9e4350c26e6b45d0a282ff32991784becbdd
  to   39b7d927720c9f2810e0af5311975119c0d7c7bd
updating 'refs/remotes/origin/HEAD'
  from 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
  to   c18f9e4350c26e6b45d0a282ff32991784becbdd
updating 'refs/remotes/origin/master'
  from 1e631edb3078ec3a4d1fa598c8f410f6a61659b0
  to   c18f9e4350c26e6b45d0a282ff32991784becbdd
Generating pack...
Done counting 26 objects.
Result has 10 objects.
Deltifying 10 objects...
 100% (10/10) done
Writing 10 objects...
 100% (10/10) done
Total 10 (delta 7), reused 0 (delta 0)
refs/heads/master: c18f9e4350c26e6b45d0a282ff32991784becbdd -> 
39b7d927720c9f2810e0af5311975119c0d7c7bd
ng refs/remotes/origin/master failed to lock
refs/remotes/origin/HEAD: 1e631edb3078ec3a4d1fa598c8f410f6a61659b0 -> 
c18f9e4350c26e6b45d0a282ff32991784becbdd
error: Ref refs/remotes/origin/master is at 
c18f9e4350c26e6b45d0a282ff32991784becbdd but expected 
1e631edb3078ec3a4d1fa598c8f410f6a61659b0
error: failed to lock refs/remotes/origin/master
error: failed to push to 'ssh://aturner@svn.mintpixels.com/data/git/mls'

but when I try it again, it just says Everything up-to-date.

Alex
