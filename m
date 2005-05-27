From: Andrew Morton <akpm@osdl.org>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 13:51:24 -0700
Message-ID: <20050527135124.0d98c33e.akpm@osdl.org>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 22:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbllM-0005x9-0g
	for gcvg-git@gmane.org; Fri, 27 May 2005 22:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVE0Uu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVE0Uu4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:50:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:8832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262589AbVE0Uuj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 16:50:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RKoZjA005979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 13:50:35 -0700
Received: from localhost.localdomain (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j4RKoY6o008538;
	Fri, 27 May 2005 13:50:34 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > 
> > Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> > proper comments again. Also, the author is not correct (should be taken
> > from the first Signed-off-by:).
> 
> Hmm.. That's not always true in general, since Sign-off does allow to sign
> off on other peoples patches (see the "(b)" clause in DCO), but maybe in
> the ALSA tree it is.

Yes, I'll occasionally do patches which were written by "A" as:

From: A
...
Signed-off-by: B

And that comes through email as:


...
From: <akpm@osdl.org>
...
From: A
...
Signed-off-by: B


which means that the algorithm for identifying the author is "the final
From:".

I guess the bug here is the use of From: to identify the primary author,
because transporting the patch via email adds ambiguity.

Maybe we should introduce "^Author:"?

