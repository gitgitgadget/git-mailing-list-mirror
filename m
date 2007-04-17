From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 20:00:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704161959230.5473@woody.linux-foundation.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org>
 <Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org>
 <20070417022154.GC30340@thunk.org> <f01b9g$qqc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 05:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hddvm-0007Fm-9P
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 05:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031058AbXDQDAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 23:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031061AbXDQDAb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 23:00:31 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33322 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031058AbXDQDAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 23:00:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H30PIs014784
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 20:00:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H30Oum018735;
	Mon, 16 Apr 2007 20:00:24 -0700
In-Reply-To: <f01b9g$qqc$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.451 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44713>



On Tue, 17 Apr 2007, Jakub Narebski wrote:
> 
> You have to use --abbrev-commit (--abbrev is opassed to log machinery, and
> covers object ids), which is undocumented option (mentioned only in passing
> in git-reflog(1)).

Yeah, it's irritated me often enough that I think we should just make 
"--abbrev" set "--abbrev-commit" too.

		Linus
