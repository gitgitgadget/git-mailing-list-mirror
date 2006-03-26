From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 15:10:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603261509320.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
 <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz>
 <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz>
 <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz>
 <Pine.LNX.4.64.0603261415390.15714@g5.osdl.org> <20060326223154.GU18185@pasky.or.cz>
 <7vodzsq12g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 01:11:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNeNo-0002DY-Mr
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 01:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWCZXKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 18:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCZXKu
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 18:10:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbWCZXKs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 18:10:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QNAZDZ008579
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 15:10:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QNAZ5K021694;
	Sun, 26 Mar 2006 15:10:35 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodzsq12g.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18066>



On Sun, 26 Mar 2006, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> No, it's the expected output just because you expected merges to always 
> >> show up. Merges get ignored if any of the parents have the same content 
> >> already.
> >
> > Eek. Can I avoid that? What was the reason for choosing this behavior?
> 
> Perhaps rev-list --sparse?

No. "--sparse" still removes the uninteresting parents of merges. It just 
doesn't then make the linear history any denser.

		Linus
