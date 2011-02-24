From: Marco <netuse@lavabit.com>
Subject: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 11:22:46 +0100
Message-ID: <20110224112246.3f811ac2@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 11:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYcI-00045X-Og
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 11:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab1BXKkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 05:40:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:50084 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab1BXKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 05:40:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PsYc9-00041Q-7g
	for git@vger.kernel.org; Thu, 24 Feb 2011 11:40:05 +0100
Received: from miun108-177.dynamic.miun.se ([193.10.108.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 11:40:05 +0100
Received: from netuse by miun108-177.dynamic.miun.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 11:40:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: miun108-177.dynamic.miun.se
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167796>

Hi,

I'm new to git and a bit confused about how some commands work.

git add .                    -- Adds everything *but* deleted files
git add -A                   -- Adds everything
git commit -a -m "whatever"  -- Commits everything *but* new files

I don't understand why there's not switch (is there?) for commit to commit new
and deleted files, like -A for git add? Is the only thing to do this sth like

git add -A && git commit -m "Message"


Marco
