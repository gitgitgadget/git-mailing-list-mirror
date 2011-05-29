From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv2 0/2] Starting work on man pages for gitweb and gitweb.conf (WIP)
Date: Sun, 29 May 2011 21:50:24 +0200
Message-ID: <1306698626-32402-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 21:51:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQm0z-0008TQ-I2
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 21:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab1E2Tuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 15:50:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42161 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab1E2Tuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 15:50:50 -0400
Received: by wwa36 with SMTP id 36so3320083wwa.1
        for <git@vger.kernel.org>; Sun, 29 May 2011 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=hr5qGL3o4qyzm9l8+CyujNhpox2OhiDLUgPb1kdgwfc=;
        b=tQZ9gsceDm6vTtzC5uIPHMpR1scrM4py+0pbDNFJFsVSyJ48wTD9uLGZxeok4Fc7W3
         GMx8iYEsMciJKwZrOSBKg3fc9moT/H7Jq4Ewe1Zi6h201Z/XRJUfGvhrkv9RrKbutIKG
         o9+ATj/CSrvFlgPWUx8E0sVkRpzOpa33+DoBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=f6dl6OLxecwfRfXWpJPD/BmDphaERndu3p3QmQAAFf+WA6O95I5tSvPVtMYol1Wklh
         rKV3nVg96tMQZ8HIZ53f5cG/WCUOtx2gp+4U6nvTIZeO8Mg04Nw7Admo6viIngawHfoN
         UB7tOLa1qO/4mSDUW5uCktwc/XvR9q9SIkwCg=
Received: by 10.216.82.6 with SMTP id n6mr1811831wee.27.1306698648828;
        Sun, 29 May 2011 12:50:48 -0700 (PDT)
Received: from localhost.localdomain (abvt40.neoplus.adsl.tpnet.pl [83.8.217.40])
        by mx.google.com with ESMTPS id d7sm2111077wek.21.2011.05.29.12.50.46
        (version=SSLv3 cipher=OTHER);
        Sun, 29 May 2011 12:50:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174700>

This is very much work in progress.  

1. The man page for /etc/gitweb.conf is modified, extended and
improved version of patch by Drew Northup from

  "[PATCH/WIP] Starting work on a man page for /etc/gitweb.conf"
  http://thread.gmane.org/gmane.comp.version-control.git/173422

Drew version was mostly pulled directly from the README and INSTALL
files of gitweb.  I have tried to incorporate comments in mentioned
thread, and to group config variables by category.

2. The man page for gitweb is slightly extended version of patch I
have sent to git mailing list as

  "[RFC/PATCH] gitweb: Starting work on a man page for gitweb (WIP)"
  http://thread.gmane.org/gmane.comp.version-control.git/173422/focus=173625


NOTE that I have only tested that both generated manpages _looks_
(halfway) reasonable.  I didn't check HTML output.

The major part that is left (besides extending both manpages with new
information) is actually de-duplicate contents, i.e. delete those
parts of gitweb/README and gitweb/INSTALL that were copied to those
new manpages.

Both of those are also available in 'gitweb/doc' branch in one of my
repositories:

  git://repo.or.cz/git/jnareb-git.git
  git://github.com/jnareb/git.git


Shortlog:
~~~~~~~~~
Drew Northup (1):
  Starting work on a man page for /etc/gitweb.conf (WIP)

Jakub Narebski (1):
  gitweb: Starting work on a man page for gitweb (WIP)

Diffstat:
~~~~~~~~~
 Documentation/Makefile        |    4 +-
 Documentation/gitweb.conf.txt |  436 +++++++++++++++++++++++++++++++++++++++++
 Documentation/gitweb.txt      |  334 +++++++++++++++++++++++++++++++
 git.spec.in                   |    3 +
 gitweb/Makefile               |   14 ++
 5 files changed, 789 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/gitweb.conf.txt
 create mode 100644 Documentation/gitweb.txt

-- 
1.7.5
