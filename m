From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 7/6] Leftover bits.
Date: Wed, 27 Apr 2005 10:37:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271036150.18901@ppc970.osdl.org>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> <7v4qdsiqgl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 19:32:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqMq-0001e7-TO
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVD0Rfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 13:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVD0Rfc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 13:35:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:28050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbVD0RfT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 13:35:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RHZCs4027732
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 10:35:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RHZB1M028171;
	Wed, 27 Apr 2005 10:35:12 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qdsiqgl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Junio C Hamano wrote:
> 
> It also adds code to unlink temporary files used to call the
> external diff command upon SIGNIT.

Actually, you should probably do SIGPIPE too. I suspect that's the much
more common case (somebody does a "diff-tree | less", and then quits).

		Linus
