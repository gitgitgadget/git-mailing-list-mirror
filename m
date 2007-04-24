From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Apr 2007 18:04:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704241802420.6954@racer.site>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> 
 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>  <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
  <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>  <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
  <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com> 
 <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>  <20070423211658.GA21404@steel.home>
  <7v4pn6ep41.fsf@assigned-by-dhcp.cox.net> <81b0412b0704240858w6121430fj624582539f14ceee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgNV6-00089o-S5
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161809AbXDXQEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161811AbXDXQEQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:04:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:56134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161809AbXDXQEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:04:16 -0400
Received: (qmail invoked by alias); 24 Apr 2007 16:04:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 24 Apr 2007 18:04:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iXOhg9bpi7JqrLPOKHB4Y4Ix0S0Jgq38Lz2wxG8
	hGbWvE8haoB+0N
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0704240858w6121430fj624582539f14ceee@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45463>

Hi,

On Tue, 24 Apr 2007, Alex Riesen wrote:

> On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
>
> > The earlier example I gave would fit this pattern rather well.
> > If somebody (me) cannot deal with UTF-8 encoded Japanese text
> > very well, that user personally can mark such a file in
> > $GIT_DIR/info/attributes as 'filter=utf8-japanese-text' and
> > define the iconv based filtering driver in $GIT_DIR/config in
> > the repository that he (me) uses for editing.
> 
> which will be a PITA to setup in each and every clone of the
> repository, unless it is cloned with the repo.

Not if you do it with templates. If it is such a special case that you 
absolutely _need_ filters, and cannot use it without filters, it is 
probably in a very small group. And there, you just setup the templates, 
and voila: you have your filters without much ado.

Ciao,
Dscho
