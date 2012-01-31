From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Project search improvements
Date: Tue, 31 Jan 2012 01:20:53 +0100
Message-ID: <1327969255-26622-1-git-send-email-jnareb@gmail.com>
Cc: "Bernhard R. Link" <brl+git@mail.brlink.eu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 01:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs1Sc-0005gv-R4
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 01:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158Ab2AaAU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 19:20:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45207 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab2AaAUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 19:20:24 -0500
Received: by eekc14 with SMTP id c14so1620952eek.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RsqSJvU0o7vi4ZFVYCoevm36ggtoHxCi6AXkeANAE1s=;
        b=AjNxLW5aSmEmg8yj/JtKQxnl1+kPfNTGDgboKOzHelzqwuga6FrQTtJY8ctgeI4vHT
         mG03T2FqtEVAroPVBSL/XmjsjJfNfMzdbvt+RrbV9NZQ0Zh/T6mzTap/GyTeHXCCQeI+
         QDyiqea4Ac0sPfuVbumtIjDAk7LxAaqEaUiP4=
Received: by 10.14.15.155 with SMTP id f27mr283782eef.117.1327969222931;
        Mon, 30 Jan 2012 16:20:22 -0800 (PST)
Received: from localhost.localdomain (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id b3sm28106899een.2.2012.01.30.16.20.21
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 16:20:22 -0800 (PST)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189437>

This was once a part of larger series improving project search in
gitweb, but those two patches can stand alone.  I am sending this
series (especially the second patch) in response to Bernhard patches
adding support for project_filter.

These patches should be applied on top of his work, i.e. on top of
'bl/gitweb-project-filter' branch.

Jakub Narebski (2):
  gitweb: Improve projects search form
  gitweb: Make project search respect project_filter

 gitweb/gitweb.perl       |   35 ++++++++++++++++++++++++++++++-----
 gitweb/static/gitweb.css |    7 ++++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

-- 
1.7.6
