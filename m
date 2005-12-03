From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] daemon whitelist handling (Re: git pull aborts in 50% of
 cases)
Date: Sat, 3 Dec 2005 11:56:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512031156070.3099@g5.osdl.org>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru> <43909963.60901@zytor.com>
 <20051202211250.GA11384@mipter.zuzino.mipt.ru> <4390B64E.20601@zytor.com>
 <Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>
 <7vpsoezf6y.fsf@assigned-by-dhcp.cox.net> <7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
 <4391F4DD.2060002@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:58:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EidVL-0006KO-D8
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVLCT5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVLCT5E
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:57:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750918AbVLCT5D (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 14:57:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB3JucDZ019089
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Dec 2005 11:56:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB3JubFH007416;
	Sat, 3 Dec 2005 11:56:37 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4391F4DD.2060002@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13165>



On Sat, 3 Dec 2005, H. Peter Anvin wrote:
> 
> At the very least, if you insist on using getcwd() names, you should
> pre-canonicalize the whitelist, too.

That would probably solve the problem and sounds like the right 
user-friendly solution.

		Linus
