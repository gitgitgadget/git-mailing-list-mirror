From: Johan Herland <johan@herland.net>
Subject: [PATCH] git-svn.txt: Retain a description og pre-v2.0 default prefix
Date: Sat, 19 Apr 2014 11:10:31 +0200
Message-ID: <1397898631-1585-1-git-send-email-johan@herland.net>
References: <20140419083210.GA28771@dcvr.yhbt.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tfnico@gmail.com, Johan Herland <johan@herland.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 11:10:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbRIP-0005HU-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 11:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbaDSJKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 05:10:45 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:58102 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaDSJKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 05:10:43 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so1971069lab.34
        for <git@vger.kernel.org>; Sat, 19 Apr 2014 02:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/s+8AT22MrUAKyZYb7pQCrjV3jfqgZbe1Oo31ZgdT4=;
        b=U9MdDQDtNT3yMM/HbJfJfzHU0xSZExEZOeWEHGgHv8xXUsMqXBTjRcW9v/K9g+oFPR
         jipksq7dqArTRKgvYD5+MdRhPgOwuO2N+Friday8S/qPVGt96xO6Wq0nkW6oG4MfMvtJ
         pCSdVJcfzgRGmrtBm27wPIYnSBvTfPxoUX90ETLh0I84bgHZsbz2wI7Py6CM2LxBnypn
         pmImMVPVzmqiID12EXhgdtdyrUSzjB2P9RsRVU1FxjTU7ZI0tjQvo3xFrECKhi1WDgEP
         VPxIjYkPq5OysJUA2B4DWjhRc0Rp6MJMq8ujOEoBbjM0n5bZczfhHoj/1EEtkzHomOoo
         V68Q==
X-Received: by 10.152.2.225 with SMTP id 1mr815869lax.37.1397898641332;
        Sat, 19 Apr 2014 02:10:41 -0700 (PDT)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id jh4sm30181172lbb.26.2014.04.19.02.10.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Apr 2014 02:10:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.587.g6ba9303
In-Reply-To: <20140419083210.GA28771@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246511>

Add a description of <=1.9 behavior in the manpage. Users on
long-term-support systems are likely to continue using ancient
git installations for some time (5-10 years, even?), but may
come across the current documentation online.

Suggested-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Johan Herland <johan@herland.net>
---

> We should maintain a description of <=1.9 behavior in the manpage.
> Users on long-term-support systems are likely to continue using ancient
> git installations for some time (5-10 years, even?), but may come across
> the current documentation online.

Feel free to add/squash this on top.

> Otherwise the patch looks fine and I can push it up for Junio for
> 2.0-rc1.

Thanks!

...Johan

 Documentation/git-svn.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3a7dd80..5b3c38d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -87,6 +87,11 @@ COMMANDS
 	if you wish to track multiple projects that share a common
 	repository.
 	By default, the prefix is set to 'origin/'.
++
+NOTE: Before Git v2.0, the default prefix was "" (no prefix). This
+meant that SVN-tracking refs were put at "refs/remotes/*", which is
+incompatible with how Git's own remote-tracking refs are organized.
+
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
-- 
1.9.1.587.g6ba9303
