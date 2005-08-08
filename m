From: Chris Wright <chrisw@osdl.org>
Subject: Re: Request for help from binary packaging people.
Date: Mon, 8 Aug 2005 15:21:19 -0700
Message-ID: <20050808222119.GE7762@shell0.pdx.osdl.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <20050808185858.GC8041@shell0.pdx.osdl.net> <7vbr482ik5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:22:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Fzx-0001oJ-AQ
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 00:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVHHWVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 18:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVHHWVa
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 18:21:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932286AbVHHWVa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 18:21:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j78MLJjA016442
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 15:21:20 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j78MLJb7030464;
	Mon, 8 Aug 2005 15:21:19 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j78MLJq8030463;
	Mon, 8 Aug 2005 15:21:19 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr482ik5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano (junkio@cox.net) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > ...  Also, rpm is able to determine the perl dependencies
> > automatically (of course, ditto for shared libraries).
> 
> I take it to mean that we do not have to explicitly list perl
> module dependencies.  If that is the case then I presume that
> the current dependency list is fine.

That's correct.  The only benefit to itemzing the package level dependency in
this case is just for an error message that tells you which package
you're missing rather than the low-level perl module.

thanks,
-chris
