From: "Lalit Chhabra" <lchhabra@linuxmail.org>
Subject: git-svn: memoize cmt_metadata
Date: Wed, 05 Sep 2012 14:25:51 -0400
Message-ID: <20120905182552.11530@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 20:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9KIl-0006t4-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 20:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab2IESZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 14:25:55 -0400
Received: from mailout-us.gmx.com ([74.208.5.67]:37061 "HELO
	mailout-us.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754323Ab2IESZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 14:25:55 -0400
Received: (qmail 6457 invoked by uid 0); 5 Sep 2012 18:25:54 -0000
Received: from 138.239.40.120 by rms-us016 with HTTP
X-Authenticated: #77116587
X-Flags: 0001
X-Mailer: GMX.com Web Mailer
x-registered: 0
X-GMX-UID: Z/w1cOVl3zOl2srX83Ah7zR+IGRvb0CF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204837>

Hi,

 I have about 150 "branches = ..." and "tags = ..." lines in my
 .git/config file, and I see a 30x improvement in 'git svn rebase -l'
 when I memoize the cmt_metadata function. (The run time goes
 down from ~150 seconds to ~5 seconds on my machine).

 I see that it was memoized in version:
 * c1927a8 2006-06-27 | git-svn: several graft-branches improvements

 and then removed in version:
 * 396988e 2007-01-13 | git-svn: get rid of Memoize for now...

 Is it safe to re-memoize this function?

 Thanks,
 Lalit Chhabra
