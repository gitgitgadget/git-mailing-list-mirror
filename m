From: Alex Belykh <albel727@ngs.ru>
Subject: character-based diff in gitk?
Date: Thu, 19 Aug 2010 14:33:18 +0000 (UTC)
Message-ID: <loom.20100819T160249-30@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 16:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om6IV-0008JR-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 16:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab0HSOkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 10:40:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:48386 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779Ab0HSOkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 10:40:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Om6Hk-0007h6-RX
	for git@vger.kernel.org; Thu, 19 Aug 2010 16:40:04 +0200
Received: from nat1.academ.org ([89.31.118.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 16:40:04 +0200
Received: from albel727 by nat1.academ.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 16:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.31.118.248 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.126 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153925>

Hi, guys.

There's a question, that's been bugging me for quite a long time.
Is it possible to make gitk show character-based diff instead of 
line-based one? 

I'm aware of git-diff's "--word-diff" option, but I would like 
to have the same functionality in GUI. That would make comprehending
some diffs, that I usually encounter (like commented-out code, 
changed class/method names, etc), MUCH easier. 
Does gitk use git-diff machinery, and if so, is there a way to pass
this option to it?

Best regards,
Alex Belykh.
