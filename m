From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 22:42:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610232239220.3962@g5.osdl.org>
References: <200610221105.26421.jnareb@gmail.com>
 <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net>
 <ehjgli$lft$1@sea.gmane.org> <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org> <20061024002657.GD17019@over-yonder.net>
 <20061024003834.GE17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 24 07:42:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcF3g-0001GS-AF
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 07:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbWJXFme (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 01:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWJXFme
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 01:42:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752066AbWJXFmd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 01:42:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9O5gPaX031276
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 22:42:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9O5gNY7021006;
	Mon, 23 Oct 2006 22:42:24 -0700
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061024003834.GE17019@over-yonder.net>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29924>



On Mon, 23 Oct 2006, Matthew D. Fuller wrote:

> On Mon, Oct 23, 2006 at 07:26:57PM -0500 I heard the voice of
> Matthew D. Fuller, and lo! it spake thus:
> > On Mon, Oct 23, 2006 at 04:24:30PM -0700 I heard the voice of
> > Linus Torvalds, and lo! it spake thus:
> > > 
> > > The problem? How do you show a commit that is _common_ to two
> > > branches, but has different revision names in them?
> > 
> > Why would you?
> 
> I beg your pardon; that was awful ambiguous of me.  I meant "In such a
> case, where the whole purpose of what you're doing is to you're look
> at multiple branches to see relationships between them, why WOULD you
> be using branch-local identifiers for revisions at all?"

Well, I would use the globally unique ones, certainly. It's the only thing 
that makes sense.

However, I'd also argue that once you start doing that, _mixing_ the 
globally unique and stable ones and the "simple" ones is a mistake: you'd 
be better off having told your users to use the global ones from the very 
beginning, and trying to make _those_ as simple to use as possible.

Because once you start using both, you're just going to confuse your users 
horribly, and they'll consider the globally unique one really irritating, 
because they're used to using something totally different in most other 
contexts.

Using the _same_ names everywhere is just better. 

		Linus
