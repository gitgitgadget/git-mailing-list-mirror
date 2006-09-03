From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 03 Sep 2006 14:38:48 +0200
Organization: At home
Message-ID: <edeicq$ae0$1@sea.gmane.org>
References: <44fac1ee.308dbbaf.574b.08a5@mx.gmail.com> <e5bfff550609030518o5e78bb05w4df4235a4931c2dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 03 23:25:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzT3-0002y0-4E
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWICVZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWICVZN
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:25:13 -0400
Received: from main.gmane.org ([80.91.229.2]:41190 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750976AbWICMi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 08:38:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJrFY-0004AO-Tt
	for git@vger.kernel.org; Sun, 03 Sep 2006 14:38:57 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 14:38:56 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 14:38:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26377>

Marco Costalba wrote:

>>
>> By the way, do you known any common Perl modules for generating PNG
>> (graphs)?
>>
> 
> No, I don't. sorry. Anyway, from my experience with qgit I can say
> that one thing is to produce a revision graph, another thing is to
> produce a _fast_ and (perhaps more important) no memory hogger
> revision graph.
> 
> Both qgit and gitk implement heavy optimizations and a lot of tricks
> to make that happen. IMHO this is almost mandatory with long and
> complex histories like Linux tree. I'm not sure a generic graph
> builder is up to the task.
> 
> More, gitweb is designed to be used by many people at the same time,
> while qgit and gitk are for personal use only, and this adds burden
> from the performance/resources  point of view.

Well, I guess even if/when gitweb acquires history graph support, it would
be paged like history/shortlog is, i.e. at most 100 commits to graph.

P.S. To those wondering why thread got broken, and why the parent post is
lost: vger bogofilter.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git



-- 
VGER BF report: S 0.992982
