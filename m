From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect failure
Date: Sat, 10 Sep 2005 14:13:43 -0700
Message-ID: <20050910141343.578649c7.akpm@osdl.org>
References: <20050909011034.12f2bf64.akpm@osdl.org>
	<7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
	<20050910022638.20832803.akpm@osdl.org>
	<Pine.LNX.4.58.0509101202070.30958@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 23:15:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EECfx-0008Q7-C1
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 23:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVIJVOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVIJVOO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 17:14:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932312AbVIJVOO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2005 17:14:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8ALE9Bo031965
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Sep 2005 14:14:09 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j8ALE8q0002223;
	Sat, 10 Sep 2005 14:14:08 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509101202070.30958@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8261>

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Sat, 10 Sep 2005, Andrew Morton wrote:
>  >
>  > Junio C Hamano <junkio@cox.net> wrote:
>  > >
>  > > So it _might_
>  > >  be possible that you said "current LDT" was bad when it was
>  > >  actually good.  That is one possible explanation.
>  > 
>  > I agree.  Mea culpa.  Sorry.
> 
>  Well, this was actually something I hit when testign bisection too: it 
>  _is_ very unforgiving of mistakes.

Yes.  That was my third attempt.  You basically _have_ to write down the
good/bad sequence as you go.  One slip and you've blown an hour's work.

>  So the bisection algorithm may have done the right thing from a technical 
>  standpoint, but I suspect it could be made to be a bit more forgiving, or 
>  at least when somebody realizes that bisection didn't work right, we could 
>  have the trail of good/bad markings to try to debug what happened...

Yup.  Simply keeping a little log file would suffice.
