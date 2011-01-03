From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: gitattributes don't work
Date: Mon, 3 Jan 2011 00:42:08 +0000 (UTC)
Message-ID: <ifr610$3kl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 01:45:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYYA-0008Uw-LD
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 01:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab1ACApI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 19:45:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:55519 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab1ACApH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 19:45:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PZYXp-0008JQ-OJ
	for git@vger.kernel.org; Mon, 03 Jan 2011 01:45:05 +0100
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 01:45:05 +0100
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 01:45:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.133 (House of Butterflies; GIT 3b0ee7d master)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164429>

I'm trying to exclude certain paths (those that contain "xmac/gen/") from 
diff output using .git/info/attributes (not .gitattributes).

According to gitattributes(5) it supports patterns from gitignore(5).

Example path that must be excluded:
src/byucc/jhdl/CSRC/xmac/gen/and2_dp_g.xmac

What I've tried but didn't work:
xmac/gen/ -diff

Following works but is not what I want:
*.xmac -diff

It seems I can only get it to work for file names but not for whole paths.
What am I doing wrong or is this a bug ?

git version 1.7.3.4
