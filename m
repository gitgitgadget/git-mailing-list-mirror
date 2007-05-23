From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: HTTP trees trailing GIT trees
Date: Wed, 23 May 2007 14:01:33 +0000 (UTC)
Message-ID: <loom.20070523T154909-285@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:02:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqrPX-0005Lz-Ks
	for gcvg-git@gmane.org; Wed, 23 May 2007 16:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbXEWOBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 10:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756963AbXEWOBv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 10:01:51 -0400
Received: from main.gmane.org ([80.91.229.2]:39591 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756285AbXEWOBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 10:01:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HqrPN-0006mc-K0
	for git@vger.kernel.org; Wed, 23 May 2007 16:01:45 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 May 2007 16:01:45 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 May 2007 16:01:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48156>

Hi all,

A few days ago I started noticing that my GIT tree cloned through http was
always trailing the one which was clone using the git protocol.

When pulling both clones to the lastest version I got this:

* Last one when accessed through http:
commit dedc2982f2f845357f28dff401fe5df8510c6a8f
Author: benoit <benoit <at> 9553f0bf-9b14-0410-a0b8-cfaf0461ba5b>
Date:   Tue May 22 08:28:32 2007 +0000

* Last one when accessed through git:
commit 55d4b9a1d0bb75a085462d4f885301507d8fd082
Author: takis <takis <at> 9553f0bf-9b14-0410-a0b8-cfaf0461ba5b>
Date:   Wed May 23 09:07:57 2007 +0000


I reported this to the person who had setup the repository:
http://article.gmane.org/gmane.comp.video.ffmpeg.devel/51151

But unfortunately, the problem seems to remain.

Is this a known problem, or might this be a bug or misconfiguration?

I am using git version 1.5.2.35.ga334 when using http and git version 1.5.1.3
when using the git protocol.

The repository is available through http as:
http://git.mplayerhq.hu/ffmpeg

Through the git protocol:
git://git.mplayerhq.hu/ffmpeg

And through gitweb:
http://git.mplayerhq.hu/


With friendly regards,
Takis
