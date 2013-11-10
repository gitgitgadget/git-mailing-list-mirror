From: Ari Pollak <ari@debian.org>
Subject: Bug? diff.submodule=log adds text to commit -v message
Date: Sun, 10 Nov 2013 21:49:20 +0000 (UTC)
Message-ID: <loom.20131110T222043-57@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 01:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VffA9-0000HC-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 01:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab3KKAPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 19:15:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:58159 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab3KKAPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 19:15:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vff9k-00084a-3L
	for git@vger.kernel.org; Mon, 11 Nov 2013 01:15:04 +0100
Received: from c-71-235-71-232.hsd1.ct.comcast.net ([71.235.71.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 01:15:04 +0100
Received: from ari by c-71-235-71-232.hsd1.ct.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 01:15:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.235.71.232 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237594>

Hi,

I'm using git 1.8.4.2, and I've set the "diff.submodule = log" option 
globally. If I change the revision that a submodule is set to, then run
"git commit -av", The submodule shortlog is appended to the log message without 
any #s before it, so the log messages get included in my own log message. 
This seems like a bug and not a feature, as diffs aren't normally included in 
the commit message with -v.

Cheers,
Ari
