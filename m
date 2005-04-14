From: tony.luck@intel.com
Subject: Re: Date handling.
Date: Thu, 14 Apr 2005 12:19:41 -0700
Message-ID: <200504141919.j3EJJfG04166@unix-os.sc.intel.com>
References: <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
	 <1113466592.12012.192.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504140153230.7211@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504140212100.7211@ppc970.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 21:17:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9pI-0006bq-Du
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDNTTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDNTTz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:19:55 -0400
Received: from fmr24.intel.com ([143.183.121.16]:34465 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261590AbVDNTTx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:19:53 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3EJJf9E019499;
	Thu, 14 Apr 2005 19:19:42 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3EJL2JI004539;
	Thu, 14 Apr 2005 19:21:02 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3EJJfG04166;
	Thu, 14 Apr 2005 12:19:41 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113500316.27227.8.camel@hades.cambridge.redhat.com>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> OK. commit-tree now eats RFC2822 dates as AUTHOR_DATE because that's
> what you're going to want to feed it. We store seconds since UTC epoch,
> we add the author's or committer's timezone as auxiliary data so that
> dates can be pretty-printed in the original timezone later if anyone
> cares.

With a UTC date, why would anyone care in which timezone the commit was
made?  Any pretty printing would most likely be prettiest if it is done
relative to the timezone of the person looking at the commit record, not
the person who created the record.

If we do need the timezone, then I think we also need the latitude of the
committer too, so that we know whether to interpret "July" as summer or
winter :-)

-Tony
