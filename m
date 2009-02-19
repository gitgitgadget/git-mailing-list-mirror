From: Jim Ramsay <i.am@jimramsay.com>
Subject: Shallow clones (git clone --depth) are broken?
Date: Thu, 19 Feb 2009 14:55:24 -0500
Message-ID: <20090219145524.32ca3915@vrm378-02.vrm378.am.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 02:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJqh-0000QY-Ul
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 02:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZBTBFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 20:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZBTBFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 20:05:09 -0500
Received: from main.gmane.org ([80.91.229.2]:45842 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbZBTBFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 20:05:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LaJp9-0004tD-5y
	for git@vger.kernel.org; Fri, 20 Feb 2009 01:05:03 +0000
Received: from 144.190.95.61 ([144.190.95.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 01:05:03 +0000
Received: from i.am by 144.190.95.61 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 01:05:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 144.190.95.61
X-Newsreader: Claws Mail 3.6.1 (GTK+ 2.14.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110776>

I've been trying to experiment with shallow clones, however I can't
seem to actually create one.  Here's what I've tried, for example:

git clone --depth 1 git://git.fluxbox.org/fluxbox.git

However, this gets me everything, and takes quite a while.  After it
completes, running gitk shows me the entire history, and the size of
the .git directory is the same as a full clone I've done previously.

I've tried this with both 1.6.0.2 and 1.6.1.3, to the same effect.

Can anyone out there verify that this --depth option actually does
anything?  Or could it potentially be the version of git on the
server?

If it's not just something odd I'm doing, I can take the time to
try to figure out in which version this *does* work, and when it
stopped... Though others out there may be more equipped than I to chase
this down.

-- 
Jim Ramsay
