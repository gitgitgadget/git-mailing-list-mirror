From: David Miller <davem@davemloft.net>
Subject: Re: git-ls-files prefix superset problem
Date: Mon, 31 Jul 2006 22:25:57 -0700 (PDT)
Message-ID: <20060731.222557.52166634.davem@davemloft.net>
References: <20060731.221327.26966465.davem@davemloft.net>
	<Pine.LNX.4.64.0607312217420.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 07:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7mmR-0005xZ-TV
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 07:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWHAF0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 01:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWHAF0l
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 01:26:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43397
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161060AbWHAF0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 01:26:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id F0DCBAE43B0;
	Mon, 31 Jul 2006 22:25:57 -0700 (PDT)
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0607312217420.4168@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24576>

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 31 Jul 2006 22:18:47 -0700 (PDT)

> It should be fixed by the recent commit
> 
> 	Fix up some fallout from "setup_git_directory()" cleanup
> 
> that Junio already merged.
> 
> So just update your git again, and everything should be happy.

Yeah, just as you responded I noticed the there was local
variable shadowing of "prefix" which causes it to be NULL
and thus prune_cache() doesn't get called.

Thanks!
