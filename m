From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: New git commit tool
Date: Mon, 4 Sep 2006 14:40:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609041435311.27779@g5.osdl.org>
References: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0609040952550.27779@g5.osdl.org> <17660.39046.767944.582869@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 23:40:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKMB6-0000w1-FW
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 23:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWIDVkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWIDVkU
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 17:40:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964996AbWIDVkT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 17:40:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k84LeGnW015268
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Sep 2006 14:40:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k84LeGaC003394;
	Mon, 4 Sep 2006 14:40:16 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17660.39046.767944.582869@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26435>



On Tue, 5 Sep 2006, Paul Mackerras wrote:
> 
> I was calling it "gitt" for a long time, which is at least shorter and
> easier to type.  I also thought of "tick" (anagram of tk + "ci" for
> check in), but maybe all that shows I've been doing too many cryptic
> crosswords lately. :)  The "gitool" was by analogy with the "citool"
> of another system we've both used.  I'm happy to change it if someone
> has a better idea...

I had kind of expected more of an integration with gitk, and just using 
"gitk" as the generic name for "git tk interface", it would perhaps make 
more sense to just interface it that way, and thus one logical (?) thing 
to do would be to just make the command be

	gitk commit

the same way we have "git commit". Hmm?

But maybe I'm just strange.

		Linus
