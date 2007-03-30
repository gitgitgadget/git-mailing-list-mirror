From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 13:06:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703301256230.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
 <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
 <Pine.LNX.4.60.0703301855480.4757@poirot.grange>
 <Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org>
 <Pine.LNX.4.60.0703302135590.10784@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXNMj-0005DQ-Rx
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 22:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbXC3UG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 16:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbXC3UG1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 16:06:27 -0400
Received: from smtp.osdl.org ([65.172.181.24]:50544 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbXC3UG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 16:06:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2UK6DrF008383
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Mar 2007 13:06:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2UK6B8Q003782;
	Fri, 30 Mar 2007 13:06:12 -0700
In-Reply-To: <Pine.LNX.4.60.0703302135590.10784@poirot.grange>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 30 Mar 2007, Guennadi Liakhovetski wrote:
> 
> And, so, it's a pity I cloned Paul's tree yesterday with the "old" git. 
> And from your answer above it seems like some features of the "new" git 
> will not be available with this tree, like equally named local and remote 
> branches, etc. There isn't a way to convert such a "old style" tree to the 
> "new style", is there? Not a big deal, will re-clone at some point, maybe 
> when we get local git mirrors...

There's a conversion script to help you convert in place if you care.

Look at the git list for an email that looks something like this:

	Date: Wed, 14 Mar 2007 02:16:12 -0400
	From: Shawn O. Pearce <spearce@spearce.org>
	To: git@vger.kernel.org
	Subject: Upgrade to 1.5.0 utility

	Yesterday on #git DrNick wanted a script to update a pre-1.5.0
	Git repository to be like a 1.5.0 (and later) style repository.
	...

which has a script in it to do this (it uses another script that is 
already in git/contrib/ that just moves all the ".git/remotes" entries 
as-is from the remotes files into the .git/config file)

I haven't tested it myself, so caveat emptor. But the config file format 
really isn't *that* complicated - do the conversion with the script, and 
then just go back and look at .git/config and verify that it looks sane, 
or edit it to match your taste.

		Linus
