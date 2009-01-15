From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 18:22:25 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmuvn1.7q3.sitaramc@sitaramc.homelinux.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
 <496F3C99.1040800@drmicha.warpmail.net>
 <20090115135518.GB10045@leksak.fem-net>
 <496F44AC.2060607@drmicha.warpmail.net>
 <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
 <496F4BF0.6020805@drmicha.warpmail.net>
 <alpine.DEB.1.00.0901151658060.3586@pacific.mpi-cbg.de>
 <slrngmuoq8.3u2.sitaramc@sitaramc.homelinux.net>
 <alpine.DEB.1.00.0901151751580.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 19:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNWsq-0002oT-7p
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 19:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761823AbZAOSWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 13:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761743AbZAOSWf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 13:22:35 -0500
Received: from main.gmane.org ([80.91.229.2]:44373 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761633AbZAOSWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 13:22:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LNWrR-0002tg-Om
	for git@vger.kernel.org; Thu, 15 Jan 2009 18:22:33 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 18:22:33 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 18:22:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105864>

On 2009-01-15, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> if you would like me to respond to your questions in the future, it is 
> mandatory to keep me in the Cc: list.

OK.  [Is that the list convention too?]

> On Thu, 15 Jan 2009, Sitaram Chamarty wrote:

>> I'm unable to make "rebase -p" carry an evil merge over.
>> The "evil" part stays behind.
>> 
>> I'm not sure if that is intentional or not, or (more likely)
>> my brain has become addled and I missed something somewhere.
>
> Yes, this is intentional.
>
> 	Instead of ignoring merges, try to recreate them.
>
> That means it tries to recreate them.  Not that it is successful.  And not 
> even that it realizes when it failed.

Is a conflicted merge that was resolved by making a change
that was in neither parent, an evil merge?

Regardless, I suspect rebase -p will not be able to carry
such a merge over.

But if it won't carry over the evil in an evil merge, what
other uses are there for "rebase -p" as opposed to rebase?
Seems to me that the DAG may be different but the tree you
end up with is the same then.

I'm sure someone has a blog post or a bookmark or an article
or something they wrote long ago about "rebase -i -p".
Anyone?
