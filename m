From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kompare won't parse git diffs
Date: Wed, 2 Aug 2006 13:51:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608021349580.4168@g5.osdl.org>
References: <200608021107.43485.andyparkins@gmail.com>
 <Pine.LNX.4.64.0608021006150.4168@g5.osdl.org> <eaqpt2$ots$1@sea.gmane.org>
 <Pine.LNX.4.64.0608021207360.4168@g5.osdl.org> <ear19d$j9p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:51:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Ngv-0002TN-Ft
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWHBUvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWHBUvm
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:51:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbWHBUvm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:51:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k72KpZnW028734
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 2 Aug 2006 13:51:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k72KpYtt002205;
	Wed, 2 Aug 2006 13:51:34 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ear19d$j9p$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24685>



On Wed, 2 Aug 2006, Jakub Narebski wrote:
> 
> What about putting e.g. sha1 (or abbreviated sha1) of blob if file exist 
> in repository, "(in index)" or "(working area)" in two other cases, instead
> of date or file version?

Quite frankly, it will just break the current git header standard, and 
make diffs look uglier.

Just get kompare fixed instead. If you want to use it with git, you would 
really want it to know about all the other git diff extensions too anyway, 
and right now it's _buggy_ for requiring a tab where none needs to be.

If "patch" doesn't want the tab, then dammit, neither should kompare.

			Linus
