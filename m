From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-applymbox fails to extract patch.
Date: Thu, 9 Mar 2006 21:35:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603092130030.18022@g5.osdl.org>
References: <20060310050446.GA20764@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 06:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHaHp-0001cJ-19
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 06:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWCJFfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 00:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbWCJFfe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 00:35:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751651AbWCJFfd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 00:35:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2A5ZCDZ018912
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 21:35:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2A5ZB3p001921;
	Thu, 9 Mar 2006 21:35:11 -0800
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060310050446.GA20764@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17456>



On Fri, 10 Mar 2006, Dave Jones wrote:
> 
> What am I missing ?

Do you have "Content-Type:" headers with a multi-part boundary? That can 
cause it.

Also, empty X-IMAP messages at the beginning of a mbox (pine does those, 
others probably do too) will cause things like that. The extra "email" 
will have no patch in it..

		Linus
