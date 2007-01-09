From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek() sequence.
Date: Tue,  9 Jan 2007 22:04:11 +0100
Message-ID: <25350.7382622503$1168376674@news.gmane.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 22:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4O8p-0005IZ-Kw
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbXAIVEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAIVEQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:04:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:63640 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbXAIVEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:04:15 -0500
Received: from [84.134.14.63] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis),
	id 0MKwtQ-1H4O8j2Kct-0006vi; Tue, 09 Jan 2007 22:04:14 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l09L4CmQ022644
	for <git@vger.kernel.org>; Tue, 9 Jan 2007 22:04:12 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l09L4CQY022641
	for git@vger.kernel.org; Tue, 9 Jan 2007 22:04:12 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.4.gfa432
In-Reply-To: 7v1wm4kl24.fsf@assigned-by-dhcp.cox.net
References: 7v1wm4kl24.fsf@assigned-by-dhcp.cox.net
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED,INVALID_MSGID 
	autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36400>

Thanks for the hints, here the next try.

Stefan
