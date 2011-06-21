From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (amend)] gitweb: 'pickaxe' and 'grep' features requires
	'search' to be enabled
Date: Tue, 21 Jun 2011 08:41:16 +0200
Message-ID: <20110621064037.17169.36375.stgit@localhost.localdomain>
References: <20110620213904.11650.60345.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 08:42:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYuex-0001F5-4D
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 08:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab1FUGlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 02:41:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32843 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab1FUGls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 02:41:48 -0400
Received: by fxm17 with SMTP id 17so1443161fxm.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=o6lxnZP4ebOCsFH/00nL0gQb0arNhL5dBS25KJ6fruY=;
        b=c14yN6QmEoV5YErJQkYeDpengxMzxI0xbaelvsuEpZgWmqNiPzfuuofoZl7wL7Iyws
         72i/qRlJoqE8lEB4h/KenFF2qgKzGthRwVNZqwCF06gnl3Yv+KO+Wn9g0ZqwORjhxqX/
         q4ILKfAaGuDeM5lr/tEkC3AQrT0qyJNBGpJsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-type:content-transfer-encoding;
        b=btKrMoatnvxd0ciBjmZt0aldfmK0/OMZjdoIUgVlT4U2sMvBv3gvQAWeHjF5DS3EFd
         lXpg31BwP3tyAv9JKEocIqZONjqJ87N4J4rEfXJCPCxRe7ciZGiJ1VccmpWXo8/67iop
         EZ6hpqvsMlm/6iKCZjmLUp6WTSUCoU24DpA30=
Received: by 10.223.77.92 with SMTP id f28mr2175130fak.37.1308638507130;
        Mon, 20 Jun 2011 23:41:47 -0700 (PDT)
Received: from localhost.localdomain (abwr138.neoplus.adsl.tpnet.pl [83.8.241.138])
        by mx.google.com with ESMTPS id m26sm3185558fab.34.2011.06.20.23.41.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 23:41:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5L6fGUV017206;
	Tue, 21 Jun 2011 08:41:27 +0200
In-Reply-To: <20110620213904.11650.60345.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176127>

Both 'pickaxe' (searching changes) and 'grep' (searching files)
require basic 'search' feature to be enabled to work.  Enabling
e.g. only 'pickaxe' won't work.

Add a comment about this.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm sorry, I forgot that this issue applies to 'grep' feature too.

 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c9e6426..63af8d4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -328,6 +328,7 @@ our %feature = (
 	# Enable grep search, which will list the files in currently selected
 	# tree containing the given string. Enabled by default. This can be
 	# potentially CPU-intensive, of course.
+	# Note that you need to have 'search' feature enabled too.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'grep'}{'default'} = [1];
@@ -342,6 +343,7 @@ our %feature = (
 	# Enable the pickaxe search, which will list the commits that modified
 	# a given string in a file. This can be practical and quite faster
 	# alternative to 'blame', but still potentially CPU-intensive.
+	# Note that you need to have 'search' feature enabled too.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'pickaxe'}{'default'} = [1];
