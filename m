From: Mark Burton <markb@ordern.com>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
 an  asterisk
Date: Tue, 10 Feb 2009 11:05:46 +0000
Organization: Order N Ltd.
Message-ID: <20090210110546.5ead75a6@crow>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
	<alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
	<20090210000321.78025483@crow>
	<76718490902091622y9a6d1bak5dc401858382e2ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqSi-0000oW-0o
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZBJLGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbZBJLGE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:06:04 -0500
Received: from c2beaomr10.btconnect.com ([213.123.26.188]:3263 "EHLO
	c2beaomr10.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZBJLGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:06:01 -0500
Received: from crow.ordern.com (host86-128-142-98.range86-128.btcentralplus.com [86.128.142.98])
	by c2beaomr10.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BSS25064;
	Tue, 10 Feb 2009 11:05:46 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 707F1190DC5;
	Tue, 10 Feb 2009 11:05:46 +0000 (GMT)
In-Reply-To: <76718490902091622y9a6d1bak5dc401858382e2ff@mail.gmail.com>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr10.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0208.49915F8E.0006,ss=1,fgs=0,
	ip=86.128.142.98,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109203>

On Mon, 9 Feb 2009 19:22:50 -0500
Jay Soffian <jaysoffian@gmail.com> wrote:

> (Please don't trim cc:)
> 
> On Mon, Feb 9, 2009 at 7:03 PM, Mark Burton <markb@ordern.com> wrote:
> > I don't know if I have any scripts that rely on a single star in front of
> > the local HEAD or not (I'm sure some people must have them), but I do
> > think this new feature would be very confusing, especially when used
> > with -a.
> >
> > At the very least, make the indicator something other than a star, an @
> > or #, perhaps.
> 
> With color, it shouldn't be confusing at all as only one branch is in
> green. 

How about the colour blind git users?

> W/o color, it still seems clear to me as the remote branches
> have their remote name prefixed to them. Even if you're on a detached
> head:
> 
> * (no branch)
>   master
>   next
>   sent/branch-show-remote-HEAD
>   wip/am-usability-improvements
>   wip/push-docs
>   origin/html
>   origin/maint
>   origin/man
> * origin/master
>   origin/next
>   origin/pu
>   origin/todo
> 
> A different marker doesn't really seem like an improvement to me:
> 
> * (no branch)
>   master
>   next
>   sent/branch-show-remote-HEAD
>   wip/am-usability-improvements
>   wip/push-docs
>   origin/html
>   origin/maint
>   origin/man
> @ origin/master
>   origin/next
>   origin/pu
>   origin/todo
> 
> But I'm happy to have the community paint the shed I've constructed.
> 
> j.

You can paint a rickety old shed any colour you wish but it doesn't
make it any stronger.

Personally, I think the -> syntax is a much better idea as it is unlikely
to be confused with the existing marker and it shows the relationship
between the (remote) HEAD and remote current branch.

Cheers,

Mark
