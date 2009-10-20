From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 00:41:11 +0200
Message-ID: <200910210041.12738.trast@student.ethz.ch>
References: <200910201947.50423.trast@student.ethz.ch> <20091021064243.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Bjrn Steinbrink <B.Steinbrink@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NOw-00087K-Ln
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbZJTWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 18:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZJTWlp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:41:45 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:29390 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbZJTWlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 18:41:44 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 00:41:48 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 00:41:46 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091021064243.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130862>

Nanako Shiraishi wrote:
> Quoting Thomas Rast <trast@student.ethz.ch>
> > 1. git-fetch gets options --merge/-m and --rebase that make it behave
> >    like (current) git-pull, but requiring explicit arguments.
> >    git-pull gets a new option --merge (-m) that only enforces presence
> >    of arguments.
> >
> > 2. git-pull refuses to do any work unless given either --merge or
> >    --rebase.  Deprecation warnings for this start at the same time as
> >    (1.).
> >
> > 3. git-pull becomes a synonym for git-fetch.
> >
> > 4. git-fetch gives deprecation warnings that point the user to
> >    git-pull instead.
> 
> Sorry, but I don't understand what's the improvement in the end 
> result.
> 
> I started reading your problem description and I thought you are 
> fixing your item 'a) pull/push are not symmetric' by deprecating 
> pull, to advertize fetch/push.  Then asymmetry of push/pull stops 
> being an issue.
> 
> But it seems that eventually you will keep git-push and git-pull 
> (because git-fetch gets deprecated); you have push/pull that are 
> not symmetric.

By the time I get to that step, new-pull is current-fetch.  So by that
time, push/pull *are* supposedly symmetric.

(Only deprecating pull never occurred to me, but then I really think
the strong association between them makes it worth keeping pull as the
opposite of push.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
