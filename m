From: jidanni@jidanni.org
Subject: Re: shallow clone, shallow fetch?
Date: Thu, 01 Jan 2009 10:54:12 +0800
Message-ID: <877i5fohwr.fsf@jidanni.org>
References: <87vdt24zz4.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 03:55:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIDis-0000O5-6D
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 03:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbZAACyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 21:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbZAACyR
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 21:54:17 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:52266 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752084AbZAACyQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Dec 2008 21:54:16 -0500
Received: from jidanni.org (122-127-33-78.dynamic.hinet.net [122.127.33.78])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 815E6414EB
	for <git@vger.kernel.org>; Wed, 31 Dec 2008 18:54:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104287>

Last week I did git-clone --depth 1 This week I wanted to freshen my
repository, with the same goal: "I don't care about history, just
fast forward me with the least bytes transfered." But all I can find
is just plain git pull. Did I achieve my goal?
$ git pull
remote: Counting objects: 7007, done.
remote: Compressing objects: 100% (3057/3057), done.
remote: Total 7007 (delta 4280), reused 6076 (delta 3625)
Receiving objects: 100% (7007/7007), 2.96 MiB | 26 KiB/s, done.
Resolving deltas: 100% (4280/4280), done.
From git://git.kernel.org/pub/scm/git/git
   2fa431b..bbbb865  html       -> origin/html
   a9012e3..936b705  maint      -> origin/maint
   dfd79c7..794d84e  man        -> origin/man
   159c88e..c32f76f  master     -> origin/master
   3b9b952..6f67462  next       -> origin/next
 + b14a7fb...89bdc19 pu         -> origin/pu  (forced update)
Merge made by recursive.
 Documentation/Makefile             |    9 +++++----
 Documentation/RelNotes-1.6.1.1.txt |   23 +++++++++++++++++++++++
 Documentation/cat-texi.perl        |    8 ++++++--
 Documentation/git-reset.txt        |   29 ++++++++++++++++++++++++++++-
 builtin-pack-objects.c             |    9 ++++++++-
 builtin-reset.c                    |   26 ++++++++++++++++++--------
 gitweb/gitweb.perl                 |    5 +++--
 t/t5302-pack-index.sh              |    1 +
 8 files changed, 92 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/RelNotes-1.6.1.1.txt
