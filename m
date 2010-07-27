From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git pull (Re: need advice on usage patterns)
Date: Tue, 27 Jul 2010 11:13:32 +0200
Message-ID: <201007271113.32711.trast@student.ethz.ch>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com> <201007260916.27306.trast@student.ethz.ch> <20100726200613.GB1451@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Geoff Russell <geoffrey.russell@gmail.com>, <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 11:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdgEU-0000xC-PK
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 11:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab0G0JNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 05:13:38 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:44531 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab0G0JNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 05:13:35 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 27 Jul
 2010 11:13:33 +0200
Received: from thomas.site (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 27 Jul
 2010 11:13:32 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100726200613.GB1451@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151921>

Jonathan Nieder wrote:
> Thomas Rast wrote:
> [...]
> >                       Or worse, verify that their git-reset has
> > --merge by a quick test (1b5b465 is in 1.6.2) but then find that it
> > does not help with backing out of a merge (e11d7b5 is only in 1.7.0!).
> > 
> > Then again, who reads these manpages anyway?  And we shouldn't let old
> > versions get in the way of having consistent and up-to-date docs.  So,
> 
> Agh, surely we can do better.  Maybe:
> 
> 	See linkgit:git-merge[1] for details, including how conflicts
> 	are presented and handled.
> 
> 	ifdef::stalenotes[]
> 	In git 1.7.0 or later, to cancel a conflicting merge, use
> 	`git reset --merge`.
> 	*Warning*: In older versions of git, running 'git pull'
> 	with uncommited changes is discouraged: while possible,
> 	it leaves you in a state that may be hard to back out of
> 	in the case of a conflict.
> 	else::stalenotes[]
> 	To cancel a conflicting merge, use `git reset --merge`.
> 	endif::stalenotes[]

Sounds good.  Maybe you can call this attribute 'webdocs' or so, so
that we have a generic means of modifying the kernel.org hosted docs?

Also, apparently there is no else::...[] so you have to do an
endif/ifndef pair.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
