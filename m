From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 6 Sep 2005 00:16:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl> 
 <Pine.LNX.4.58.0509050738340.3504@evo.osdl.org> <46a038f90509051713389c62c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 09:17:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECXhb-0003Qd-BD
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 09:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVIFHRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 03:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVIFHRD
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 03:17:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbVIFHRB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 03:17:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j867GfBo003415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Sep 2005 00:16:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j867Gb4O020814;
	Tue, 6 Sep 2005 00:16:38 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90509051713389c62c8@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8123>



On Tue, 6 Sep 2005, Martin Langhoff wrote:
> 
> Grep knows how to ignore binary files.

That wasn't the _point_.

The point is, naming things as being "scripts" is useful. Grep is just an 
example. Naming things as being ".pl" or ".sh" is _not_ useful.

So with grep you can use -I, but what about doing things like "em *" when
doing global renames (I use micro-emacs - em - as my editor). Again, "em
*-script" actually works.

The point being that if we have naming rules, make them USEFUL. *-script 
is useful - it works wonderfully well for "git xxx" (which knows to add 
"-script"), and it works wonderfully well for developers. 

		Linus
