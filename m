From: "Andrew Pamment" <andrew@mort-os.com>
Subject: gitweb on OpenBSD (-T not supported on filesystems...)
Date: Sun, 17 Sep 2006 18:15:05 +0930
Message-ID: <op.tf0k9fdvqpav6l@crystal.sienna.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 17 10:44:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsFk-00028L-SL
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWIQIno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 04:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIQIno
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:43:44 -0400
Received: from vscan02.westnet.com.au ([203.10.1.132]:8368 "EHLO
	vscan02.westnet.com.au") by vger.kernel.org with ESMTP
	id S932248AbWIQInn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 04:43:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id CE06D11A349
	for <git@vger.kernel.org>; Sun, 17 Sep 2006 16:43:40 +0800 (WST)
Received: from vscan02.westnet.com.au ([127.0.0.1])
 by localhost (vscan02.westnet.com.au [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28227-12 for <git@vger.kernel.org>;
 Sun, 17 Sep 2006 16:43:40 +0800 (WST)
Received: from crystal.sienna.ath.cx (dsl-202-173-138-168.sa.westnet.com.au [202.173.138.168])
	by vscan02.westnet.com.au (Postfix) with ESMTP id B6FE111C78B
	for <git@vger.kernel.org>; Sun, 17 Sep 2006 16:43:39 +0800 (WST)
To: git@vger.kernel.org
User-Agent: Opera Mail/9.01 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27166>

Hi git people

I'm not sure if this is useful but I thought I would post it anyway,

in gitweb.cgi on line 1560 where you have -T testing a file descripter, it  
doesn't work on OpenBSD 3.9, which makes viewing blobs not work.

I solved this (or I think I have) by replacing $fd with $filename.

Andrew

-- 
Mort - http://www.mort-os.com/
