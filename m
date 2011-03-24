From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 0/1] Gitweb: Change timezone
Date: Wed, 23 Mar 2011 17:08:54 -0700
Message-ID: <1300925335-3212-1-git-send-email-warthog9@eaglescrag.net>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
Cc: jnareb@gmail.com, cernekee@gmail.com, gitster@pobox.com,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 01:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Y7h-0007hF-Lm
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 01:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370Ab1CXAJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 20:09:52 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:49563 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023Ab1CXAJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 20:09:52 -0400
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p2O09DCq028588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Mar 2011 17:09:17 -0700
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 23 Mar 2011 17:09:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169881>

This is just a javascript implementation of Kevin's localtime
feature.  It's pretty straight forward, though date handling in
Javascript is, special (head bangingly so).

This should be good to run on any browser, with the safe fallback
of UTC being the default output should Javascript not work / be
available.

John 'Warthog9' Hawley (1):
  gitweb: javascript ability to adjust time based on timezone

 gitweb/gitweb.perl              |   64 +++++++++++++++-
 gitweb/static/js/common-defs.js |   12 +++
 gitweb/static/js/common-lib.js  |   32 ++++++++
 gitweb/static/js/cookies.js     |   35 +++++++++
 gitweb/static/js/date.js        |  160 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 300 insertions(+), 3 deletions(-)
 create mode 100644 gitweb/static/js/common-defs.js
 create mode 100644 gitweb/static/js/common-lib.js
 create mode 100644 gitweb/static/js/cookies.js
 create mode 100644 gitweb/static/js/date.js

-- 
1.7.2.3
