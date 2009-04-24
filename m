From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Unify use of [sha,SHA][,-]1
Date: Fri, 24 Apr 2009 16:49:33 +0200
Message-ID: <1240584575-5702-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 16:52:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMlU-0005Ku-Jr
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759717AbZDXOtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757797AbZDXOtp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:49:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44462 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759222AbZDXOtn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 10:49:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D8C00322885;
	Fri, 24 Apr 2009 10:49:42 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Apr 2009 10:49:42 -0400
X-Sasl-enc: m7g+rfi3rqXaiOH1t1MG80MhYtOuJWQdzzpPx4mXeQ5y 1240584582
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 10A9939131;
	Fri, 24 Apr 2009 10:49:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.51.gea0b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117447>

a6e5ef7 (user-manual: the name of the hash function is SHA-1, not sha1,
2009-04-04) made sure the user manual names the hash "SHA-1" only. This
series achieves the same for the rest of the documentation.

I split it into two parts for replacing "sha1" and "SHA1". The form
"sha-1" did not appear anywhere.

I went through each replacement manually: code samples etc. should not be
transformed. Each commit messsage lists the exceptions.

The diffstat may look a bit frightening but the patch can be reviewed
most easily with --color-words. I'd be happy to be split it up further
but didn't see any obvious splitting boundaries. (I would point to
http://repo.or.cz/w/git/mjg.git?h=refs/heads/doc-use-SHA-1 if gitweb
had commitdiff-colorwords.)

Cheers,
Michael

Suggested by: Ulrich Windl

Michael J Gruber (2):
  Documentation: replace sha1 by SHA-1
  Documentation: replace SHA1 by SHA-1

 Documentation/config.txt                           |    2 +-
 Documentation/diff-format.txt                      |    8 ++--
 Documentation/git-blame.txt                        |    4 +-
 Documentation/git-branch.txt                       |    8 ++--
 Documentation/git-cat-file.txt                     |   10 +++---
 Documentation/git-cherry.txt                       |    4 +-
 Documentation/git-cvsexportcommit.txt              |    4 +-
 Documentation/git-describe.txt                     |    2 +-
 Documentation/git-diff-index.txt                   |    8 ++--
 Documentation/git-filter-branch.txt                |    6 ++--
 Documentation/git-fsck.txt                         |   12 ++++----
 Documentation/git-index-pack.txt                   |    2 +-
 Documentation/git-init.txt                         |    2 +-
 Documentation/git-ls-files.txt                     |    2 +-
 Documentation/git-merge-index.txt                  |    2 +-
 Documentation/git-mktag.txt                        |    2 +-
 Documentation/git-name-rev.txt                     |    2 +-
 Documentation/git-pack-objects.txt                 |    2 +-
 Documentation/git-patch-id.txt                     |    2 +-
 Documentation/git-receive-pack.txt                 |   32 ++++++++++----------
 Documentation/git-reflog.txt                       |    4 +-
 Documentation/git-rev-parse.txt                    |    8 ++--
 Documentation/git-show-branch.txt                  |    4 +-
 Documentation/git-show-index.txt                   |    2 +-
 Documentation/git-show-ref.txt                     |    4 +-
 Documentation/git-svn.txt                          |    4 +-
 Documentation/git-tag.txt                          |    2 +-
 Documentation/git-unpack-file.txt                  |    2 +-
 Documentation/git-update-index.txt                 |   14 ++++----
 Documentation/git-update-ref.txt                   |    8 ++--
 Documentation/git-verify-pack.txt                  |    4 +-
 Documentation/git-verify-tag.txt                   |    2 +-
 Documentation/git.txt                              |   12 ++++----
 Documentation/gitcore-tutorial.txt                 |    8 ++--
 Documentation/gitdiffcore.txt                      |    2 +-
 Documentation/githooks.txt                         |    2 +-
 Documentation/gittutorial-2.txt                    |   16 +++++-----
 Documentation/glossary-content.txt                 |    8 ++--
 .../howto/recover-corrupted-blob-object.txt        |    6 ++--
 Documentation/howto/update-hook-example.txt        |    6 ++--
 Documentation/pretty-formats.txt                   |   16 +++++-----
 Documentation/technical/pack-format.txt            |   14 ++++----
 Documentation/technical/pack-protocol.txt          |   20 ++++++------
 Documentation/technical/shallow.txt                |    4 +-
 44 files changed, 144 insertions(+), 144 deletions(-)
