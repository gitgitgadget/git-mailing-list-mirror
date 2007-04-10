From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: Envelope sender patches for git-send-email
Date: Tue, 10 Apr 2007 15:00:31 -0700
Message-ID: <11762424311160-git-send-email-robbat2@gentoo.org>
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 04:40:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOOw-00028m-Ug
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXDJWAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbXDJWAh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:00:37 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40864 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753931AbXDJWAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:00:35 -0400
Received: (qmail 7905 invoked from network); 10 Apr 2007 22:00:34 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 22:00:33 +0000
Received: (qmail 22847 invoked from network); 10 Apr 2007 15:00:59 -0700
Received: from buck-int.local.orbis-terrarum.net (HELO buck-int.orbis-terrarum.net) (172.16.9.3)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 10 Apr 2007 15:00:59 -0700
Received: (nullmailer pid 25759 invoked by uid 0);
	Tue, 10 Apr 2007 22:00:31 -0000
X-Mailer: git-send-email 1.5.1
In-Reply-To: 20070410211040.GC18541@curie-int.orbis-terrarum.net
References: 20070410211040.GC18541@curie-int.orbis-terrarum.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44166>

This patch set is both a testcase, and a useful addition. Some mailing lists
(git@vger included) use the envelope sender to determine is posts are allowed,
and depending how use git-send-email, the envelope sender might not be the
address that you are subscribed with!
