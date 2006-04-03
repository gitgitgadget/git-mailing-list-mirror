From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: n-heads and patch dependency chains
Date: Mon, 3 Apr 2006 07:29:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604030727250.3781@g5.osdl.org>
References: <4430D352.4010707@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 16:29:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQQ3c-000645-Br
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 16:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWDCO3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 10:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWDCO3V
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 10:29:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751398AbWDCO3U (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 10:29:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k33ETIEX028341
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Apr 2006 07:29:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k33ETHnM019256;
	Mon, 3 Apr 2006 07:29:18 -0700
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <4430D352.4010707@vilain.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18331>



On Mon, 3 Apr 2006, Sam Vilain wrote:
> 
> "Patch dependency chains", the best plain-English term we could find for
> the scary sounding darcs term "patch calculus", are said by some to be a
> very good reason to use a system like darcs, even to some its
> fundamental advantage over systems such as git.

I really think that darcs is just "nice theory", and has nothing to do 
with real life.

Terms like "patch calculus" may sound cool and useful, but let's face it, 
the proof is in the pudding, and quite frankly, I would bet that trying to 
do something like that on a real project would just be a total disaster.

I want my merges simple. I want them to take a couple of seconds. I don't 
want to see strange patch dependencies that nobody cares about. And I very 
much don't want to see theory over practice.

		Linus
