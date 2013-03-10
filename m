From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 17/23] contrib/subtree: Document from-submodule and prune commands
Date: Sun, 10 Mar 2013 23:41:25 +0000
Message-ID: <1362958891-26941-18-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpw2-00053X-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab3CJXpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:14 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48411 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:13 -0400
Received: by mail-wg0-f42.google.com with SMTP id 12so1515046wgh.5
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=Xnx7brbvuIOzCHQYiLZhlmAvXJZcREvNuJCGp7bWKD8=;
        b=Qw4Zl2oOJGCHgeyVzl8XcPhIkFsqqAKryD3VE9Uqc8eJW43f0PwOcriHPWxaenCYHQ
         IYU9F4+dWBHt+c1nER2B2Ne9v2dLIcbSQxsl1j+yz1Wt7aOHQ1Jbmm6oqfsLih5BSN6o
         sYGqFEoDG2RMSis8gQ9t2Dt4FzSOoN+UKucmbWzngx4nk0DWQ1zvKSUQzEsjz0r53XAa
         4edp3xPjoRpCG12H4BsEQFtP9oFNEWtsd/NnWJ9jlDJw+WF54XxdbNQe7XWvc1pFH0he
         pgSljbixvgYZQHmu3+O+am/7wtbYLOMT31eaf0CByhN7KWCyXNcFn0ZJsULADmoPjS9E
         Vitw==
X-Received: by 10.180.103.65 with SMTP id fu1mr9225506wib.4.1362959112187;
        Sun, 10 Mar 2013 16:45:12 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQlE179L5peLXOqUhDPBZNCd1q5ju+HgWQzUljDkZjKnod0nE/OBIkONIErpP8xkshSXCezI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217837>

From: Herman van Rink <rink@initfour.nl>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c8fc103..48ba158 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -129,6 +129,16 @@ split::
 	Note that if you use '--squash' when you merge, you
 	should usually not just '--rejoin' when you split.
 
+from-submodule::
+	Convert a git submodule to a subtree.
+	The module is removed from the .gitmodules file and
+	the repo contents are integrated as a subtree.
+
+prune::
+	Cleanup .gittrees entries for which the subtree nolonger exists.
+
+diff::
+	TO BE DOCUMENTED
 
 OPTIONS
 -------
-- 
1.8.2.rc1
