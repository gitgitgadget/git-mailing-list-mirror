X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: [ANNOUNCE] gitfs pre-release 0.04
Date: Mon, 4 Dec 2006 11:40:11 -0800
Message-ID: <20061204194011.GW47959@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 19:22:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 04 Dec 2006 11:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33223>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJOF-0005cc-Db for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756325AbWLDTWI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759013AbWLDTWI
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:22:08 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:51917 "EHLO gaz.sfgoth.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1756325AbWLDTWF
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:22:05 -0500
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1]) by
 gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id kB4JeCtV099396 for
 <git@vger.kernel.org>; Mon, 4 Dec 2006 11:40:12 -0800 (PST) (envelope-from
 mitch@gaz.sfgoth.com)
Received: (from mitch@localhost) by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id
 kB4JeBBo099395 for git@vger.kernel.org; Mon, 4 Dec 2006 11:40:11 -0800 (PST)
 (envelope-from mitch)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've uploaded another pre-release of my gitfs tool.  I haven't had much time
to work on it lately, so not much has changed since the last release a
year ago:
	http://www.gelato.unsw.edu.au/archives/git/0511/12617.html

However that version no longer works (or even compiles against :-) the
FUSE API in recent linux kernels so I figured a fresh tarball would
be nice.

Changes:
  * Added a configuration subsystem.  Isn't used for much yet

  * At the top of each tree there's now a synthetic ".git" directory
    which includes some symlinks and a "HEAD" file that points to
    the currently viewed root.  The idea is to allow some simple git
    commands to work inside of a gitfs directory.  Unfortunately this doesn't
    work yet since git no longer recognizes a non-symbolic ref in "HEAD".
    I'll try to work around this soon.

  * Various bug-fixes, etc

As usual tarballs are available at:
	http://www.sfgoth.com/~mitch/linux/gitfs/
Sorry, I still haven't set up a git repository for it yet.

