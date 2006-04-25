From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 11:06:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251058490.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <e2lmm3$rts$1@sea.gmane.org> <Pine.LNX.4.64.0604251053100.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 20:07:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYRvr-0006tn-8n
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDYSGh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDYSGg
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:06:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbWDYSGg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 14:06:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PI6XtH017211
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 11:06:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PI6WnP032089;
	Tue, 25 Apr 2006 11:06:33 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0604251053100.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19158>



On Tue, 25 Apr 2006, Linus Torvalds wrote:
> 
> The "track it with pull/push" thing is NOT one such thing, however much 
> you protest. We already _have_ that thing. It's called a "ref", and it's 
> really really easy to create anywhere in .git/refs/, and the tools already 
> know how to use it.

Btw, there are other cases for that. For example, "parent" is a 
well-specified thing that actually has very clear and unambiguous meaning. 

And we had a much better proposals (in the sense that it had real 
suggested _meaning_ and semantics) over the last few months for things 
like sub-projects (trees that point to other commits) or last year a 
discussion about "container objects" (like the current tags, but listing 
multiple objects instead of just one).

All of which had clear and unambiguous semantics (but were not done for 
other reasons - maybe the sub-project still remains on the horizon, the 
"container objects" thing doesn't seem to have gone anywhere).

			Linus
