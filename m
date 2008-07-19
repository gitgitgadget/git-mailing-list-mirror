From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sat, 19 Jul 2008 21:47:43 +0400
Message-ID: <20080719174742.GA4253@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 19:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGfr-0000m3-7o
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 19:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbYGSRzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 13:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbYGSRzv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 13:55:51 -0400
Received: from relay.2ka.mipt.ru ([194.85.80.65]:58257 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbYGSRzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 13:55:51 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jul 2008 13:55:50 EDT
Received: from 2ka.mipt.ru (localhost [127.0.0.1])
	by 2ka.mipt.ru (8.14.1/8.14.1) with ESMTP id m6JHljxs009360
	for <git@vger.kernel.org>; Sat, 19 Jul 2008 21:47:45 +0400
Received: (from johnpol@localhost)
	by 2ka.mipt.ru (8.14.1/8.12.1/Submit) id m6JHlhWE009344
	for git@vger.kernel.org; Sat, 19 Jul 2008 21:47:43 +0400
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89119>

Hi.

I'm getting above error each time I'm tying to clone current 2.6 tree.
Archives tell that it happens when local index is currupted, but I do
not have local tree, it is a fresh clone in an empty dir.

$ git clone http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Getting alternates list for http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting pack list for http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting index for pack 81cec7c6b26c755e466a79de8dbe1c7b827a48d6
error: non-monotonic index
/usr/bin/git-clone: line 33:  2025 Segmentation fault git-http-fetch -v -a -w "$tname" "$name" "$1/"

$ git --version
git version 1.4.4.4

Fresh 32bit Debian testing.

It worked before (at least several months ago) and works with 1.5.2.5.

-- 
	Evgeniy Polyakov
