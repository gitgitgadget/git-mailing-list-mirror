From: Wolfgang Denk <wd@denx.de>
Subject: cogito: problems in read-only trees
Date: Wed, 03 Aug 2005 09:42:41 +0200
Message-ID: <20050803074241.A2D1D3535F9@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Aug 03 09:44:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Du4-0002sO-QM
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 09:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVHCHmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 03:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVHCHmv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 03:42:51 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:6323 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262130AbVHCHmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 03:42:50 -0400
Received: from fwd28.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1E0Dtn-00081y-07; Wed, 03 Aug 2005 09:42:47 +0200
Received: from denx.de (JlLUJ2ZOQeWVKVgImt-pJa0uyPHDEG9NmoCeMB0I6r3tYwJK79pm0d@[84.150.76.158]) by fwd28.sul.t-online.de
	with esmtp id 1E0Dti-17JhNA0; Wed, 3 Aug 2005 09:42:42 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id B627942F8D
	for <git@vger.kernel.org>; Wed,  3 Aug 2005 09:42:41 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id A2D1D3535F9
	for <git@vger.kernel.org>; Wed,  3 Aug 2005 09:42:41 +0200 (MEST)
To: git@vger.kernel.org
X-ID: JlLUJ2ZOQeWVKVgImt-pJa0uyPHDEG9NmoCeMB0I6r3tYwJK79pm0d@t-dialin.net
X-TOI-MSGID: dfc4fa6f-2b61-46cf-bf01-6a1a2687c717
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

sometimes I have to  work  in  trees  for  which  I  have  only  read
permissions; cogito has problems then - for example:

-> cg-diff 
fatal: unable to create new cachefile
fatal: unable to create temp-file

It would be nice if there was at least a way to specify  some  TMPDIR
instead of the current directory in such a situation.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Include the success of others in your dreams for your own success.
