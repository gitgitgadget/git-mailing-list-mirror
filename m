From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 0/6] Convert the remaining tests to use "git foo"
Date: Wed, 10 Sep 2008 06:25:23 +0900
Message-ID: <20080910062523.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:27:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAk7-0007HH-N6
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbYIIV0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbYIIV0O
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:14 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33439 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbYIIV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:14 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 3BDC0C89D8;
	Tue,  9 Sep 2008 16:26:04 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id NRFVLH6ND7OE; Tue, 09 Sep 2008 16:26:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=rEZwLgi7rtPjR88zMshx4dTqjemWmle5NE2C79eVWua7yo2YH638pwlKYg9FYocF194mVaOy3hT9fV5OGg2YBUut2ZkMyMiDUWBFNFaY5rGCQayuXwvm615WOgRha7tU8SOeNSlP2zjwJXECuFYb+/9ndXRfKBsMAcGMwlmm1Nw=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95435>

These patches convert the tests to use "git foo".

Nanako Shiraishi (6):
  t9200: use "git cvsexportcommit" without dash
  t9300, t9301: use "git fast-import/fast-export" without dash
  t9700: use "git config" without dash
  tests: use "git foo" without dash in strings
  t9101: use "git hash-object" without dash
  t9400, t9401: use "git cvsserver" without dash

 t/t7606-merge-custom.sh                     |    2 +-
 t/t9100-git-svn-basic.sh                    |    4 +-
 t/t9101-git-svn-props.sh                    |   32 +++++-----
 t/t9102-git-svn-deep-rmdir.sh               |    4 +-
 t/t9112-git-svn-md5less-file.sh             |    2 +-
 t/t9122-git-svn-author.sh                   |    2 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9124-git-svn-dcommit-auto-props.sh       |    4 +-
 t/t9200-git-cvsexportcommit.sh              |   14 ++--
 t/t9300-fast-import.sh                      |   80 +++++++++++++-------------
 t/t9301-fast-export.sh                      |    2 +-
 t/t9400-git-cvsserver-server.sh             |   38 ++++++------
 t/t9401-git-cvsserver-crlf.sh               |    8 +-
 t/t9600-cvsimport.sh                        |    2 +-
 t/t9700-perl-git.sh                         |   16 +++---
 15 files changed, 106 insertions(+), 106 deletions(-)


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
