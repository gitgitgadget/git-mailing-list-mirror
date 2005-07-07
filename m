From: Chris Wright <chrisw@osdl.org>
Subject: Re: BUG:  "rpmbuild -ta cogito-0.12.tar.gz" fails
Date: Thu, 7 Jul 2005 10:26:16 -0700
Message-ID: <20050707172615.GJ9046@shell0.pdx.osdl.net>
References: <dah8i2$c8v$1@sea.gmane.org> <20050707062019.GL5324@shell0.pdx.osdl.net> <42CD2859.10608@research.att.com> <20050707170748.GN5324@shell0.pdx.osdl.net> <42CD64F9.1010304@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 19:35:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqaFe-0005L6-7b
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 19:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVGGRc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 13:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGGR23
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 13:28:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8163 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261511AbVGGR0V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 13:26:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67HQGjA026395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 10:26:16 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67HQGG4013409;
	Thu, 7 Jul 2005 10:26:16 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j67HQGIT013408;
	Thu, 7 Jul 2005 10:26:16 -0700
To: John Ellson <ellson@research.att.com>
Content-Disposition: inline
In-Reply-To: <42CD64F9.1010304@research.att.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* John Ellson (ellson@research.att.com) wrote:
> So now I have to ask, where does that come from if its not created by 
> "make dist" ?

It's automated by kernel.org mirroring (along with signature
generation).  So .gz is built, uploaded, the rest is automatic.

> Is what I'm asking to do in the above sequence somehow unreasonable?   
> Would it
> be any loss if the Source: line in cogito.spec.in refered to the .gz 
> instead of the .bz2 such that the
> above sequence works for those of us that like to build rpms directly 
> from the git tree?

Yes, I've got a patch for the spec.in, I'll toss that in.

> Alternatively, perhaps "make dist" could generate the .bz2 instead?

No, because of the way kernel.org mirroring works.

thanks,
-chris
