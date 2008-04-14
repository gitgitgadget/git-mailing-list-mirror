From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 16:05:13 -0700
Message-ID: <20080414160513.9f57e5ba.akpm@linux-foundation.org>
References: <20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
	<20080414.150105.101568769.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jmorris@namei.org, viro@ZenIV.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Tue Apr 15 01:20:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlXyJ-00070k-5R
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 01:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbYDNXTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 19:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbYDNXTW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 19:19:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50910 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752286AbYDNXTV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 19:19:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3EN5FuD008338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Apr 2008 16:05:17 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3EN5DZD031543;
	Mon, 14 Apr 2008 16:05:13 -0700
In-Reply-To: <20080414.150105.101568769.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.762 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79538>

On Mon, 14 Apr 2008 15:01:05 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: James Morris <jmorris@namei.org>
> Date: Tue, 15 Apr 2008 01:54:00 +1000 (EST)
> 
> > - Things like "who made the kernel" statistics and related articles ignore 
> >   code review.
> 
> Note the apparent irony in that the person who ends up often on the
> top of those lists, Al Viro, is also someone who also does a
> significant amount of code review.
> 
> I think this is no accident.

"who made the kernel" was an interesting and useful exercise, but if you
like irony then...

- The way to boost your commit count is to submit buggy patches and to
  then fix your own bugs.

- The way to lower your commit count is to fix things in other people's
  patches, then fold your fix into the base patch.  I've lost over 1000
  commits that way.  Unless they are counting '^    [akpm' as a commit.
