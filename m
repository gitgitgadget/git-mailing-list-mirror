From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git push bug?
Date: Sat, 20 Oct 2007 19:38:21 +0200
Message-ID: <003601c81340$0277f5f0$5267a8c0@Jocke>
References: <20071019002451.GQ14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: <spearce@spearce.org>, "'Steffen Prohaska'" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 19:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjIHb-0003PJ-3t
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 19:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551AbXJTRi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 13:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbXJTRi2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 13:38:28 -0400
Received: from mail.transmode.se ([83.241.175.147]:63967 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756025AbXJTRi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 13:38:27 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 20 Oct 2007 19:38:25 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <20071019002451.GQ14735@spearce.org>
Thread-Index: AcgR5not4MJ3d7yuSrWzV4whNb/x0gBWVt1w
X-OriginalArrivalTime: 20 Oct 2007 17:38:25.0722 (UTC) FILETIME=[04AB29A0:01C81340]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61843>

 

> -----Original Message-----
> From: spearce@spearce.org [mailto:spearce@spearce.org] 
> Sent: den 19 oktober 2007 02:25
> To: Steffen Prohaska
> Cc: joakim.tjernlund@transmode.se; git
> Subject: Re: git push bug?
> 
> Steffen Prohaska <prohaska@zib.de> wrote:
> > On Oct 18, 2007, at 4:50 PM, Joakim Tjernlund wrote:
> > >
> > ># > git push ssh://devsrv/var/git/os2kernel.git linus:refs/linus
> ...
> > >error: refusing to create funny ref 'refs/linus' locally
> > >ng refs/linus funny refname
> > >error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'
> ...
> > You may need to cleanup though. I'm not sure if the remote side
> > already created 'refs/linus'. The error message only indicates that
> > locally git refused to create the "funny refname".
> 
> Cute.  The error message "error: refusing to create .. locally"
> is actually coming from the remote site.  Locally here is
> actually remotely.  We *really* should change that.  Its l.169 of
> receive-pack.c, which is only running on the remote side.  :)
> 
> Anyone game to improve that error message?  Should be a pretty
> simple patch.  One of the may low-hanging fruits in Git.

Just gave it a try, using git sendmail. Hopefully it will
reach the list :)
