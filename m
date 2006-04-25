From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 10:57:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251053100.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <e2lmm3$rts$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 19:58:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYRnM-0005Rf-IH
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 19:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWDYR5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWDYR5u
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 13:57:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932100AbWDYR5t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 13:57:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PHvktH016718
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 10:57:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PHvjM5031773;
	Tue, 25 Apr 2006 10:57:46 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2lmm3$rts$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19157>



On Tue, 25 Apr 2006, Jakub Narebski wrote:
> 
> Erm, further on we did agree 

Hell no "we" didn't.

Since I totally refuse to touch anything like that.

I even told you exactly why, for things like the suggested "cherry-pick" 
thing.

Which still remains the "best" example. And I say "best", because as an 
example it totally sucks. Again, for reasons I made very clear.

The fact is, there is _zero_ reason for this field to exist. Nobody has 
actually mentioned a single use that is really valid and that people can 
agree on across different uses.

So here's the challenge: name _one_ thing that people actually can agree 
on, and that adds real measurable _value_ from a core git standpoint. 
Something where the semantics actually change what git does.

The "track it with pull/push" thing is NOT one such thing, however much 
you protest. We already _have_ that thing. It's called a "ref", and it's 
really really easy to create anywhere in .git/refs/, and the tools already 
know how to use it.

		Linus
