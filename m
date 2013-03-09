From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 12/19] Remove trailing slash from prefix parameter
Date: Sat, 9 Mar 2013 19:27:58 +0000
Message-ID: <CALeLG_mbpS_iJzP=ev8_cN_11mcTQnC3GTO3_z5Fjk+3WgnvJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPRT-0003D1-D6
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259Ab3CIT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:28:00 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:53912 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CIT2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:28:00 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so2245254obc.18
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=LZ+5hPgKjIPCGkg/nO0YBYYPUbUXMmjR3uXfG2IFfX4=;
        b=SETELbr1DH+tm1HMNDAAle2EtL8D1HcKUJxuZ4ZbBWDDHpSvRQESVO9S1t2d1fxtvx
         F91asC77so+iyq2eK7kfDU5lntOzi1CrHBUbJl6x/qAqg3DWuxL456M5zSSzjkdEVEjJ
         7Q4ZMGzlVkidi3EI3qsT+NTqviXMpKnNBiQO4Jy6qQbfd2r5yovs92aLz3BwqrTM4ZPw
         LJ0CjZoUcwRNVVSi6SGrs766Tzink5Zft/JeL80VPnxDHoiQbz60mFptgxmJJFZPeRxl
         3R35s2Fnf4kgZOKyjBURcTZaUn47qBXuCVH0T6SVrufZ7Rk2C7iXkgvWPwvAdaDbZiBe
         fUDA==
X-Received: by 10.182.161.39 with SMTP id xp7mr5191039obb.71.1362857278848;
 Sat, 09 Mar 2013 11:27:58 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:27:58 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQnwuFaN26CeoZeEzriiUDFf9TviCkr8RCHvmDqSWcMliRttETdOI88AHuJ6kacU9suykg8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217749>

>From d4aa87f53b61481d2f916415f0baec527a8b6417 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:34:10 +0000
Subject: [PATCH 12/19] Remove trailing slash from prefix parameter

Conflicts:
	git-subtree.sh

Original-Author: Herman van Rink <rink@initfour.nl>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d67fe5a..ae7d1fe 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -103,6 +103,9 @@ while [ $# -gt 0 ]; do
 	esac
 done

+# Remove trailing slash
+prefix="${prefix%/}";
+
 command="$1"
 shift
 case "$command" in
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
