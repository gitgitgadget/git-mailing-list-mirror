From: Wolfgang Denk <wd@denx.de>
Subject: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 12:11:38 +0200
Message-ID: <20050916101138.99906352682@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Sep 16 12:12:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGDCF-00047x-Vz
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 12:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbVIPKLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 06:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbVIPKLx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 06:11:53 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:35280 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1161155AbVIPKLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 06:11:52 -0400
Received: from fwd34.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1EGDC7-0008OO-03; Fri, 16 Sep 2005 12:11:47 +0200
Received: from denx.de (GulocwZOreRsn2F1Irz6k4qqk0zlXjeiW--lHh3XvzBZCknRYJ+iQp@[84.150.84.114]) by fwd34.sul.t-online.de
	with esmtp id 1EGDC5-1Aji520; Fri, 16 Sep 2005 12:11:45 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id F35FB427BC
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 12:11:44 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 99906352682
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 12:11:38 +0200 (MEST)
To: git@vger.kernel.org
X-ID: GulocwZOreRsn2F1Irz6k4qqk0zlXjeiW--lHh3XvzBZCknRYJ+iQp@t-dialin.net
X-TOI-MSGID: 73c9a141-5893-4f27-bc67-e22c3ccb959e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8673>

When running git fsck I get some messages:

-> git-fsck-cache --unreachable $(cat .git/HEAD .git/refs/heads/*)
unreachable commit 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770
unreachable tree 29a4c18afd958cc6cee938f0fe7fa59764418097
unreachable tree 3b722a7278e02b272ddc8aefbc7be22703d8a94f
unreachable tree 4ebc50d240d99b4236952d13d5044691f9078e3c
unreachable tree 63af5944e130b449338cc907ee77c51f4a69e339
unreachable tree 79c9a6bb02a80df15c7d829bdac0901f88c5e301
unreachable blob 85dcf4b5c4c0f6833cd63fa1d0fd29ef250162af
unreachable commit c1b779fbce762c970e3ace4332bb6ddc0de65e61
unreachable blob d70d1d44f12db7b2a3976c2a5313c90568a62c25
unreachable commit e1bcd2a5d53bceef2679737474487e32d87e7f2c

I have to admit that I don't know what to do next...

a) I understand that these  messages  are  indications  of  problems,
   right? What can I do to clean this up?

b) Is there any way to find out what I did wrong in the first place?

In case it matters: the tree in question is available at
{rsync,http}://source.denx.net/git/u-boot.git

Thanks in advance,

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"This isn't brain surgery; it's just television."   - David Letterman
