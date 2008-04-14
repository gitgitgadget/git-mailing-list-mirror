From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 03:15:30 -0700
Message-ID: <20080414031530.2507660d.akpm@linux-foundation.org>
References: <20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<20080414010412.c42dc560.akpm@linux-foundation.org>
	<20080414.013058.149905948.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: viro@ZenIV.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 12:17:43 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlLkr-0004tn-5j
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 12:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYDNKQu (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 06:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbYDNKQt
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 06:16:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47389 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021AbYDNKQr (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 06:16:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3EAFVbt019665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Apr 2008 03:15:33 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3EAFUaR001068;
	Mon, 14 Apr 2008 03:15:30 -0700
In-Reply-To: <20080414.013058.149905948.davem@davemloft.net>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.759 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79495>

On Mon, 14 Apr 2008 01:30:58 -0700 (PDT) David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Mon, 14 Apr 2008 01:04:12 -0700
> 
> > That all sounds good and I expect few would disagree.  But if it is to
> > happen, it clearly won't happen by itself, automatically.  We will need to
> > force it upon ourselves and the means by which we will do that is process
> > changes.  The thing which is being disparaged as "bureaucracy".
> > 
> > The steps to be taken are:
> > 
> > a) agree that we have a problem
>  ...
> > I have thus far failed to get us past step a).
> 
> A lot of people, myself included, subconsciously don't want to
> get past step a) because the resulting "bureaucracy" or whatever
> you want to call it is perceived to undercut the very thing
> that makes the Linux kernel fun to work on.
> 
> It's still largely free form, loose, and flexible.  And that's
> a notable accomplishment considering how much things have changed.
> That feeling is why I got involved in the first place, and I know
> it's what gets other new people in and addicted too.
> 
> Nobody is "forced" to do anything, and I notice you used the
> word "force" in d) :-)

OK, I was going to let this pass, but I changed my mind.

You carefully deleted my text so that you could misquote it, thereby
flagrantly misrepresenting everything I said.

Here it is again:

: The steps to be taken are:
: 
: a) agree that we have a problem
: 
: b) agree that we need to address it
: 
: c) identify the day-to-day work practices which will help address it (as
:    you have done)
: 
: d) identify the process changes which will force us to adopt those practices
: 
: e) implement those process changes.

Forcing a discipline upon oneself is totally different from having it
forced upon you by someone else.

Each step will need general agreement and buyin, otherwise none of it will
(or should) work.

