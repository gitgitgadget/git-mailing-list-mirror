From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 15:41:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251539450.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <426D62C0.40104@zytor.com> <Pine.LNX.4.58.0504251457510.18901@ppc970.osdl.org>
 <20050425221810.GM13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:34:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQC9e-0002x8-M7
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 00:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDYWjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 18:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDYWjM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 18:39:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:52677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261254AbVDYWjG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 18:39:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PMd3s4007655
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 15:39:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PMd1o5011605;
	Mon, 25 Apr 2005 15:39:02 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050425221810.GM13467@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Petr Baudis wrote:
> 
> Could we please at least maintain the newline between the "header" and data,
> like in the commit objects?

Yes, I did that in the "git-tag-script" I actually committed, although git 
doesn't currently really care (ie fsck won't complain).

		Linus
