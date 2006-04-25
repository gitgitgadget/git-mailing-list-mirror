From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 11:26:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
 <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 20:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSF9-0002R6-NR
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDYS0c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWDYS0c
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:26:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932154AbWDYS0b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 14:26:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PIQRtH018022
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 11:26:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PIQQ7x032720;
	Tue, 25 Apr 2006 11:26:26 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19163>



On Tue, 25 Apr 2006, sean wrote:

> On Tue, 25 Apr 2006 11:08:31 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Which is exactly what I told you to do. Just don't make it a git header. 
> 
> Well I just don't see how making it a header, or plopping it at the
> end of a commit message makes an iota of difference to git, while it 
> can help porcelain.

It can't help porcelain.

If we have undefined or bad semantics for it, the only thing it can do is 
_hurt_ porcelain, because it will cause confusion down the line.

Semantics for data objects are _the_ most important part of a SCM. Pretty 
much any project, in fact. 

And bad or weakly defined semantics will invariably cause problems later.

> But that's exactly the point, it's no different than extending git to be
> able to store more than one comment.

So why argue for it?

Just use the existing comment field.

		Linus
