From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH] Replacing the system call pread().
Date: Tue,  9 Jan 2007 19:51:54 +0100
Message-ID: <1826.03409416533$1168368738@news.gmane.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 19:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4M4t-0002jp-IR
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 19:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXAISwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 13:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbXAISwE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 13:52:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:54102 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbXAISwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 13:52:03 -0500
Received: from [84.134.14.63] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis),
	id 0ML29c-1H4M4j3Bz7-000813; Tue, 09 Jan 2007 19:51:58 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l09IpuBN017455
	for <git@vger.kernel.org>; Tue, 9 Jan 2007 19:51:56 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l09Ipu5B017452
	for git@vger.kernel.org; Tue, 9 Jan 2007 19:51:56 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.4.g46aa
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED,INVALID_MSGID 
	autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36386>

Ok,

following the next try for replacing pread() with
lseek()/xread()/lseek() sequence like Shawn suggested.

It's tested on Linux but not yet on Cygwin. I'll do it tomorrow.

Stefan
