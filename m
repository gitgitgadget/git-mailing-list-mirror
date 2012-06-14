From: Luka Perkov <lists@lukaperkov.net>
Subject: [PATCH] git-http-fetch: remove unused cmd_http_fetch
Date: Thu, 14 Jun 2012 22:23:37 +0200
Message-ID: <20120614202336.GA3755@w500.iskon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 22:23:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfGZw-00070P-TJ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 22:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab2FNUXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 16:23:37 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48284 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab2FNUXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 16:23:36 -0400
Received: by wibhn6 with SMTP id hn6so2351815wib.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 13:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:x-gm-message-state;
        bh=rqJdRtVaEdFBm4LsWTTWe/FEqzPKYQAfbrnlw+mbJgY=;
        b=aGveEqh2MoOzcT8+mi4Mhbs9pRUbBt8QoVHm/TWoaXzCg4twiWN4FM71c2rvcTQ6Gp
         YAzuwycxqzm/gPGoalLK62t+o7EPVUHABE5h7oOa4U7OHoRQuzrv6f8wBnRFEbyzNbno
         6F0zZQjORKwdueSAIYuyTzQOWoOuqvuVG7HLtXuvlOvkqm72j0UMFkFQtLvq+fshFf7b
         FKEImlTLiu8CFWAOxY8x+X6bh2LLRG9RkBiv4Jui3HVMf9Q5dRHQ06aJXEhPdkfA0xT1
         mTt7vNkB5mT2Ytf0ARovboA3qanCxp/CnL3PNhOjZfN49L+657QwkzLkWFf2N3h4WUyZ
         ZOaA==
Received: by 10.180.106.137 with SMTP id gu9mr7065859wib.8.1339705415295;
        Thu, 14 Jun 2012 13:23:35 -0700 (PDT)
Received: from localhost (213-191-157-151.dhcp.iskon.hr. [213.191.157.151])
        by mx.google.com with ESMTPS id gb9sm20711478wib.8.2012.06.14.13.23.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 13:23:34 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlw8ZxxdZWB6KFhGB3AC8OL+LMuQQ0tdLFHtYCbArGhSTh9qrNysEBpPndbmBe/Um/d9S2G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200030>

It was left out from commit 1088261f6fc90324014b5306cca4171987da85ce

Signed-off-by: Luka Perkov <lists@lukaperkov.net>
---

 builtin.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 338f540..f5b8ed1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -83,7 +83,6 @@ extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
-extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
