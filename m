From: Nikolai Prokoschenko <nikolai@prokoschenko.de>
Subject: Push over WebDAV and hooks
Date: Thu, 21 Aug 2008 21:48:52 +0200
Message-ID: <g8kgr5$e67$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 21:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGBf-0000p6-Ef
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 21:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbYHUTuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYHUTuG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 15:50:06 -0400
Received: from main.gmane.org ([80.91.229.2]:59774 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbYHUTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 15:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KWGAV-0003bO-1L
	for git@vger.kernel.org; Thu, 21 Aug 2008 19:50:03 +0000
Received: from f051108113.adsl.alicedsl.de ([78.51.108.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 19:50:03 +0000
Received: from nikolai by f051108113.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 19:50:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: f051108113.adsl.alicedsl.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93192>

Hello,

I'm sorry for a dumb novice question, but there is something I don't 
quite understand and neither the docs nor all the blog entries on the 
net are really clear on this.

I have a (bare) repository on my server. Since I need to access it from 
firewalled networks, I can't go with git protocol or SSH; I thought 
WebDAV is the way to go. However I've noticed that my hooks are not 
executed and could not really think of a way the could ever work, since 
WebDAV is essentially a virtual hard drive without any execution 
capability. So am I right, hooks aren't supposed to work with WebDAV and 
so I'd have to find a way to use SSH or git:// to push changes?

Thanks.

Nikolai.
