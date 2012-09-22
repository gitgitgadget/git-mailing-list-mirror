From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH 0/2] gitk: Better highlighting of search results
Date: Sat, 22 Sep 2012 09:40:23 +0200
Message-ID: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 09:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFKKz-0008Bh-PQ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 09:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab2IVHkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 03:40:49 -0400
Received: from server90.greatnet.de ([83.133.96.186]:55590 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab2IVHkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 03:40:47 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id 174363B0E8E;
	Sat, 22 Sep 2012 09:40:45 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.1.399.gae20e0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206197>

Here's something that has been bugging me for a long time: when using
the incremental search feature, it's hard to tell what happens when
clicking the Search button (or type Ctrl-S) repeatedly. It does have
the concept of a "current" search hit, and Ctrl-S advances to the next
one; however, you can't see it because all search hits are highlighted
in the same way (yellow). So when there are multiple hits visible on
the current page, it will at some point scroll down to reveal more
hits, but it's impossible to predict when this will happen.

To improve this, we highlight the current search in orange and the
other ones in yellow (like Chrome does it when you search on a Web
page).

Needs to go on top of the recent "Synchronize highlighting in file view
when scrolling diff" patch, v3.

[PATCH 1/2] gitk: Highlight current search hit in orange
[PATCH 2/2] gitk: Highlight first search result immediately on incremental search
