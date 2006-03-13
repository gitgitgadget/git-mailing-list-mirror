From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 22:46:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603122245360.3618@g5.osdl.org>
References: <20060311192954.GQ16135@artsapartment.org>
 <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org>
 <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com>
 <4414E000.9030902@zytor.com> <4414F6B1.9080107@gmail.com>
 <Pine.LNX.4.64.0603122103440.3618@g5.osdl.org> <44151330.7020905@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Mar 13 07:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIgom-0008Ps-L9
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 07:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWCMGqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 01:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCMGqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 01:46:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751772AbWCMGqI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 01:46:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D6k6DZ017101
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 22:46:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D6k5E7030181;
	Sun, 12 Mar 2006 22:46:05 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <44151330.7020905@zytor.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17556>



On Sun, 12 Mar 2006, H. Peter Anvin wrote:
>
> On "real" machines, the biggest reason you'd care is that a lot of compilers,
> *especially* in C++ mode, really still define NULL as "0"; ostensibly because
> defining it as "((void *)0)" breaks some obscure C++ casting rule.

Agreed. gcc has fixed that rule, but others have not. Don't compile git 
as C++.

		Linus
