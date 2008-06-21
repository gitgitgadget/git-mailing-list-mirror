From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: "git-pull --no-commit" should imply --no-ff...?
Date: Sat, 21 Jun 2008 16:08:51 +0200 (CEST)
Message-ID: <tkrat.5aa5af8e9968819c@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 16:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA3mz-0001iY-3L
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 16:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbYFUOJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 10:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYFUOJE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 10:09:04 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50764 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbYFUOJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 10:09:03 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from stein ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m5LE8uej010751
	for <git@vger.kernel.org>; Sat, 21 Jun 2008 16:09:01 +0200
Content-Disposition: INLINE
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85709>

Hi list,

trying "git pull --no-commit . foo" for the first time, I was confused
that --no-commit was a no-op when the pull resulted in a fast-forward.
I.e. HEAD advanced the whole chain of commits to foo.  I expected it to
apply the diff of HEAD..foo but not commit them.

I then learned that "git pull --no-ff --no-commit . foo" does what I
wanted.  What good does it do to ignore --no-commit in the fast-forward
case unless --no-ff is given?

This is with git 1.5.4.5.
-- 
Stefan Richter
-=====-==--- -==- =-=-=
http://arcgraph.de/sr/
