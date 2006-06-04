From: Anton Blanchard <anton@samba.org>
Subject: git clone takes ages on a slow link
Date: Sun, 4 Jun 2006 11:01:45 +1000
Message-ID: <20060604010145.GC986@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 04 03:06:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmh4n-0006XT-Ba
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 03:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWFDBGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 21:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFDBGe
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 21:06:34 -0400
Received: from ozlabs.org ([203.10.76.45]:23489 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750871AbWFDBGd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 21:06:33 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id A8B4367A2E; Sun,  4 Jun 2006 11:06:32 +1000 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21236>


Hi,

I tried cloning a local repository when connected over a slow (1 second+
latency) link. It took forever (I gave up after 10 minutes). If I ran
it in the background it took a few seconds.

I think the ticker is over anxious.

# git clone -l linux-2.6 linux-2.6-test
0 blocks
Checking files out...
   5% (1060/19552) done			<---- performance bottleneck

Anton
