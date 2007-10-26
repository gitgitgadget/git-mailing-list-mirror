From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: Trouble with case-insensitive filesystems
Date: Fri, 26 Oct 2007 18:11:36 +0200
Message-ID: <20071026161136.GC294@localhost.daprodeges.fqdn.th-h.de>
References: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de> <4722064C.1000201@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 18:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlRmu-0007DS-Ej
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 18:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734AbXJZQLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 12:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbXJZQLk
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 12:11:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:41757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753314AbXJZQLk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 12:11:40 -0400
Received: (qmail invoked by alias); 26 Oct 2007 16:11:37 -0000
Received: from dslb-088-073-075-228.pools.arcor-ip.net (EHLO localhost.daprodeges.fqdn.th-h.de) [88.73.75.228]
  by mail.gmx.net (mp048) with SMTP; 26 Oct 2007 18:11:37 +0200
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX19zQuIPrItzHli7dTlzi1xtSGr+VO5k4YSZ5Y7Syh
	EttaY3jUXpO4Qd
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4722064C.1000201@op5.se>
User-Agent: Mutt/1.5.16 (2007-10-18)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62423>

Hi,

* Andreas Ericsson [07-10-26 17:22:52 +0200] wrote:

> There are no areas in git to patch. There's no sane way to handle your
> case, so the best you could opt for is to import it to a system with
> sane case-handling, alter the repo so no two filenames clash, and then
> check it out on your case-insensitive filesystem. Note that you'll
> have to make sure that you never check anything out prior to the
> commit that renames the case-name clashes, or you'll end up with this
> same trouble all over again.

Personally I don't have a problem with that (since I do no work with 
that repo). But IMHO it's bad to leave people without a clue what could 
be wrong when git-status right after git-checkout/git-clone reports 
changes. Btw, mercurial reports the problem so immediately know what's 
wrong.

> On a side note; Please don't set the Reply-To: header for mails to
> git@vger.kernel.org. Some consider it rude, and it makes the ones
> you're asking for help have to work if they want to provide you
> with anything off-list. It's a tad rude.

I didn't set a Reply-To: header, just Mail-Followup-To: which is exactly 
what I want (in mutt language): Private mails via reply only go to me 
and list-reply goes to the list.

Rocco
