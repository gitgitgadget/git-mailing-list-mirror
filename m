From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: please pull ppc64-2.6.git
Date: Mon, 29 Aug 2005 10:32:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:33:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9nUb-000756-8Z
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVH2RcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 13:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVH2RcS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 13:32:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbVH2RcR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 13:32:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7THWAjA009151
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 10:32:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7THW9JF013833;
	Mon, 29 Aug 2005 10:32:09 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7907>



On Mon, 29 Aug 2005, Paul Mackerras wrote:
> 
> Please do a pull from:
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/ppc64-2.6.git

Gaah.

This is not a valid git repository.

Guys, if you do partially populated repositories, _please_ make sure that 
you still make it a valid git repository. These days you can trivially do 
so by doing a

	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects > objects/info/alternates

or similar. That also makes gitweb able to show diffs etc, something it 
can't do for a broken partial repository.

Not pulled,

		Linus
