From: linux@horizon.com
Subject: Re: git pull on Linux/ACPI release tree
Date: 9 Jan 2006 00:55:42 -0500
Message-ID: <20060109055542.20320.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 06:55:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evq0W-0004iy-V5
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 06:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWAIFzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 00:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWAIFzu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 00:55:50 -0500
Received: from science.horizon.com ([192.35.100.1]:26419 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932441AbWAIFzt
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 00:55:49 -0500
Received: (qmail 20321 invoked by uid 1000); 9 Jan 2006 00:55:42 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14352>

> And lastly, is there a tool whereby I can "see" changes
> between repos, kind of like git-diff but being able to
> give URLs too?

Write it yourself.  It's git-fetch + git-diff.

Or, put another way, if you think you need a special tool for working
with a remote repository, you don't understand git-fetch.

Since git history is immutable, there is no difference between a remote
copy and a local copy.  And since fetching is harmless to your local
repository, there's no problem.

If you don't want to copy the entire history, just fetch the tree rather
than the commit.  (Does git-fetch do that?  It's a subset of its current
effects, so would be an easy enough extension.)
