From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 0/4] User-relative paths, take two.
Date: Tue, 01 Nov 2005 23:44:53 +0100
Message-ID: <4367EFE5.8070009@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 01 23:45:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX4sE-00073X-1P
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVKAWoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVKAWoz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:44:55 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45292 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751371AbVKAWoy
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:44:54 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id CA15A6BD00
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 23:44:53 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10961>

I've reworked the user-relative paths according to the discussion "[RFC] 
GIT paths" started by Junio. In addition I've added a '--strict-paths' 
option to git-daemon.

I think I got everything right. At least it builds nicely and works as 
expected.

Comments welcome. Upstream inclusion even more so. :)

Btw. I'll have some more patches for git-daemon soon (--server-root and 
--userdir) which will rely on these patches making it in. Should I hold 
off on that for now?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
