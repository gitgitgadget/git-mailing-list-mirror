From: James Morris <jmorris@namei.org>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 01:54:00 +1000 (EST)
Message-ID: <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org>
 <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl>
 <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net>
 <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu>
 <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org>
 <20080414072328.GW9785@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 18:12:48 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlR2o-0000rt-Ch
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 17:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbYDNPzu (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 11:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbYDNPzt
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 11:55:49 -0400
Received: from namei.org ([69.55.235.186]:52383 "EHLO us.intercode.com.au"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752532AbYDNPzr (ORCPT <rfc822;netdev@vger.kernel.org>);
	Mon, 14 Apr 2008 11:55:47 -0400
Received: from us.intercode.com.au (us.intercode.com.au [69.55.235.187])
	by us.intercode.com.au (8.12.11.20060308/8.12.11) with ESMTP id m3EFs047009080;
	Mon, 14 Apr 2008 08:54:06 -0700
X-X-Sender: jmorris@us.intercode.com.au
In-Reply-To: <20080414072328.GW9785@ZenIV.linux.org.uk>
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79513>

On Mon, 14 Apr 2008, Al Viro wrote:

> Real review of code in tree and patches getting into the tree.

There is currently little incentive for developers to perform review.  

It's difficult work, and is generally not rewarded or recognized, except 
in often quite negative ways.  There is a small handful of people who do a 
lot of review, but they are exceptional in various ways.

OTOH, writing code is relatively simple, and is much more highly rewarded:

- People tend to get paid to write kernel code, but not so much to review 
  it.

- Things like "who made the kernel" statistics and related articles ignore 
  code review.

- Creating new features is perceived as the highest form of contribution 
  for general developers, and likely important as career currency 
  (similar to the publish or perish model in the academic world).

I don't know how to solve this, but suspect that encouraging the use of 
reviewed-by and also including it in things like analysis of who is 
contributing, selection for kernel summit invitations etc. would be a 
start.  At least, better than nothing.


- James 
-- 
James Morris
<jmorris@namei.org>
