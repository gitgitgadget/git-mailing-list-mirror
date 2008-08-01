From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:39:37 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3JU-0002g5-PA
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623AbYHAWkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755185AbYHAWkb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:40:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36636 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755191AbYHAWkb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:40:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Mdc0j013193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:39:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71MdbeJ007443;
	Fri, 1 Aug 2008 15:39:38 -0700
In-Reply-To: <20080801152720.56dbff09.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91114>



Btw, the real issue here is

 - why do you want to make things uglier and make up stupid rules that are 
   irrelevant to git, just for something that you admit you hadn't ever 
   even _noticed_ until now, and now that you know about it it's not even 
   a problem any more?

especially as

 - we know people won't do the quoting _anyway_, since we actually have 
   tons of examples of that in the kernel as-is. 

Quoting should be for _tools_, not for people. And even if we did it, we 
probably wouldn't be fully rfc2822-compliant anyway, because anybody sane 
would decide to not quote '@' and '.', rigth?

Because those don't actually really have special meaning (yeah, they are 
"special" characters in rfc-2822, but nobody cares, and the MUA can do it 
for us, no)?

So now we'd actually not really be rfc-compliant _anyway_, because 
everybody really realizes just how annoying that would really be.

		Linus
