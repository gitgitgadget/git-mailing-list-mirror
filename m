From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Retroactively change email signature? [resend]
Date: Fri, 4 Jan 2008 10:34:39 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801041031590.2811@woody.linux-foundation.org>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com> <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org> <477C7837.9000303@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JArOr-0006qO-4g
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYADSfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbYADSfm
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:35:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54005 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251AbYADSfm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jan 2008 13:35:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m04IYeWt017313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Jan 2008 10:34:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m04IYdcb002409;
	Fri, 4 Jan 2008 10:34:39 -0800
In-Reply-To: <477C7837.9000303@vilain.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69592>



On Thu, 3 Jan 2008, Sam Vilain wrote:
> 
> Assuming, of course, that the commit you refer to in a message like that
> is in your history.  If it's referring to another commit in a different
> branch, which may be being re-written, you've got two problems:

I don't care. If some commit refers to another commit that isn't its 
ancestor, then that is undefined *anyway*. 

So the only case that really matters is when you refer to your own strict 
ancestor.

This is one reason why it was so crazy that "git cherry-pick" used to have 
"-x" by default - appending the original SHA1 (which is generally *not* an 
ancestor) is meaningless and stupid.

But in the case of "git revert", it should be an ancestor (or the _user_ 
is just insane, in which case it doesn't matter - insane people can do 
insane things)

		Linus
