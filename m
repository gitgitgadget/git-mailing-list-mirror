From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 12:56:49 +0200
Message-ID: <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 12:56:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHdmo-0003y2-Px
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 12:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337AbXHEK4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 06:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXHEK4f
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 06:56:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:46959 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756359AbXHEK4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 06:56:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75AtwvJ008340;
	Sun, 5 Aug 2007 12:55:58 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75Atudq016997
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 12:55:57 +0200 (MEST)
In-Reply-To: <20070805100532.GG12507@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54990>


On Aug 5, 2007, at 12:05 PM, Jeff King wrote:

> On Sat, Aug 04, 2007 at 04:01:55PM +0200, David Kastrup wrote:
>
>> So --track does not set up a tracking branch, but makes a local
>> _following_ branch _refer_ to a tracking branch.
>
> A minor nit, but --track sets up a local following branch to refer  
> to a
> remote's branch, _not_ to the tracking branch. In other words, if you
> look at the config:
>
>   [branch "master"]
>     remote = origin
>     merge = refs/heads/master
>
> It does _not_ reference the tracking branch
> "refs/remotes/origin/master", but rather the remote's name for the
> branch "refs/heads/master".
>
> There was much discussion of this topic, but the general idea was  
> not to
> require remote tracking branches for this feature to be used (a  
> position
> I somewhat disagree with, but then I'm not the maintainer).

Interesting. I didn't even recognize this detail up to know. It was  
somewhat
beyond my imagination that I could have a local following/automerging
branch that is directly referring to a branch in a remote repo, without
have a remote-tracking branch.

How could I create such a setup in the first place?

     git branch --track something origin/something
     git checkout --track -b something origin/something

are obvious, but what to say if I don't have origin/something?

	Steffen
