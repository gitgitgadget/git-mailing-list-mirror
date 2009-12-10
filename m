From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: [PATCH 0/6] Gitweb caching changes v2
Date: Thu, 10 Dec 2009 23:45:37 +0000
Message-ID: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.6.5.2"
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 00:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIsj2-0005nb-Rb
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 00:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbZLJXqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 18:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757287AbZLJXqz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 18:46:55 -0500
Received: from hera.kernel.org ([140.211.167.34]:39922 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938AbZLJXqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 18:46:54 -0500
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.14.3/8.14.3) with ESMTP id nBANjiWK025969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 23:45:45 GMT
Received: (from warthog9@localhost)
	by hera.kernel.org (8.14.3/8.14.2/Submit) id nBANjibk025968;
	Thu, 10 Dec 2009 23:45:44 GMT
X-Mailer: git-send-email 1.6.5.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135052>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This is a multi-part message in MIME format.
--------------1.6.5.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Evening everyone,

This is the latest incarnation of gitweb w/ caching.  This is finally at the point where it should probably start either being considered for inclusion or mainline, or I need to accept that this will never get in and more perminantely fork (as is the case with Fedora where this is going in as gitweb-caching as a parrallel rpm package).

That said this brings the base up to mainline (again), it updates a number of elements in the caching engine, and this is a much cleaner break-out of the tree vs. what I am currently developing against.

New things known to work:
    - Better breakout
    - You can actually disable the cache now

- John 'Warthog9' Hawley 

John 'Warthog9' Hawley (6):
  GITWEB - Load Checking
  GITWEB - Missmatching git w/ gitweb
  GITWEB - Add git:// link to summary pages
  GITWEB - Makefile changes
  GITWEB - File based caching layer
  GITWEB - Separate defaults from main file

 .gitignore                  |    1 +
 Makefile                    |   15 +-
 gitweb/Makefile             |   14 +
 gitweb/cache.pm             |  293 +++++++
 gitweb/gitweb.css           |    6 +
 gitweb/gitweb.perl          | 1821 ++++++++++++++++++++-----------------------
 gitweb/gitweb_defaults.perl |  468 +++++++++++
 7 files changed, 1651 insertions(+), 967 deletions(-)
 create mode 100644 gitweb/Makefile
 create mode 100644 gitweb/cache.pm
 create mode 100644 gitweb/gitweb_defaults.perl

--------------1.6.5.2--
