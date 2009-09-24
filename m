From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] 'git cat-file' needs a better design on its option
 interface
Date: Thu, 24 Sep 2009 10:23:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909241021120.3303@localhost.localdomain>
References: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Li Hong <lihong.hi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 19:24:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqs30-0002BO-S1
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 19:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZIXRXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 13:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZIXRXw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 13:23:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43353 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751851AbZIXRXw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 13:23:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8OHNq05003713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Sep 2009 10:23:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n8OHNqps030578;
	Thu, 24 Sep 2009 10:23:52 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <3a3680030909240804w1399ed7fhd6367300544f34f@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.961 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129051>



On Thu, 24 Sep 2009, Li Hong wrote:
> 
> When using 'git cat-file' recently, I find its option interface is somewhat
> inconvenient or mistakenly-designed.

You likely shouldn't use 'cat-file' at all. Have you looked at 'git show'? 
That's the command meant for human beings.

'git cat-file' is really really low-level plumbing. Humans should 
generally never use it. It's one of the original git commands (it was 
literally in the original git commit), and it does some really low-level 
stuff that is good for scripting but not for any normal use.

		Linus
