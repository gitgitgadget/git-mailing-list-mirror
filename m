From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 0/4] gitweb: remote heads feature
Date: Sun, 16 Nov 2008 14:28:05 +0100
Message-ID: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 14:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1hh7-00027T-3Q
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 14:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbYKPN17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 08:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYKPN16
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 08:27:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57037 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYKPN16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 08:27:58 -0500
Received: by ug-out-1314.google.com with SMTP id 39so219624ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jYqSWxt1uUJtrEc+mDVKydRk0QXQA3qPY7egnOArDvY=;
        b=lvFzoeb1S6HJ59ujCvNMgbirAnv+59UPtSyR7R5EAk8lglNGrqvOGmKCZpvzr1PMBE
         ElstGCe+gCSWKHraqramwdfvdLyXSZHUCVgMMj2lwcgH7+ibLVOwUJr1OskHOicF6oT0
         kY3bNaxCsVI9+RvM8ufK8IqtUIkJw0udxUWNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hR9mRYTAgDCV964l1kKpStBlufNOjcQHRnrkkgzhcC9HLVKlcgF6eCfLXUg5BzwtBr
         Gs8M4MQcDLRSVr6l+L+c2JmMwKGVMqezE5Wbh+XllJqzgD5M++Op6SuP/MasqAm0MVCX
         sAMlUWhYnLEV8jISmY6JD0N/XNIASGLnHb814=
Received: by 10.67.27.3 with SMTP id e3mr833481ugj.85.1226842076383;
        Sun, 16 Nov 2008 05:27:56 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id u1sm2515214uge.8.2008.11.16.05.27.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 05:27:55 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101125>

A new version of the remote heads feature patchset. This is considerably
stripped down in comparison to the previous version, as it's limited to
implementing the remote_heads feature and the minimal amount of UI changes to
accomodate it cleanly. Other features such as grouping of heads and supporting
detached HEAD will be implemented separately.

*NOTE*: this patchset is based on my previous

"gitweb: fixes to gitweb feature check code"

patch http://article.gmane.org/gmane.comp.version-control.git/101070

Giuseppe Bilotta (4):
  gitweb: introduce remote_heads feature
  gitweb: git_get_heads_list accepts an optional list of refs.
  gitweb: separate heads and remotes lists
  gitweb: link heads and remotes view

 gitweb/gitweb.perl |   74 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 68 insertions(+), 6 deletions(-)
