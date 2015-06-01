From: Brett Randall <javabrett@gmail.com>
Subject: [PATCH] Doc, git-svn, added mention of config key: svn-remote.<name>.include-paths
Date: Mon, 1 Jun 2015 14:54:08 +1000
Message-ID: <CALeEUB7Rf7YkDoUXvVzrsC=75+m1TKc=XKp6JTYqvHTVreaNGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 06:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzHjr-0001Yy-0h
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 06:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbbFAEyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 00:54:10 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36192 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbFAEyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 00:54:09 -0400
Received: by obbea2 with SMTP id ea2so95084412obb.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=y6qo5Bd3VE5sEzTY6Gb497dskt3yQWhmid2r8MLLxjI=;
        b=Og0jmKW9a5A9DzduVRd1pfKRPfvzaxKxsRC22/5JrGEZ8d+VyWLrlsUM/gj2e2gLjE
         1FUNQLRH9+jFOCToALrBahzjd/GiL76d4Iz7fETqlR0jAEwVNS6vzj+ntLlSpcgUQwyh
         yFi30FWpO5DVPUJ66AXehu0FXaaPVa/bvMW3Q8qPip18TYjnmHtLU2OEwEWyqwvY46so
         FDloTiSadiWrW+2GRRHNRbT64e/FQ04Udin/EIXvFWEgcUt1etevzD3gm6vYYb8gzWeY
         k99ddZcHPg2j3Gv2dJAVrs19isKi0jwo2U4oV+u2mF/E69W190waufsPfT0uIAhA/GKM
         M7uQ==
X-Received: by 10.182.115.161 with SMTP id jp1mr16789628obb.53.1433134448394;
 Sun, 31 May 2015 21:54:08 -0700 (PDT)
Received: by 10.202.218.135 with HTTP; Sun, 31 May 2015 21:54:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270375>

Signed-off-by: Brett Randall <javabrett@gmail.com>
---
 Documentation/git-svn.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 11d1e2f..0c0f60b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -174,6 +174,9 @@ Skip "branches" and "tags" of first level directories;;
        (including automatic fetches due to 'clone', 'dcommit',
        'rebase', etc) on a given repository. '--ignore-paths' takes
        precedence over '--include-paths'.
++
+[verse]
+config key: svn-remote.<name>.include-paths

 --log-window-size=<n>;;
        Fetch <n> log entries per request when scanning Subversion history.
-- 
2.3.5
