From: David Miller <davem@davemloft.net>
Subject: Re: Reporting bugs and bisection
Date: Sun, 13 Apr 2008 23:39:59 -0700 (PDT)
Message-ID: <20080413.233959.217341225.davem@davemloft.net>
References: <20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
	<20080413232441.e216a02c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: viro@ZenIV.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: akpm@linux-foundation.org
X-From: netdev-owner@vger.kernel.org Mon Apr 14 08:40:49 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIMv-0002QX-6q
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 08:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYDNGkA (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 02:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbYDNGj7
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 02:39:59 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46546
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753480AbYDNGj6 (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 02:39:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id CDDEEC8CA9A;
	Sun, 13 Apr 2008 23:39:59 -0700 (PDT)
In-Reply-To: <20080413232441.e216a02c.akpm@linux-foundation.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79464>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 13 Apr 2008 23:24:41 -0700

> Do you agree with these impressions, or not?

I think things are improving.

I wrote or merged in ~10 bugs in the last hour, for example.

And I also agree with Al's point, which was embedded in his humorous
and obviously sarcastic suggestions, in that adding beurocracy isn't
the answer.  We already have too much and it scares developers away.

Sure you don't want crap getting into the tree (for too long), but it
is important to be careful to define crap properly.  For example,
inundating patch submitters with more requirements, especially ones
involving automatons like checkpatch, is in the end bad.

We can improve the quality of stuff going in and be flexible at the
same time.
