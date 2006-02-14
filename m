From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 10:26:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141008220.3691@g5.osdl.org>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <pan.2006.02.14.17.47.53.126690@canit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 19:27:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F94tE-0003CP-RE
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWBNS0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWBNS0j
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:26:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422759AbWBNS0j (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 13:26:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EIQXDZ023193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 10:26:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EIQWLQ020400;
	Tue, 14 Feb 2006 10:26:32 -0800
To: Kenneth Johansson <ken@canit.se>
In-Reply-To: <pan.2006.02.14.17.47.53.126690@canit.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16152>



On Tue, 14 Feb 2006, Kenneth Johansson wrote:
> 
> What I ended up doing was going nee deep into the plumbing.
> 
> first doing cat on the tag in .git/refs/tags/ 
> taking the output as an argument to  "git-read-tree"
> followed by "git-update-index --replace" and "git-checkout-index -a -f -u"
> 
> I'm not sure that many people will understand that they want git-reset for
> this just reading the man pages.

Hey, but I bet you now as a result feel you really understand git, right? 

;)

You did it the old-fashioned way - the way real men did it back in June.

In general, doing "ls *.sh" in the git source tree shows you pretty much 
every command that you might ever want to use. Using the actual core git 
binaries directly is normally not all that useful, unless you want to do 
some strange shell pipeline to do statistics about different things in the 
tree.

		Linus
