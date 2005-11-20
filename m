From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Sun, 20 Nov 2005 11:07:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511201103280.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
 <20051120182943.GG8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 20:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EduXy-0003X6-9j
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 20:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKTTID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 14:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVKTTID
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 14:08:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbVKTTIB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 14:08:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAKJ7onO011178
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 20 Nov 2005 11:07:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAKJ7nYv013208;
	Sun, 20 Nov 2005 11:07:49 -0800
To: skimo@liacs.nl
In-Reply-To: <20051120182943.GG8383MdfPADPa@greensroom.kotnet.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12394>



On Sun, 20 Nov 2005, Sven Verdoolaege wrote:
> 
> Not sure if this falls in the ".ini-file-like" category, but
> YAML (www.yaml.org) does nesting based on indentation.

The main reason I don't like indentation is that it tends to have strange 
rules for "tab". Some people (incorrectly, of course) think that tabs are 
not at fixed 8-byte things, so deciding the indentation of a tab often 
ends up either disallowing tabs altogether (bad) or having other strange 
rules (disallowing spaces).

So I'm not religiously opposed to it, but I find it to be less than 
optimal.

I'd rather have just _pure_ braces, but while that is natural to 
programmers, it's not very natural to most users, I think.

		Linus
