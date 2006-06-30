From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating diff from 2.6.16 from cryptodev-2.6 git tree
Date: Thu, 29 Jun 2006 19:44:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291943010.12404@g5.osdl.org>
References: <44A47BE0.9060504@logix.cz> <20060630013627.GA27527@gondor.apana.org.au>
 <Pine.LNX.4.64.0606291904250.12404@g5.osdl.org> <20060630023228.GA28850@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Ludvig <michal@logix.cz>, linux-crypto@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 04:45:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw907-0000OJ-PC
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 04:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWF3Coz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 22:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWF3Coy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 22:44:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751434AbWF3Cox (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 22:44:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5U2ihnW010639
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 19:44:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5U2ie1P022486;
	Thu, 29 Jun 2006 19:44:41 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20060630023228.GA28850@gondor.apana.org.au>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22949>



On Fri, 30 Jun 2006, Herbert Xu wrote:

> On Thu, Jun 29, 2006 at 07:25:01PM -0700, Linus Torvalds wrote:
> > 
> > The easiest by far is if you only care about a certain sub-directory. 
> > Then, assuming the branch "crypto" is the top-most commit of the cryptodev 
> > repo, just do
> > 
> > 	git diff v2.6.16..crypto -- crypto/
> 
> Yes, you should always do something like this when backporting to make
> sure that you haven't missed patches merged in ways that you didn't
> anticipate.
> 
> Although I'm not aware of any such patches in the time frame that Michal
> has in mind.

Note that this is why

	git log -p --full-diff v2.6.16.. crypto/

is so great. It will show everything that touched that subdirectory, along 
with the incidentals. I think that in this case, that's exactly what 
Michal wants.

		Linus
