From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 10:11:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609281003070.3952@g5.osdl.org>
References: <20060928165509.77413.qmail@web51001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 19:11:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSzQA-0008Cq-DP
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 19:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWI1RLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 13:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWI1RLP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 13:11:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030256AbWI1RLO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 13:11:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SHB5nW020060
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 10:11:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SHB16J015140;
	Thu, 28 Sep 2006 10:11:03 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928165509.77413.qmail@web51001.mail.yahoo.com>
X-Spam-Status: No, hits=-0.46 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28022>



On Thu, 28 Sep 2006, Matthew L Foster wrote:
> 
> I am not saying git should "police any one else's clocks", I am saying git should be designed or
> configured in such a way, using local time, that it obviates the current reliance on everyone
> else's clock being set correctly. 

Matt!

THERE IS NO SUCH RELIANCE! NONE.

Trust me. When we say that git ignores time, WE MEAN IT. Git does not rely 
on time, git does not use time, git does not CARE!

Please stop looking at gitweb _immediately_. If you think time has some 
meaning for git, stop. It doesn't. We've told you over and over and over 
again that there is absolutely _zero_ reliance on everybody else's clock 
being set correctly. The damn clock could go _backwards_, or make huge 
jumping purple leaps of imagination, and git wouldn't care.

The time that git records is purely a random number. It's a random number 
that _humans_ can choose to care about or not, and it's a random number 
that git itself uses only in the sense of "ok, I've got two equal choices, 
let's toss a coin to select which one I'll look at next", BUT IT IS A 
RANDOM NUMBER.

Please.

Download a local git archive, and run "gitk" on that archive. Then _hide_ 
the time column (just so that it doesn't confuse you), and then _look_ at 
the leftmost column which shows the CAUSALITY DAG!

THAT is what git actually cares about. It's the _only_ thing that git 
cares about. Git cares about _causality_, not time. Nothing else matters.

Really. Truly, pretty please, I promise you, cross my heart and hope to 
die! Scouts honor. Lock it up and throw away the key. It's TRUE.

		Linus
