From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] pull: add --ff-only to the help text
Date: Wed, 15 Jan 2014 15:18:39 -0800
Message-ID: <1389827919-13608-2-git-send-email-davvid@gmail.com>
References: <1389827919-13608-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 00:18:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Zje-0007nf-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 00:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbaAOXSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:18:48 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53553 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbaAOXSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 18:18:40 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so255153pab.7
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 15:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJ9iG7H4G5n9vVvfXJuBDsJQmaAaQGLhiMAgXV27iWA=;
        b=rdlsokzbxVRyGXZNpfD+cLLPuU+zgMI4iXA1KexxT7dgaiBdm9E7VQzgGwvGMwjnr+
         kFArUDe6C98OWSScmVqwrTtNMim9JOfLwANbcFHIIujhDWPnlwtTr1Y29q4IgnmT0UnU
         bqvcBcE6wDPJnAXIUrkBHJ5WkHCcWp4388qM6uQA5pd46cv5vqQn6QkV91dNur6fWRG+
         vJ2oBytLxXE7VHhOInQJeNPJdQwzRwsZvOEdGLqqrwtxkrCMwvJt0k3rnb38I8h02t/O
         Y8GNNKEIX/UlqWFLnH3S0Olq64Po6n16lCEjW2WWkHjXdpHRfEinKizQY3Y31mR/6JBA
         OR9w==
X-Received: by 10.68.131.202 with SMTP id oo10mr5859334pbb.35.1389827919682;
        Wed, 15 Jan 2014 15:18:39 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id qw8sm10537189pbb.27.2014.01.15.15.18.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 15:18:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1389827919-13608-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240489>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 7dbf6b1..68b2e40 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-- 
1.8.5.3.322.g71d2a99
