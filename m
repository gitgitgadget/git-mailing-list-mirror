From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 22:12:29 +0200
Message-ID: <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de>
References: <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com> <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site> <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkmZY-0005C9-Hu
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbXJXULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbXJXULL
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:11:11 -0400
Received: from mailer.zib.de ([130.73.108.11]:43448 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbXJXULK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:11:10 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9OKB28d004438;
	Wed, 24 Oct 2007 22:11:02 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1097b.pool.einsundeins.de [77.177.9.123])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9OKB0CW009294
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 24 Oct 2007 22:11:01 +0200 (MEST)
In-Reply-To: <20071024194849.GH29830@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62232>

On Oct 24, 2007, at 9:48 PM, J. Bruce Fields wrote:

>
>> I want git pull to work like git push.
>
> That strikes me as a less complete solution, since it only helps in  
> the
> case where the other branches all happen to be unmodified locally  
> (hence
> can be fast-forwarded).  In other cases the "git push" will still  
> emit a
> spurious error.

Well, but then there's something you should really think
about. Then you _have_ local changes that are not at the remote.
You need to handle them somehow. Maybe you forgot to push
earlier and now the remote advanced.

Btw, the 'new' git pull should already have reported a warning
that it failed to fast forward the local branch. git pull
should have suggested to explicitly merge the branch with
local changes.

	Steffen
