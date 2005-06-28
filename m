From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT-CVS sync script
Date: Tue, 28 Jun 2005 12:56:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506281254040.19755@ppc970.osdl.org>
References: <20050628191445.GA27979@lumumba.uhasselt.be>
 <pan.2005.06.28.19.33.40.876796@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 21:52:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnM7N-0005TT-0F
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 21:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVF1T6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVF1T6V
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 15:58:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12674 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261249AbVF1Tzo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 15:55:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SJsEjA013052
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 12:54:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SJs8hg023210;
	Tue, 28 Jun 2005 12:54:11 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>,
	Panagiotis Issaris <takis@lumumba.uhasselt.be>
In-Reply-To: <pan.2005.06.28.19.33.40.876796@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Matthias Urlichs wrote:

> Hi, Panagiotis Issaris wrote:
> 
> > I find the included script useful to easily track a CVS repository in
> > GIT. You can both call it for the initial import and ofcourse for the
> > subsequent resynchronisation with the parent CVS repository (that's what
> > the script's about).
> > 
> Hmm, my Perl script (just posted...) should do the same thing without
> depending on .git* files which may or may not still exist when you do an
> incremental import half a year later.
> 
> Can you test whether that script works for you?

Please do. I'm not proud of my horrid cvs2git thing, and if just one other
user reports "it works for me" I'll happily replace that piece of cr*p
with Matthias' version that looks much nicer (but not being a perl user I
can't judge it any other way than having others say "yeah, that works for
me").

			Linus
