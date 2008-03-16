From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible git git config --global user.email BUG
Date: Sun, 16 Mar 2008 12:41:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803161241180.3020@woody.linux-foundation.org>
References: <20080316192636.3075d0eb@linuxamd.linicks.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nick Warne <nick@ukfsn.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 20:43:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaylD-0004nb-Re
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 20:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYCPTmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYCPTmb
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 15:42:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36495 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752286AbYCPTmb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 15:42:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GJh25h004270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 12:43:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GJfu83010547;
	Sun, 16 Mar 2008 12:41:57 -0700
In-Reply-To: <20080316192636.3075d0eb@linuxamd.linicks.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.305 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77376>



On Sun, 16 Mar 2008, Nick Warne wrote:
> 
> git config --global nick.email <real.mail.address>
> git config --global nick.name "Nick Warne"

"nick.email/name"?

Should be "user", not "nick".

		Linus
