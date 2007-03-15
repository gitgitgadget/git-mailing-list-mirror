From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mercurial to git
Date: Thu, 15 Mar 2007 08:56:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703150854520.3816@woody.linux-foundation.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de>
 <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu>
 <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de>
 <20070315002505.GA31770@thunk.org> <20070315101913.GA9831@peter.daprodeges.fqdn.th-h.de>
 <20070315141227.GA18416@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 15 16:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRsKD-0001HU-7r
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 16:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbXCOP5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbXCOP5F
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 11:57:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:57698 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422901AbXCOP5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 11:57:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2FFv0Ob014239
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Mar 2007 08:57:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2FFuxjl019844;
	Thu, 15 Mar 2007 07:57:00 -0800
In-Reply-To: <20070315141227.GA18416@thunk.org>
X-Spam-Status: No, hits=-0.489 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42289>



On Thu, 15 Mar 2007, Theodore Tso wrote:
>
> (Generated using: hg-fast-export.sh -A ../e2fsprogs.authors -r ../e2fsprogs)
> commit b584b9c57ecbbeef91970ca2924d66662029ab29
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Jan 1 00:00:00 1970 +0000  <=============

Is the committer date ok (does it even exist)? Use "--pretty=fuller" or 
perhaps even "--pretty=raw" to see both author and committer date.

The normal log only shows author date, since that's usually the one people 
care about (git itself doesn't at all, it uses the committer date-stamp to 
do it's "choose most recent path to go down").

		Linus
