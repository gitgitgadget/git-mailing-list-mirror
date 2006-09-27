From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 23:43:09 -0400
Message-ID: <BAYC1-PASMTP0819E6B1CBE028BD171598AE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 05:43:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSQKK-000069-4K
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 05:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWI0DnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 23:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWI0DnN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 23:43:13 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:7759 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932364AbWI0DnM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 23:43:12 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 20:51:15 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSQKE-0004Sk-3e; Tue, 26 Sep 2006 23:43:10 -0400
To: Jeff King <peff@peff.net>
Message-Id: <20060926234309.b16aa44e.seanlkml@sympatico.ca>
In-Reply-To: <20060927033459.GA27622@coredump.intra.peff.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 03:51:16.0187 (UTC) FILETIME=[2EE21AB0:01C6E1E8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2006 23:34:59 -0400
Jeff King <peff@peff.net> wrote:

> Right. So you really want to know not "when did this commit enter this
> repo" but rather "when did this head/branch first contain this commit"
> (since there may be multiple branches within a repo).

Even though it's being a bit pedantic, I have to disagree with you here.
The question the user is asking is exactly, "When did this commit enter
_this_ repo?".

Because of the design of git, such a question must be converted into a
question regarding reflogs and head/branch values etc...  But the user
doesn't care anything about all that.  They're just interested in the
date/time the commit was published in the repository in question, not
the date time the commit was originally created in some distant
repo.

Sean
