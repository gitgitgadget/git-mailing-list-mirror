From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: gitk run from subdir and "find commit touching paths"
Date: Tue, 27 Jan 2009 17:14:16 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngnug78.877.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 18:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRrYY-0003vN-Kj
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802AbZA0ROc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbZA0ROb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:14:31 -0500
Received: from main.gmane.org ([80.91.229.2]:35556 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757775AbZA0RO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:14:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LRrW6-00067o-Re
	for git@vger.kernel.org; Tue, 27 Jan 2009 17:14:26 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:14:26 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 17:14:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107363>

If I run gitk from a subdirectory, and then try to find a
commit touching a path, it doesn't work.  No movement of
cursor on "Next/Prev".

Running from the main project directory makes it work ok --
you can go "Next" or "Prev" finding other commits that
touched the same path.

Is this a known problem?  I couldn't find it in the mailing
list archives.

Thanks,

Sitaram
