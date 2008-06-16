From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 16 Jun 2008 21:52:52 +0200
Message-ID: <20080616195252.GA18848@elte.hu>
References: <20080616110113.GA22945@elte.hu> <20080616112709.GG12260@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8KmU-0005Ya-30
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 21:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYFPTx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 15:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYFPTx2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 15:53:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38174 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbYFPTx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 15:53:27 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1K8Kl5-0006NB-FK
	from <mingo@elte.hu>; Mon, 16 Jun 2008 21:53:04 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 6D8733E21DD; Mon, 16 Jun 2008 21:52:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080616112709.GG12260@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85221>


* Theodore Tso <tytso@mit.edu> wrote:

> On Mon, Jun 16, 2008 at 01:01:13PM +0200, Ingo Molnar wrote:
> >    ( Also, it's a GPL nitpicky issue: the conflict resolution database 
> >      can be argued to be part of "source code" and as such it should be 
> >      shared with everyone who asks. With trivial merges the data is
> >      probably not copyrightable hence probably falls outside the scope 
> >      of the GPL, but with a complex topic tree like -tip with dozens of 
> >      conflict resolutions, the boundary is perhaps more blurred. )
> 
> For a more complex merge resolution, granted that it rises to the 
> level of being "copyrightable", but I think it would be a huge stretch 
> to call the rr-cache the "preferred form for modifications"!  :-)

yeah - i'm not really arguing any detail of the GPL here. I'm arguing 
the principle: there should be no technical assymetry between maintainer 
and contributor. So if i am able to run an effort-free integration of 85 
topic branches, i'd like contributors (who will eventually grow up into 
co-maintainer roles in the future) to be able to do the same, if they 
want to do so.

right now that is simply not possible technically - it's even very hard 
to share a .git/rr-cache with a co-maintainer whom i can trust with my 
index file. (which is an otherwise unsafe private binary cache that i'd 
not put into a public repository as it could in theory contain lots of 
unrelated data and is not endian-safe, etc.)

	Ingo
