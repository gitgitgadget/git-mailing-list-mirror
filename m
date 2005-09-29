From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Thu, 29 Sep 2005 09:07:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509290907040.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509280819000.3308@g5.osdl.org> <7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509281007200.3308@g5.osdl.org> <7v3bnpt81e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509281106370.3308@g5.osdl.org> <7vfyrprqr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL0x6-0007fU-9B
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVI2QID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVI2QID
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 12:08:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932222AbVI2QIC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 12:08:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TG7s4s012630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 09:07:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TG7oZd024039;
	Thu, 29 Sep 2005 09:07:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyrprqr6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9489>



On Wed, 28 Sep 2005, Junio C Hamano wrote:
> 
> Hopefully that would be rectified when git-daemon goes on-line,
> now I've merged updates from HPA ;-).

Yes, the git-daemon will help. However, it won't fix the lag from 
master.kernel.org to the slaves, so I'd probably still have to re-write 
things if there are mirror delays..

		Linus
