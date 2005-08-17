From: Kris Shannon <kris.shannon@gmail.com>
Subject: [PATCH] Be consistent in naming of remote heads
Date: Wed, 17 Aug 2005 13:02:16 +1000
Message-ID: <bf38a9f050816200274e28f31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Aug 17 05:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ECs-0003O0-7U
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 05:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVHQDCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 23:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVHQDCV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 23:02:21 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:31528 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750803AbVHQDCU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 23:02:20 -0400
Received: by wproxy.gmail.com with SMTP id i2so76829wra
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 20:02:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F60Y5Wj+gPZHO31oCGI9cePaXo4us0Rrw8OhytVdApn17nkWC9zhF3pLIJV3wNeSdb/HkoHljLW3QCzXEgRY03A1kjlimP+Fjq12PxHML6cNDthdsOxO6WrBLsfAQjezdgSw+0PTEBGnG6rSysPYrJ7P7luRQeKO/stzjo48Lbg=
Received: by 10.54.81.2 with SMTP id e2mr142030wrb;
        Tue, 16 Aug 2005 20:02:16 -0700 (PDT)
Received: by 10.54.28.72 with HTTP; Tue, 16 Aug 2005 20:02:16 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The _remote_name variable used for messages does not need the
refs/heads/ prefix included.

Signed-off-by: Kris Shannon <kris.shannon@gmail.com>
---

 git-parse-remote |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9e7a4358b1792be188df87debf564e46acdb39d4
diff --git a/git-parse-remote b/git-parse-remote
--- a/git-parse-remote
+++ b/git-parse-remote
@@ -71,8 +71,8 @@ tag)
 	'')
 		_remote_head=HEAD ;;
 	*)
-		_remote_head="refs/heads/$_remote_head"
 		_remote_name="head '$_remote_head' of $_remote_name"
+		_remote_head="refs/heads/$_remote_head"
 		;;
 	esac
 	;;
