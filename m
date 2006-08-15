From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 0/6] Configuration tweaks for Solaris
Date: Tue, 15 Aug 2006 11:00:31 +0200
Message-ID: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCuno-0001xX-74
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWHOJB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWHOJB3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:29 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:61887 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932741AbWHOJB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:27 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id A20F1AEBA002
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:19 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id 842F0121739
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:18 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25447>

Hello,

The current configure script fails to generate a working configuration
on Solaris for a number of different reasons.  With these patches on the
"next" branch "gmake clean configure && ./configure && gmake all test"
completes on Solaris 9 with Sun CC 5.8 without errors.

The second patch may be suitable for the "maint" branch as well. Without
it, at least t3800-mktag.sh fails.

Regards,
Dennis
