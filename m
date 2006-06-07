From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Wed, 7 Jun 2006 09:17:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606070915220.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
 <1149219593.5521.34.camel@neko.keithp.com> <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
 <1149220518.5521.43.camel@neko.keithp.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
 <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
 <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
 <9e4733910606070830g24a08771i1a332552a95283d1@mail.gmail.com>
 <e66t2v$6hb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 18:17:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo0iu-00043B-75
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 18:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWFGQRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFGQRd
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 12:17:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932277AbWFGQRc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 12:17:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k57GHT2g004611
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Jun 2006 09:17:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k57GHSLh032631;
	Wed, 7 Jun 2006 09:17:28 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e66t2v$6hb$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21441>



On Wed, 7 Jun 2006, Jakub Narebski wrote:
> > Other people have sent me mail saying this may not be as big  as
> > problem as was thought, only documentation people on WIndows may be an
> > issues.
> 
> With 1.4.0 there should be tar files of documentation. For now, one can use
> html and man branches of git.git repository: see the INSTALL file and/or

I think you misunderstood.

My guess is that it's the _mozilla_ documentation people that don't 
necessarily have cygwin and perl, because they don't work with the normal 
build.

Ie there are people who can write user documentation, without them having 
any clue - or caring about - build systems.

			Linus
