From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: [PATCH] checkout -f: do not leave untracked working tree files.
Date: Tue, 20 Jun 2006 19:08:53 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606201908.53318.lan@academsoft.ru>
References: <449557B6.1080907@garzik.org> <200606201827.50808.lan@academsoft.ru> <7vveqw82qd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 14:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsf2l-0005MO-7s
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 14:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWFTMJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 08:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWFTMJI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 08:09:08 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:2469 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1750847AbWFTMJH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 08:09:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id E1325BDDF; Tue, 20 Jun 2006 19:09:05 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04650-07; Tue, 20 Jun 2006 19:08:56 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id BC342BDDC; Tue, 20 Jun 2006 19:08:56 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id B3FC48DA0451; Tue, 20 Jun 2006 19:08:56 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 680B18DA044F;
	Tue, 20 Jun 2006 19:08:54 +0700 (NOVST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vveqw82qd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22195>

> "will" meaning "you suspect" or "you tried and confirmed"?
:-) I suspect.

Lets test. Your pu branch (5af05efbeaa06005596129fb111a739a87f8a883) really 
works. I have cvs repo and use git for daily work. I have head and 2 branches 
from cvs and store CVS/* files in git too. Usualy this operation pruduce a 
lot of CVS/Tag files:

git checkout -f cvs-v52 (this is one of by cvs's branch)
cvs -q up -dP (nothing have been updated)
git checkout -f master (this is a dev branch from cvs head)
git status

pu branch nuke them when use git checkout -f !
