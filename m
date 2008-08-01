From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:52:36 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011550450.6819@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011531290.6819@nehalem.linux-foundation.org>
 <20080801154453.921bb50f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3Ws-0006Cy-7m
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761233AbYHAWxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbYHAWxy
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:53:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50069 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752450AbYHAWxx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:53:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Mqbs0014260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:52:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Mqate008095;
	Fri, 1 Aug 2008 15:52:37 -0700
In-Reply-To: <20080801154453.921bb50f.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91120>



On Fri, 1 Aug 2008, Andrew Morton wrote:
> > 	S.__a__lar Onur <caglar@pardus.org.tr>
> 
> oh.  So .mailmap isn't usable either.  Argh.

Btw, your mailer really is broken. It seems to have turned my correct 
utf-8 email into US-ASCII. 

Or at least it was correct when it came back to me. I don't see the 
corruption. But your mailer seems to be unable to handle any complex 
character sets and did

	X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
	Mime-Version: 1.0
	Content-Type: text/plain; charset=US-ASCII

and I wonder why?

Yeah, I feel superior, because alpine actually gets things right these 
days. I too used to be character-set-confused.

			Linus
