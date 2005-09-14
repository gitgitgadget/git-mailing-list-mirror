From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: does git prune packs?
Date: Wed, 14 Sep 2005 08:08:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509140808010.26803@g5.osdl.org>
References: <432805E6.6030905@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 17:09:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFYt7-0004O8-89
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 17:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbVINPI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 11:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVINPI4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 11:08:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965242AbVINPIz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 11:08:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EF8SBo024918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 08:08:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EF8R7G006292;
	Wed, 14 Sep 2005 08:08:28 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <432805E6.6030905@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8528>



On Wed, 14 Sep 2005, Jeff Garzik wrote:
> 
> Does git-prune-packed eliminate packs that have been superceded by other 
> packs?

Nope. Pretty hard to do. Unless you just repack everything, at which point

	git repack -a -d

will do the right thing.

		Linus
