From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 10:55:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 19:57:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWast-0001Yh-Dc
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbYHVR4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbYHVR4K
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:56:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47731 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094AbYHVR4K (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 13:56:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MHtZYR019045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Aug 2008 10:55:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7MHtZF9008426;
	Fri, 22 Aug 2008 10:55:35 -0700
In-Reply-To: <20080822174655.GP23334@one.firstfloor.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93335>



On Fri, 22 Aug 2008, Andi Kleen wrote:
> 
> Especially in Linux kernel land there seem to be quite a few tree
> which are frequently rebased, which means that the usual "git pull -u"
> usually leads to conflicts even when one hasn't changed anything
> at all and just wants the latest state of that tree.

What drugs are you on?

"git pull" is not "download". It's "download and merge".

If you just want download, use "git fetch". You should never _ever_ use 
"git pull -u", and the docs even tell you so.

And if you _really_ haven't changed anything, then "git pull" will never 
_ever_ generate a conflict, not with -u, not without, not _ever_. 

So you are really majorly confused about something here.

			Linus
