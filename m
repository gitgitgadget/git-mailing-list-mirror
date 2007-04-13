From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some index-base bug in "next" branch ("git-applymbox"-related?)..
Date: Thu, 12 Apr 2007 18:15:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121812440.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
 <7vbqhti0nr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 03:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcAOE-0006FP-Dz
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 03:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbXDMBPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbXDMBPp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 21:15:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40055 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbXDMBPo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 21:15:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3D1FfIs031152
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 18:15:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3D1FeQY021577;
	Thu, 12 Apr 2007 18:15:40 -0700
In-Reply-To: <7vbqhti0nr.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44376>



On Thu, 12 Apr 2007, Junio C Hamano wrote:
> 
> This will teach applymbox the index base safety, but it shows
> that the division between applymbox and applypatch makes things
> less efficient than how git-am can do the same.

Hey, I'd happily use git-am too..

If you want to deprecare git-applymbox, why don't you just make it an 
alias for git-am, potentially doing the defaults and command line argument 
conversion?

I certainly don't care about the *implementation* details. As long as my 
mailbox applicator continues to work ;)

			Linus
