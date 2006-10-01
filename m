From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Sat, 30 Sep 2006 17:13:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609301712340.3952@g5.osdl.org>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
 <Pine.LNX.4.64.0609272232040.9349@xanadu.home> <7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281029300.9349@xanadu.home> <7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
 <20060930045037.GB18479@spearce.org> <7v4pupizix.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609301033460.3952@g5.osdl.org> <7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 02:13:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GToxS-0007HK-2v
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 02:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWJAANW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 20:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWJAANW
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 20:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751775AbWJAANV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 20:13:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k910DGaX018773
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Sep 2006 17:13:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k910DFsb003080;
	Sat, 30 Sep 2006 17:13:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.447 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28164>



On Sat, 30 Sep 2006, Junio C Hamano wrote:
> 
> However, I think the traditional "find the closest ancestor"
> behaviour and ref-log behaviour are mutually incompatible, while
> they both return information to help address similar issues to
> the end user when viewed at a very high level.
> 
> Especially, "find the closest ancestor" behaviour means when you
> get "tag-gXXXX" as an answer, the tag proper does _not_ contain
> the given commit (e.g. commit v1.4.2-g4839bd8 is not part of
> v1.4.2).

Correct.

But that just means that we should take the _next_ one in the time-ordered 
list, no?

		Linus
