From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list bug?
Date: Fri, 10 Mar 2006 10:31:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603101030160.18022@g5.osdl.org>
References: <b0943d9e0603080819i227c637fo@mail.gmail.com>
 <7vacc0iten.fsf@assigned-by-dhcp.cox.net> <7vmzfy1zjb.fsf@assigned-by-dhcp.cox.net>
 <7virqmzlhb.fsf@assigned-by-dhcp.cox.net> <7v4q26zklx.fsf@assigned-by-dhcp.cox.net>
 <7vslpqy4u7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 10 19:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHmOt-0007mz-98
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 19:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbWCJSbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 13:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWCJSbk
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 13:31:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751958AbWCJSbj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 13:31:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2AIVXDZ023183
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Mar 2006 10:31:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2AIVVAA026980;
	Fri, 10 Mar 2006 10:31:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslpqy4u7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17480>



On Fri, 10 Mar 2006, Junio C Hamano wrote:
> 
> So we would need a combination of both, something like this?

Looks good to me.

As does the 'revs.prune_fn' abstraction by Fredrik Kuivinen, for that 
matter. Ack to both.

		Linus
