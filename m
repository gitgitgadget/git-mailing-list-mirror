From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: git-format-patch --subject-prefix support.
Date: Wed, 11 Apr 2007 16:58:06 -0700
Message-ID: <11763358884124-git-send-email-robbat2@gentoo.org>
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 01:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmhi-0007j8-Ot
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161358AbXDKX6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbXDKX6P
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:58:15 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40847 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932212AbXDKX6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:58:12 -0400
Received: (qmail 26184 invoked from network); 11 Apr 2007 23:58:10 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 11 Apr 2007 23:58:10 +0000
Received: (qmail 15420 invoked from network); 11 Apr 2007 16:58:35 -0700
Received: from buck-int.local.orbis-terrarum.net (HELO buck-int.orbis-terrarum.net) (172.16.9.3)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 11 Apr 2007 16:58:35 -0700
Received: (nullmailer pid 26907 invoked by uid 0);
	Wed, 11 Apr 2007 23:58:08 -0000
X-Mailer: git-send-email 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44281>

Add a new option to git-format-patch, entitled --subject-prefix that allows
control of the subject prefix '[PATCH]'. Using this option, the text 'PATCH' is
replaced with whatever input is provided to the option. This allows easily
generating patches like '[PATCH 2.6.21-rc3]' or properly numbered series like
'[-mm3 PATCH N/M]'.

1/2 - Implementation and documentation
2/2 - Test case
