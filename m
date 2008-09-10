From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 08:30:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <20080910054244.GB15715@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRfm-0000K1-Bh
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYIJPaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbYIJPaz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:30:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54125 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654AbYIJPay (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 11:30:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8AFUeeo004375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Sep 2008 08:30:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8AFUdXm012611;
	Wed, 10 Sep 2008 08:30:39 -0700
In-Reply-To: <20080910054244.GB15715@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95528>



On Wed, 10 Sep 2008, Stephen R. van den Berg wrote:
> 
> But then how would someone who clones the repository get at the information?

You just said it wouldn't get there with fetches.

If clone acts differently from a "full" fetch, something is really really 
wrong.

> The information is essential to understand backports between the various
> stable branches.

No it's not. You can mention the backport explicitly in the commit 
message, and then you get hyperlinks in the graphical viewers. That works 
when people _want_ it to work, instead of in some hidden automatic manner 
that does entirely the wrong thing in all the common cases.

What more do you want?

		Linus
