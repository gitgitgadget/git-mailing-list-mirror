From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Add basic infrastructure to assign attributes to
 paths
Date: Fri, 13 Apr 2007 08:04:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130804020.28042@woody.linux-foundation.org>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 17:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcNKG-0000mj-48
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 17:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbXDMPEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbXDMPEd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 11:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36270 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbXDMPEc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 11:04:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DF4TIs022166
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 08:04:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DF4S23002470;
	Fri, 13 Apr 2007 08:04:28 -0700
In-Reply-To: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44410>



On Fri, 13 Apr 2007, Junio C Hamano wrote:
>
> This adds the basic infrastructure to assign attributes to
> paths, in a way similar to what the exclusion mechanism does
> based on $GIT_DIR/info/exclude and .gitignore files.

Me likee. The patches look much simpler/cleaner than I expected.

		Linus
