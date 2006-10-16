From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 09:57:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160956360.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160932100.7697@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:57:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVmV-0002AE-C4
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWJPQ5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWJPQ5f
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:57:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422731AbWJPQ5e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 12:57:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GGvQaX008286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 09:57:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GGvPOd020107;
	Mon, 16 Oct 2006 09:57:25 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610160932100.7697@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28975>



On Mon, 16 Oct 2006, Davide Libenzi wrote:
>
> I think the xdl_hashbits() picks up the hash table size "almost" 
> correctly. I think we're looking at some bad hash *collisions* (not 
> records with same hash value, that'd be stopped by the mlim check). 
> Send me the files and I'll take a look ...

Davide, they were mentioned in the original report:

	http://meyering.net/code/git-perf/configure.gz
	http://meyering.net/code/git-perf/configure-curr.gz

I'd take a look myself, but I need to run..

		Linus
