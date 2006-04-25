From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 11:08:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 20:09:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYRxo-0007Kb-Lk
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWDYSIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWDYSIi
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:08:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932143AbWDYSIh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 14:08:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PI8WtH017348
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 11:08:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PI8V1b032143;
	Tue, 25 Apr 2006 11:08:32 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19159>



On Tue, 25 Apr 2006, sean wrote:

> On Tue, 25 Apr 2006 10:11:13 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Once you start adding data that has no clear semantics, you're screwed. At 
> > that point, it's a "track guesses" game, not a "track contents" game.
> 
> Then shouldn't Git stop tracking commit comments; they're just developer
> guesses. ;o)

No, they are pure content, and git doesn't actually give them any semantic 
meaning.

WHICH IS OK. I even suggested that you put this thing into that "pure 
content" part.

> Adding a free-form header is no different than adding a few more lines 
> of free form text at the bottom of the commit message, in neither case 
> does it change the nice clean git semantics.

Which is exactly what I told you to do. Just don't make it a git header. 

We do that already. Look at "git revert". Ooh. Aah. It works today.

Just don't make it something that changes semantics, and that git parses 
and "understands". Because git clearly doesn't understand it at all, since 
you didn't define it to have any meaning that _can_ be understood.

		Linus
