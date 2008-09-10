From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 08:43:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <48C785C3.9010204@gnu.org> <alpine.LFD.1.10.0809100830570.3384@nehalem.linux-foundation.org> <48C7E9A1.5080409@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRsP-0004gD-00
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYIJPn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYIJPn4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:43:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35994 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752150AbYIJPnz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 11:43:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8AFhQMC005417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Sep 2008 08:43:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8AFhPp5013154;
	Wed, 10 Sep 2008 08:43:25 -0700
In-Reply-To: <48C7E9A1.5080409@gnu.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95534>



On Wed, 10 Sep 2008, Paolo Bonzini wrote:
> 
> I think that shallow clones are not any different from this.  If the
> required piece of history is there, cool.  If they're not there, no big
> deal.

Sure. I don't use them either. But because I don't use them, it doesn't 
affect me. It also doesn't change the core git data structures in any way 
to introduce any new problems.

Also, if there isn't a required piece of history, things generally break 
very loudly. IOW, there are only certain things you can do with a shallow 
repo. In general it's absolutely _not_ a "no big deal" issue, quite the 
reverse - it's a deal-breaker.

			Linus
