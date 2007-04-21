From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] WTF did we change in git-fsck recently?
Date: Fri, 20 Apr 2007 18:24:13 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704201823310.9964@woody.linux-foundation.org>
References: <7vps5ywouw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 03:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf4LE-00089T-BC
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 03:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbXDUBYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 21:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbXDUBYl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 21:24:41 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:52640 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754028AbXDUBYl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 21:24:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3L1OEgo020920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2007 18:24:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3L1ODQF028254;
	Fri, 20 Apr 2007 18:24:13 -0700
In-Reply-To: <7vps5ywouw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.544 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45144>



On Fri, 20 Apr 2007, Junio C Hamano wrote:
>
> I noticed that "git-fsck --full" from 'master' takes forever to
> fsck the kernel repository (I left it running for 2 hours before
> killing it), while the one from 'maint' (or 1.5.1.1 which is
> installed on kernel.org) finishes within 2 or 3 minutes.  There
> is some serious breakages there.

Hmm. Probably something broken in my "object decorator" thing then. 

Will check it out, I hadn't noticed myself.

		Linus
