From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 10:55:03 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711091050230.15101@woody.linux-foundation.org>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com> 
 <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org> 
 <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com> 
 <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org>
 <4fe79b4b0711091037g8c6c048h29b7d387e75d62bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, ae@op5.se,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZ1K-0000Vu-Bk
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbXKISzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbXKISzk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:55:40 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43545 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755270AbXKISzj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 13:55:39 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9It4jb017962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 10:55:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9It3sN027311;
	Fri, 9 Nov 2007 10:55:03 -0800
In-Reply-To: <4fe79b4b0711091037g8c6c048h29b7d387e75d62bb@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64250>



On Fri, 9 Nov 2007, Yossi Leybovich wrote:
>
> What interesting is the second part of the experiment
> I tried to apply the same commit on this file and it leaded to different SHA1

Eh. That commit was basically corrupt, because the blob had gotten 
removed. I don't even understand how git diff-tree gave a diff with that 
file at all (side note: I'd also suggest you just use "git show <commit>" 
instead of that complex and _really_ old git-diff-tree incantation).

So no, you didn't "apply the same commit". 

But if you have the diff somewhere (perhaps email archive? you sent it to 
somebody?) or you can re-create it exactly, then..

		Linus
