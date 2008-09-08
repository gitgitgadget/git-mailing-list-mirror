From: "Jing Xue" <jingxue@digizenstudio.com>
Subject: Re: git-p4 and keyword expansion
Date: Mon, 08 Sep 2008 17:39:00 -0400
Message-ID: <20080908173900.102324atjr5geizo@intranet.digizenstudio.com>
References: <554296.48174.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: "GIT SCM" <git@vger.kernel.org>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcoSy-0000EX-0H
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYIHVjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYIHVjD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:39:03 -0400
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:58868
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753250AbYIHVjC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 17:39:02 -0400
Received: (qmail 3455 invoked from network); 8 Sep 2008 21:39:01 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 08 Sep 2008 21:39:01 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 2065710008B;
	Mon,  8 Sep 2008 21:39:01 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fge6No6dipiO; Mon,  8 Sep 2008 17:39:00 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 522F8100A22; Mon,  8 Sep 2008 17:39:00 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde Framework) with
	HTTP; Mon, 08 Sep 2008 17:39:00 -0400
In-Reply-To: <554296.48174.qm@web95003.mail.in2.yahoo.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95306>

Quoting dhruva <dhruva@ymail.com>:

> Hi,
>  The git-p4 script unexpands all p4 keywords before feeding it to  
> git fastimport. When there is a new version, it records only the  
> diffs minus the keyword contents at it unexpands and then feeds to  
> fastimport. When trying to submit back to perforce, applying a patch  
> on top of the latest file in p4 with the keyword expanded fails  
> because we have not tracked that difference.
> Patch applying fails and expects you to manually (out of git) to do  
> a 'p4 submit' and get back and do 'git-p4 submit --continue'.
>  Removing the keyword unexpanding code in 'git-p4' with the  
> following patch makes it work:

I'm not really arguing against the patch itself, but just wondering  
whether it would be a good idea to make it optional or configurable.

IIUC, there are reasons for git to discourage keyword expansion - for  
instance as discussed in this thread:

http://kerneltrap.org/mailarchive/git/2007/10/11/335112

Cheers.
-- 
Jing Xue

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
