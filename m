From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How can I specify a non-standard TCP port for a git+ssh connection?
Date: Fri, 2 Dec 2005 08:07:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512020805480.3099@g5.osdl.org>
References: <20051202124801.GA20332@andaco.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 17:08:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiDRm-0006Nr-Lw
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 17:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVLBQHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 11:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLBQHk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 11:07:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750805AbVLBQHj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 11:07:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB2G7Ye0021004
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Dec 2005 08:07:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB2G7X3A015574;
	Fri, 2 Dec 2005 08:07:34 -0800
To: Andreas Jochens <aj@andaco.de>
In-Reply-To: <20051202124801.GA20332@andaco.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13119>



On Fri, 2 Dec 2005, Andreas Jochens wrote:
> 
> is there a simple way to specify a non-standard TCP port for a git+ssh
> connection? 

Use the ".ssh/config" file ;)

> The following small patch would allow to use an URL like 
> 'git+ssh://user@hostname:port/path' to specify an arbitrary 
> port for the ssh connection.

Maybe. On the other hand, I think we'd be better off  with perhaps some 
way to just specify arbitrary options to the "ssh" program. Sometimes you 
might want to specify identity-files etc too.

		Linus
