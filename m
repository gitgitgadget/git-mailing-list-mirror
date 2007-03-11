From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 14:13:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703111410520.9690@woody.linux-foundation.org>
References: <20070311043250.GA21331@moooo.ath.cx> <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703111326170.9690@woody.linux-foundation.org>
 <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVLz-0000rj-OM
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbXCKVNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbXCKVNQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:13:16 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58435 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488AbXCKVNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:13:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2BLDAo4012005
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Mar 2007 14:13:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2BLD9gS019793;
	Sun, 11 Mar 2007 13:13:10 -0800
In-Reply-To: <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.986 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41984>



On Sun, 11 Mar 2007, Junio C Hamano wrote:
> 
> That is a good example usage schenario; we would need to think
> about what to do with .gitignore (and .gitattributes if we will
> have that in-tree), though.

Good point. That's a real problem.

I guess you could say that for this kind of usage scenario you only want 
to use the per-repository .git/ignore file, or maybe have some way of 
specifying the name of the .gitignore file per repository.

Hmm. I'm not sure it was a great idea. I still like the concept, but 
you're right, it's not without its problems.

		Linus
