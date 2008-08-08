From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Not going beyond symbolic links
Date: Fri, 8 Aug 2008 16:45:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808081639540.3462@nehalem.linux-foundation.org>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7vk5etjozt.fsf@gitster.siamese.dyndns.org> <7vod43b519.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 01:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRbg7-0004iE-72
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 01:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYHHXqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 19:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbYHHXqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 19:46:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54551 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752665AbYHHXqY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 19:46:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78NjReL008245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Aug 2008 16:45:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m78NjQRK003058;
	Fri, 8 Aug 2008 16:45:26 -0700
In-Reply-To: <7vod43b519.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.409 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91728>



On Fri, 8 Aug 2008, Junio C Hamano wrote:
> 
> Seeing that you applied my arch/powerpc/.gitignore patch to the kernel
> (Yaay, I now have a short-log entry in the kernel history ;-), you have
> seen the message with some benchmarks I am replying to as well?

Yes, I just felt that closed the discussion.

I only brought up the issue in the first place because I worried about the 
performance impact. And I was unhappy about how that worry was dismissed 
as being less important than some specious "correctness" issue (for the 
last 3+ years, performance has mattered a _lot_, and the claimed big 
"correctness" issue has not mattered one whit).

The thing is, sometimes "pi = 3.14" is (a) infinitely faster than the 
"correct" answer and (b) the difference between the "correct" and the 
"wrong" answer is meaningless. And this is why I get upset when somebody 
dismisses performance issues based on "correctness".

The thing is, some specious value of "correctness" is often irrelevant 
because it doesn't matter. While performance almost _always_ matters. And 
I absolutely _detest_ the fact that people so often dismiss performance 
concerns so readily.

But once the performance numbers are in and they don't show any issues, I 
think that simply settles the original query, and I'm happy.

		Linus
