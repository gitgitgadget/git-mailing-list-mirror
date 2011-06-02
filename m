From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] Improving gitweb documentation
Date: Thu,  2 Jun 2011 16:55:51 +0200
Message-ID: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 16:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS9Jv-0001Pa-Q2
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 16:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab1FBO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 10:56:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54507 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab1FBO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 10:56:18 -0400
Received: by fxm17 with SMTP id 17so748737fxm.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=4laKknNQKgtOhjjAUv585hKpcMsCb6GhwHk5hUvGBbY=;
        b=MemJB1pbaSwzeZDQmV/dY5s4+bolRoY5GxVYyd1og4MGWEtl9NthZiiIjN9rL6ZQDZ
         ze9nwW7HoL/No4FZXYzkUHstEkhlA5akBLCK5z/+8lAGlXEE6RIGIbqQkN0I8C12491r
         4tBE6yoCv+HrXkwAzgDN2cTAomcnHVI6Hip+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JYmGmNxHVPuE9qHoFc7QmZlEZiAD6O3xZrFXiIw/xLsUbmcDdflnpV9vrGh3qj7WFk
         inB7trGRfR0N/WRfg7RukWxwmobWC7kp2gFENaYvi5z1cQ7nX6rR7TCJz2fqYl/4QdDV
         8OPrVsBLqx9dPBbgFV1i5X5lNIbJjdoX6yA6Q=
Received: by 10.223.98.141 with SMTP id q13mr912739fan.96.1307026577431;
        Thu, 02 Jun 2011 07:56:17 -0700 (PDT)
Received: from localhost.localdomain (abvc230.neoplus.adsl.tpnet.pl [83.8.200.230])
        by mx.google.com with ESMTPS id c1sm204029faa.37.2011.06.02.07.56.14
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 07:56:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174954>

This is fall off from my work on adding continuing Drew Northup work
of adding gitweb.conf(5) and gitweb(1) manpages (the latter my
addition).

I see that I missed feature freeze... and this is not strictly bugfix.
Oh, well,...

Jakub Narebski (2):
  gitweb: Move information about installation from README to INSTALL
  gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL

 gitweb/INSTALL |  122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 gitweb/README  |  114 ----------------------------------------------------
 2 files changed, 120 insertions(+), 116 deletions(-)

-- 
1.7.5
