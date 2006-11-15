X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] gitweb: Put back shortlog instead of graphiclog in the project list.
Date: Wed, 15 Nov 2006 21:37:50 +0100
Message-ID: <87irhgla3l.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 20:38:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31488>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRW9-00027C-88 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030981AbWKOUhy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030983AbWKOUhy
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:37:54 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:43463 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1030981AbWKOUhx
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:37:53 -0500
Received: from adsl-89-217-150-95.adslplus.ch ([89.217.150.95]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GkRW4-0000Ht-BC for
 git@vger.kernel.org; Wed, 15 Nov 2006 14:37:52 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 38D8610A151; Wed,
 15 Nov 2006 21:37:50 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Looks like a repo.or.cz-specific change slipped in.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e54a29e..7587595 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2454,7 +2454,7 @@ sub git_project_list_body {
 		      $pr->{'age_string'} . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
-		      $cgi->a({-href => '/git-browser/by-commit.html?r='.$pr->{'path'}}, "graphiclog") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
-- 
1.4.4.g2e5b

-- 
Alexandre Julliard
