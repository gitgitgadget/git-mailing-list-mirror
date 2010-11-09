From: Patrick Rouleau <pfrouleau@gmail.com>
Subject: Re: Git as a backup system?
Date: Tue, 9 Nov 2010 00:17:37 +0000 (UTC)
Message-ID: <loom.20101109T010709-599@post.gmane.org>
References: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 01:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFbuN-0000Em-Ku
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 01:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab0KIARu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 19:17:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:54488 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab0KIARt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 19:17:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PFbuF-0000CE-S1
	for git@vger.kernel.org; Tue, 09 Nov 2010 01:17:48 +0100
Received: from modemcable243.80-176-173.mc.videotron.ca ([173.176.80.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 01:17:47 +0100
Received: from pfrouleau by modemcable243.80-176-173.mc.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 01:17:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.176.80.243 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.7 (KHTML, like Gecko) Chrome/7.0.517.44 Safari/534.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161006>

Eric Frederich <eric.frederich <at> gmail.com> writes:

> Are any of you using git for a backup system?  Have any tips, words of wisdom?

I had the same idea to backup a MySQL database with git.

To be able to easily drop old "backups", I have choose to go with monthly 
branches: each month, the previous month's branch is checked out and a new 
branch is created; each year, the previous year is checked out...

This is running only for 5 weeks, but so far it works pretty well.
