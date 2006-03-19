From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Sun, 19 Mar 2006 11:35:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603191134530.3826@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu>
 <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
 <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net>
 <44056BF1.6000109@op5.se> <20060319191243.GB18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 20:35:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL3gl-0002JD-12
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 20:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWCSTfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 14:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWCSTfk
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 14:35:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750741AbWCSTfj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 14:35:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2JJZUDZ006081
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Mar 2006 11:35:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2JJZTVu015179;
	Sun, 19 Mar 2006 11:35:29 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060319191243.GB18185@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.131 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17718>



On Sun, 19 Mar 2006, Petr Baudis wrote:
> 
> (i) I _think_ that it would be less of a surprise if a branch would be
> checked first.

Yeah, I guess that's true.

> Actually, I'm almost inclined to suggest making Git fail violently in
> case of an ambiguous name.

Maybe not fail, but at least warn very loudly.

		Linus
