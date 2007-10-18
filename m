From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 18:55:45 +0200
Message-ID: <9EEDF284-22BE-44BF-A9B8-116407784BEB@zib.de>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>  <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se> <Pine.LNX.4.64.0710181720010.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiYdl-0002gX-8e
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586AbXJRQyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756835AbXJRQyU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:54:20 -0400
Received: from mailer.zib.de ([130.73.108.11]:60026 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbXJRQyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:54:19 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9IGsGWM003435;
	Thu, 18 Oct 2007 18:54:16 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9IGsFT7029947
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Oct 2007 18:54:15 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710181720010.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61546>


On Oct 18, 2007, at 6:21 PM, Johannes Schindelin wrote:

> On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
>
>> Seems like it is a bit too easy to make mistakes here. Why can I  
>> delete
>> a branch with :linus but not create one with linus:linus?
>
> I wonder why you bother with the colon at all.  Just
>
> 	git push <remote> linus
>
> and be done with it.  The colon is only there to play interesting  
> games,
> not something as simple as "push this branch" or "push this tag".

But you need a full refspec starting with 'refs/heads/' if you want to
create a new branch on the remote side.

	Steffen
