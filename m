From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git web broken, or Linus' kernel tree in odd state
Date: Sat, 15 Apr 2006 12:03:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604151201230.3701@g5.osdl.org>
References: <12c511ca0604151155j40c68a21qf684f77d2476605b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 21:03:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUq32-0002AZ-BW
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 21:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWDOTDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 15:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWDOTDE
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 15:03:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751104AbWDOTDD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 15:03:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3FJ31tH016415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 15 Apr 2006 12:03:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3FJ31Ep011956;
	Sat, 15 Apr 2006 12:03:01 -0700
To: Tony Luck <tony.luck@intel.com>
In-Reply-To: <12c511ca0604151155j40c68a21qf684f77d2476605b@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18757>



On Sat, 15 Apr 2006, Tony Luck wrote:
>
> Git web is showing the "master" tag four commits back from HEAD on
> the summary page for Linus' kernel tree, which is unusual (isn't it?).

Seems to be some gitweb caching problem.

> I don't think that it is a mirror problem (it's been like it at least
> an hour, and shows the same at both www1 & www2.kernel.org)

It's not a mirroring issue, because if you actually look at the "heads" 
down at the same page, the "master" head points to the right commit (the 
top one). As you can see just from the time ("17 hours ago" right now), 
but also if you just go to the log through there.

		Linus
