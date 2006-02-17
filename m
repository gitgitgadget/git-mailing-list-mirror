From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Fri, 17 Feb 2006 07:39:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602170738390.916@g5.osdl.org>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net> <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
 <7vu0ay8v4f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 16:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA7hb-0001JB-4D
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 16:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWBQPjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 10:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWBQPjU
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 10:39:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751136AbWBQPjU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 10:39:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1HFdGDZ027998
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 17 Feb 2006 07:39:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1HFdEmk031714;
	Fri, 17 Feb 2006 07:39:15 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0ay8v4f.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16356>



On Thu, 16 Feb 2006, Junio C Hamano wrote:
> 
> This one has one nasty data corruption bug, which fortunately I
> think I have figured out how to fix.

Circular deltas? What else can go wrong?

		Linus
