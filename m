From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: file rename causes history to disappear
Date: Wed, 6 Sep 2006 12:06:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061205100.27779@g5.osdl.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
 <44FEED4B.30909@garzik.org> <Pine.LNX.4.64.0609060858050.27779@g5.osdl.org>
 <edmvfv$lt7$2@sea.gmane.org> <Pine.LNX.4.64.0609061131100.27779@g5.osdl.org>
 <edn5dd$c4s$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 21:06:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2j4-00087a-0P
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 21:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWIFTGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIFTGP
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 15:06:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751224AbWIFTGO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 15:06:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86J6BnW017626
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 12:06:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86J66be020814;
	Wed, 6 Sep 2006 12:06:09 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edn5dd$c4s$2@sea.gmane.org>
X-Spam-Status: No, hits=-0.495 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26552>



On Wed, 6 Sep 2006, Jakub Narebski wrote:
> 
> But --follow=<filename> with <pathspec> can be useful, e.g. when <pathspec> 
> is a directory (or, perhaps in the future, glob), which would mean "follow
> the contents indicated in starting hash by <filename>, and stop following
> when it falls out outside given <pathspec>, in our case given directory".

Yes, that would indeed make sense. The pathspec ends up being kept as a 
"limiter", and basically tells you what the "context" for following is 
allowed to be. 

Color me convinced.

		Linus
