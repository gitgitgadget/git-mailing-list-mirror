From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Wed, 10 Oct 2007 23:25:51 +0200
Message-ID: <011b01c80b84$222d1e70$04ac10ac@Jocke>
References: <Pine.LNX.4.64.0710102032330.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:26:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifj47-0008Ie-FY
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbXJJVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbXJJVZz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:25:55 -0400
Received: from mail.transmode.se ([83.241.175.147]:60942 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756028AbXJJVZy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:25:54 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 10 Oct 2007 23:25:52 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0710102032330.4174@racer.site>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgLdLMp+cV//cODQBaJ/3dmJZYyvwADEynw
X-OriginalArrivalTime: 10 Oct 2007 21:25:52.0249 (UTC) FILETIME=[22806E90:01C80B84]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60546>

> -----Original Message-----
> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
> Sent: den 10 oktober 2007 21:35
> To: Joakim Tjernlund
> Cc: git@vger.kernel.org
> Subject: Re: [FEATURE REQUEST] git clone, just clone selected 
> branches?
> 
> Hi,
> 
> On Wed, 10 Oct 2007, Joakim Tjernlund wrote:
> 
> > To my knowlede a git clone always clones all branches from 
> the remote 
> > repo. I would like the possibly to clone selected branches, like
> >  git clone <repo URL> -b master -b upstream
> > which will only fetch the master and upstream branch.
> > 
> > I know I can use git remote to do this, but it is a bit clumsy when 
> > starting a new repo.
> 
> This is why I suggest: since it is an itch of yours, just fix 
> it.  You are 
> in the prime position to know when you're satisfied.
> 
> As a hint how to start: Junio dreamt of a git-clone which is a tiny 
> wrapper around git-fetch and git-remote.
> 
> So you could start by writing a script which would be a 
> replacement for 
> git-clone.sh, and there you can also include the support for 
> -b that you 
> would like so much.
> 
> It would be nice, though, to keep this in separate patches, 
> which you then 
> submit to this list.
> 
> Thank you,
> Dscho

Thank you for these words of visdom, I should know better
than to throw out ideas like this. Next time I have an suggestion
I will think long and hard about it before posting again. 

 Jocke 
