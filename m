From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Git on Windows, CRLF issues
Date: Mon, 21 Apr 2008 21:48:58 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 21:51:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo22t-0004XC-H6
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 21:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762073AbYDUTuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 15:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762005AbYDUTuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 15:50:16 -0400
Received: from smtp.getmail.no ([84.208.20.33]:52031 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758096AbYDUTuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 15:50:12 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZO00HNNXRNFA00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 Apr 2008 21:50:11 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZO0085WXPN5XD0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 Apr 2008 21:48:59 +0200 (CEST)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZO00KIHXPNX2C0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 21 Apr 2008 21:48:59 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id 053882FC2A; Mon,
 21 Apr 2008 21:48:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 01BEA2FC09	for <git@vger.kernel.org>; Mon,
 21 Apr 2008 21:48:59 +0200 (CEST)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80036>

Hi!

I have began moving old repositories for Windows-based software to Git. 
Since the tool I am moving from stores everything with CRLF line endings and 
have RCS-like keyword expansion, I'm treating it all as binary data when 
exporting to Git, i.e I have CRLF in the checked-in data (and I do want 
that, since this is Windows-only sources).

Now the latests msysgit comes along and (finally!) sets core.autocrlf to 
true by default.

How do I handle this without having everyone breaking check-ins? I can't 
require everyone to do unset core.autocrlf globally. Can I do that with 
gitattributes?

-- 
\\// Peter - http://www.softwolves.pp.se/
