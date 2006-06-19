From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add specialized object allocator
Date: Mon, 19 Jun 2006 13:30:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606191327240.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606191028540.5498@g5.osdl.org>
 <7vejxl9bi0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 22:30:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsQOP-0006qe-4p
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 22:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWFSUai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWFSUai
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 16:30:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750968AbWFSUah (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 16:30:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5JKUVgt007705
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Jun 2006 13:30:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5JKUUcf011308;
	Mon, 19 Jun 2006 13:30:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejxl9bi0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22137>



On Mon, 19 Jun 2006, Junio C Hamano wrote:
>
> Impressed.  I wonder if we want to deal with any_object
> structure as well.

Well, it would certainly be very easily doable, but none of the core code 
actually uses it, so it wasn't even on my radar. 

		Linus
