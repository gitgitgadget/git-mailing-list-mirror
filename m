From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix path-limited "rev-list --bisect" termination condition.
Date: Fri, 23 Mar 2007 15:39:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703231538270.6730@woody.linux-foundation.org>
References: <7vtzwboc6v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703231524520.6730@woody.linux-foundation.org>
 <7vps6zoal0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 23:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUsQQ-0003lz-Vc
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 23:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbXCWWjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbXCWWjl
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 18:39:41 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42526 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbXCWWjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 18:39:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2NMdb1o002613
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Mar 2007 15:39:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2NMdaEQ026333;
	Fri, 23 Mar 2007 15:39:37 -0700
In-Reply-To: <7vps6zoal0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.469 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42970>



On Fri, 23 Mar 2007, Junio C Hamano wrote:
>
> Is this the only issue you know about with respect to the
> BISECT_NAMES?  You earlier said it was broken and suggested to
> remove it,...

That ending condition was the only one I knew about. If you have checked 
that it works now, I say "keep it". At worst, it just points to the wrong 
commit because people gave the wrong list of filenames, but hey, let's 
burn that bridge when we get to it.

		Linus
