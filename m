From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Questions about git-rev-parse
Date: Wed, 28 Feb 2007 08:00:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702280751000.12485@woody.linux-foundation.org>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org> <20070228025258.GD2178@thunk.org>
 <Pine.LNX.4.64.0702271921110.12485@woody.linux-foundation.org>
 <200702280854.32440.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:00:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRE9-000401-4e
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbXB1QAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbXB1QAS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:00:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59171 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbXB1QAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:00:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SG0BhB018876
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 08:00:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SG0AUV019087;
	Wed, 28 Feb 2007 08:00:10 -0800
In-Reply-To: <200702280854.32440.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.441 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40953>



On Wed, 28 Feb 2007, Andy Parkins wrote:
> 
> Funny; I'd always guessed that it came from Lord of the Rings, which (I think) 
> often mentioned "Ent-ish" as being the language of the trees.

Yeah, we for a while had that overly geekish thing, but we didn't use 
"entish", we used just "ent". Because an "ent" is "tree-ish".

So when we used "ent", we didn't have the "-ish" there at all, and at some 
point all the ents got search-and-replaced into "tree-ish".

But "treeish" actually came before, and the "ent" thing was just a 
temporary pun that got dropped.

Looking at the git log, the first time we use "tree-ish" is fairly early: 
apparently May 5, 2005. Commit ac4e0869 introduces it instead of 
<tree/commit> (probably because the tag part got added, and to explain 
that we only care about the resulting tree and won't actually *use* any 
of the commit/tag information except to get to it).

			Linus
