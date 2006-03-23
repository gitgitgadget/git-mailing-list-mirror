From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Best way to generate a git tree containing only a subset of
 commits from another tree?
Date: Wed, 22 Mar 2006 19:43:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603221932040.26286@g5.osdl.org>
References: <Pine.LNX.4.64.0603221920260.22475@hermes-2.csi.cam.ac.uk>
 <4421EF5F.3000601@op5.se> <7vu09q54a6.fsf@assigned-by-dhcp.cox.net>
 <442213F4.7040603@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Anton Altaparmakov <aia21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 23 04:43:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMGjc-0005LR-2v
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 04:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWCWDni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 22:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWCWDnh
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 22:43:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751036AbWCWDng (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 22:43:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2N3hQDZ030345
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 19:43:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2N3hPQW009911;
	Wed, 22 Mar 2006 19:43:26 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <442213F4.7040603@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17851>



On Thu, 23 Mar 2006, Andreas Ericsson wrote:
> 
> <sidenote>
> I've never understood what orthogonal means in this sense. "at a right angle"
> as in flagging for attention or the exactly counter-productive to what one
> should use?
> </sidenot>

No. Orthogonal in math may be literally "straight angle", but in 
non-geometric speak it means "independent" or "statistically unrelated".

See 

	http://wordnet.princeton.edu/perl/webwn?s=orthogonal

and the two first definitions in particular.

Ie two issues (or, in this case, "branches") are orthogonal if they have 
nothing in common - they fix two totally independent things.

This is, btw, totally consistent with the geometric meaning of the word. 
Two vectors are orthogonal if they have no common component: the dot 
product is zero (ie the projection of one vector onto another is the null 
vector).

So if you see two lines of development as being "vectors" from a common 
source, when they have nothing in common, they are orthogonal.

Of course, the development space is neither three-dimensional nor 
euclidian, so it's a strange kind of vector, but still ;)

		Linus
