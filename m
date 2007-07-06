From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 6 Jul 2007 16:32:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707061631560.4093@racer.site>
References: <468E59B3.7080007@nrlssc.navy.mil> <20070706151145.GA15341@informatik.uni-freiburg.de>
 <468E5E31.8040504@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:39:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6puJ-0008Th-E2
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760698AbXGFPjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760693AbXGFPjl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:39:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:49744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755956AbXGFPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:39:40 -0400
Received: (qmail invoked by alias); 06 Jul 2007 15:39:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 06 Jul 2007 17:39:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kNJB24TIkEL0zJztqfJgDD1AV+v1OBJRLuHV8+G
	JEk4IfVdVHDGM8
X-X-Sender: gene099@racer.site
In-Reply-To: <468E5E31.8040504@nrlssc.navy.mil>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51766>

Hi,

On Fri, 6 Jul 2007, Brandon Casey wrote:

> Uwe Kleine-K?nig wrote:
> > Hello Brandon,
> > 
> > Brandon Casey wrote:
> >>  	struct passwd *pw = NULL;
> >> +        char *email;
> > Indention error. Otherwise it looks good (just from reading the patch).
> 
> huh. It doesn't look like that in my mail reader.
> I have
>         struct passwd...
> +        char *email;
> 
> and the patch applied cleanly when I saved the email and applied it
> using git-am
> 
>   cat git_email.patch | git-am

Yes, it applies cleanly. But it has 8 spaces before "char *email", not a 
tab (otherwise it would be lined up with "struct passwd").

Hth,
Dscho
