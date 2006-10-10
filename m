From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 9 Oct 2006 23:41:17 -0700 (PDT)
Message-ID: <20061010064117.86409.qmail@web31813.mail.mud.yahoo.com>
References: <20061010054643.GA565@coredump.intra.peff.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 08:41:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBIt-0005Bm-8q
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 08:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWJJGlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 02:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWJJGlS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 02:41:18 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:4970 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965022AbWJJGlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 02:41:18 -0400
Received: (qmail 86411 invoked by uid 60001); 10 Oct 2006 06:41:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=c6sT6I1y2LMONQRCJiJ4WD6pti9QWPb4s9UwrEFvNeKtsUWZtcBPsxtLXoQ+Ore69vkj4HEKlCSXzq6wdQtuiJe4oOW6y2Hi96UAE6qzqH6Wgo0bLllFmKHNWzYkg53uzUZBX6eCzeoH0kFOnksrLvOdhWKNqDukBHmgoNms3d8=  ;
Received: from [71.80.233.118] by web31813.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 23:41:17 PDT
To: Jeff King <peff@peff.net>
In-Reply-To: <20061010054643.GA565@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28610>

--- Jeff King <peff@peff.net> wrote:
> 2/3 to 1/3 if you're counting categories, but you haven't presented any
> evidence that the number of people in each category is the same.
> 
> Besides which, I think that people with a high degree of exposure to the
> web tend to look for the things that look like buttons or links. The
> near-universal sign for links on the web is underlining (and typically

Then let's universally underline absolutely _every_ link in gitweb
which is clickable, regardless of where it appears, the font, typeset
and size.

Who will be my hero and submit that patch?  I'll surely commit it
and make the people happy.

> an alternate color). Looking at the repo.or.cz file lists, I see that
> none of the files is highlighted but the directories are. What am I to
> guess (either by intuition or by "figuring it out") except that there is
> some difference between clicking the two? I think we are failing a
> consistency test.

Let's see:

Each line which starts with a "d" also has some kind of underlined
text in the second column.

Each line which starts with a "-" has text which is not underlined
in the second column.

Which implies a connection between the "d" and the property of
underlining.

Unless you have "a priori" knowlege of "underline means clickable" there
is no chance of thinking that "not-underlined means not-clickable".

   Luben
