From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 17:23:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdDVo-0007wq-Ul
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 02:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbYIJAXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 20:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYIJAXl
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 20:23:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55527 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864AbYIJAXl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 20:23:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8A0NSKf007221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Sep 2008 17:23:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8A0NREn011164;
	Tue, 9 Sep 2008 17:23:28 -0700
In-Reply-To: <20080909235848.GE7459@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95472>



On Wed, 10 Sep 2008, Stephen R. van den Berg wrote:
> 
> As you might have noticed, the actual process of pulling/fetching
> explicitly does *not* pull in the objects being pointed to.

.. which makes them _local_ data, which in turn means that they should not 
be in the object database at all.

IOW, i you want this for local reasons, you should use a local database, 
like the index or the reflogs (and I don't mean "like the index" in the 
sense that it would look _anything_ like that file, but in the sense that 
it's a purely local thing and doesn't show up in the object database).

		Linus
