From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 4 Mar 2007 14:26:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703041401030.3953@woody.linux-foundation.org>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703041321290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNz9k-0007SU-CA
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXCDW0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbXCDW0N
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:26:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51104 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbXCDW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:26:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l24MQ6q8029619
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Mar 2007 14:26:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l24MQ57t002605;
	Sun, 4 Mar 2007 14:26:05 -0800
In-Reply-To: <Pine.LNX.4.63.0703041321290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41385>



On Sun, 4 Mar 2007, Johannes Schindelin wrote:
> > 
> > This is to output logs in the GNU ChangeLog format.
> 
> FWIW I am opposed to include that. After letting it sink in, Linus' 
> remarks convinced me that this format is not as useful as our other log 
> formats, and for those people who really want it, there is git2cl.

Side note: I would hate to be the person who torpedoes anything that some 
people actually find useful (my motto: "actually useful is a lot better 
than clean, but not as useful")

So in that sense, if people actually find GNU changelog format to be 
useful enough that they want a script for it, I don't think we should 
relegate it to second-class citizenship just because _we_ don't think it's 
a wonderful format.

The GNU code formatting guidelines are much much worse than the GNU 
changelogs, yet we certainly allow people to check in their braindamage 
into git if they want to. The GNU changelog format isn't horrid, and the 
function names can be even nice as a way of seeing "what does this touch".

The fact that GNU changelog is then mis-designed to do per-file changelogs 
etc is more an effect of CVS misfeatures than anything else. But compared 
to all the other things CVS gets wrong, that's a very small detail ;)

		Linus
