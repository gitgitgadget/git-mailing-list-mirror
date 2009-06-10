From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 18:59:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906091857210.6847@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain> <4A2F0B8A.9010203@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 03:59:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MED6U-0006Q7-T1
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 03:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbZFJB7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 21:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbZFJB7l
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 21:59:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60203 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753883AbZFJB7l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 21:59:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5A1xfoU015033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 18:59:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5A1xeeV009170;
	Tue, 9 Jun 2009 18:59:41 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A2F0B8A.9010203@vilain.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121242>



On Wed, 10 Jun 2009, Sam Vilain wrote:
> 
> We talked about making a 'git revert-file' and 'git revert-commit', with
> 'git revert' printing a message encouraging the user to specify which
> one they wanted (or potentially pointing them to the correct
> incantations of 'git checkout' or 'git cherry-pick').
> 
> I think as long as there is a deprecation cycle, and that users can
> select the old behaviour (either via an alias or a config option), then
> we shouldn't upset many long-time users of revert. Do you agree?

No. I disagree. What the hell is the point in making an _inferior_ name 
for what we already have?

I violently disagree with making git worse just because somebody cannot 
bother to learn it. And it really is about "bother" - it's clearly not 
about anything else.

I also don't see why you'd also then advocate a clearly inferior model 
with two different commands, when you _could_ just do the "commitname" vs 
"pathspec" model. 

		Linus
