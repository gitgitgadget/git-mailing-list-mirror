From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git hangs while executing commit-tree
Date: Wed, 20 Apr 2005 14:48:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201446510.6467@ppc970.osdl.org>
References: <200504202228.35652.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:43:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMy0-0002bM-3N
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVDTVqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVDTVqz
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:46:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:37050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbVDTVqx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:46:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KLkJs4008109
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 14:46:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KLkIgD030309;
	Wed, 20 Apr 2005 14:46:18 -0700
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
In-Reply-To: <200504202228.35652.rhys@rhyshardwick.co.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Rhys Hardwick wrote:
>
> rhys@metatron:~/repo/tmp.repo$ commit-tree  c80156fafbac377ab35beb076090c8320f874f91
> Committing initial tree c80156fafbac377ab35beb076090c8320f874f91
>  
> At this point, the command seems to be just waiting.

That's _exactly_ what it's doing. It's waiting for you to write a commit 
message.

Something like

	This is my initial commit of Hello World!
	^D

will make it happy.

Alternatively, you can certainly just write your message beforehand with 
an editor and just pipe it into commit-tree.

			Linus
