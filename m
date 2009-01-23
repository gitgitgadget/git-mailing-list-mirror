From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: git blame: two "-C"s versus just a single -C
Date: Fri, 23 Jan 2009 11:28:59 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngnjafr.iaa.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 12:30:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQKFA-0000Lo-Ia
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 12:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbZAWL3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 06:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753538AbZAWL3M
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 06:29:12 -0500
Received: from main.gmane.org ([80.91.229.2]:36739 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbZAWL3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 06:29:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LQKDj-000574-Cm
	for git@vger.kernel.org; Fri, 23 Jan 2009 11:29:07 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 11:29:07 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 11:29:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106874>

I seem to recall (and the docs indicate) that when you
*copy* (not move, just copy) a function from file1.c to
file2.c, commit, and then do a "git blame -C -C file2.c", it
should tell you that those lines came from file1.c

Is this not true?  Git 1.6.1, I tried this on a dummy branch
where I just copied a good sized function (about 45 lines)
from one C program and dumped it at the bottom of a second
one, and neither the gui blame nor the CLI blame show me
that the lines came from elsewhere.

What am I doing wrong?
