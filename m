From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 14:09:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261402470.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
 <Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org> <7v64x5bt9n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbPcC-0007ra-KJ
	for gcvg-git@gmane.org; Thu, 26 May 2005 23:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVEZVLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 17:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVEZVLP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 17:11:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:53712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261795AbVEZVHl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 17:07:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4QL7RjA003123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 14:07:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4QL7QeK013576;
	Thu, 26 May 2005 14:07:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64x5bt9n.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Junio C Hamano wrote:
> 
> So what do you want from me at this point?  Nothing?

Yeah, I'm happy. Sorry for the false alarm.

Anyway, at this point

	git-apply --stat

is actually already useful: it's a diffstat clone. Which is perhaps not
very useful in itself, but it has the advantage of being an easy way to
check that I do the right thing there, and may well be useful also for the
git-specific extensions (ie right now it's really purely a diffstat clone,
but there's nothign that says that it couldn't show rename information etc 
too, which diffstat doesn't understand).

		Linus
