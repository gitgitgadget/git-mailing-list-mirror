From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-fetch - repack in the background after fetching
Date: Tue, 30 May 2006 07:53:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605300752430.5623@g5.osdl.org>
References: <11489641631558-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.64.0605292147010.5623@g5.osdl.org> <Pine.LNX.4.64.0605300207130.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 16:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl5b9-00026J-1G
	for gcvg-git@gmane.org; Tue, 30 May 2006 16:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWE3Ox1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWE3Ox1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 10:53:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932296AbWE3Ox1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 10:53:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4UErF2g032741
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 May 2006 07:53:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4UErEUI017140;
	Tue, 30 May 2006 07:53:14 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605300207130.6713@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21032>



On Tue, 30 May 2006, Daniel Barkalow wrote:
> 
> We should be able to fix this, right? If an object isn't found in packs or 
> unpacked, look for new packs; if there are any, look for the object in 
> them; if it's not there, then give up.

Yes. That sounds fine.

		Linus
