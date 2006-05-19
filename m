From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Libify the index refresh logic
Date: Fri, 19 May 2006 10:42:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605191041280.10823@g5.osdl.org>
References: <Pine.LNX.4.64.0605190942060.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 19 19:42:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh8zZ-0003YY-SL
	for gcvg-git@gmane.org; Fri, 19 May 2006 19:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWESRmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 13:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWESRmX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 13:42:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751409AbWESRmX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 13:42:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4JHgCtH011305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 10:42:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4JHgCIv030693;
	Fri, 19 May 2006 10:42:12 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605190942060.10823@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20350>



On Fri, 19 May 2006, Linus Torvalds wrote:
> 
> This cleans up and libifies the "git update-index --[really-]refresh" 
> functionality. This will be eventually required for eventually doing the 
> "commit" and "status" commands as built-ins.

Oops, that's one "eventually" too many. That's what you get for editing 
and moving text around.

			Linus
