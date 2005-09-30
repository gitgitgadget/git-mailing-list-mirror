From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 09:39:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509300937130.3378@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <200509292108.11092.oliver@neukum.org>
 <1128022473.14595.6.camel@cashmere.sps.mot.com> <200509292138.26183.oliver@neukum.org>
 <7vslvn6m6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Oliver Neukum <oliver@neukum.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 18:41:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELNv3-0003Jp-IT
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 18:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVI3Qj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbVI3Qj2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 12:39:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030367AbVI3Qj1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2005 12:39:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8UGdJ4s008516
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Sep 2005 09:39:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8UGdIT5012082;
	Fri, 30 Sep 2005 09:39:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslvn6m6y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9566>



On Fri, 30 Sep 2005, Junio C Hamano wrote:
> 
> I wonder what that 32-byte small file called 'index' is doing
> there.  If this is the kernel tree, its index file should weigh
> about 1.7MB if I recall correctly.

32 bytes is what you get for an empty index (it's a 12-byte header, 
followed by a 20-byte SHA1 of the contents).

In general, such an index file it should be 100% equivalent to not having 
an index file at all.

		Linus
