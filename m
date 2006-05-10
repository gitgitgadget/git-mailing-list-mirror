From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 9 May 2006 21:26:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605092123520.3718@g5.osdl.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605092117240.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 06:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdgHV-00066o-Rw
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWEJE0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWEJE0f
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:26:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964802AbWEJE0f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 00:26:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A4QPtH008504
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 21:26:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A4QOhk001774;
	Tue, 9 May 2006 21:26:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605092117240.3718@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19871>



On Tue, 9 May 2006, Linus Torvalds wrote:
> 
> I think the new binary diff is non-reversible. That's ok right now, since 
> we don't actually support patching in reverse (if you want to get the 
> reverse patch, you need to _diff_ it in reverse and then patch it that 
> way).

Btw, I don't actually know why we don't support "-R". The way git-apply is 
written, it should be totally trivial (just switch old/new around for data 
and line numbers - since it doesn't actually apply the patch directly line 
by line or anything like that) for a normal patch.

So if I read the binary patch right, the lack of "-R" went from "silly 
oversight" to "uhhuh, I don't think the patch format supports it".

Maybe it's not a big deal.

			Linus
