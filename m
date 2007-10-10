From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Wed, 10 Oct 2007 23:36:33 +0200
Message-ID: <011c01c80b85$a0d8d560$04ac10ac@Jocke>
References: <alpine.LFD.0.999.0710101236350.20690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjEU-0001eQ-G9
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbXJJVgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756164AbXJJVgh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:36:37 -0400
Received: from mail.transmode.se ([83.241.175.147]:61381 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756105AbXJJVgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:36:36 -0400
Received: from Jocke ([84.217.95.61]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 10 Oct 2007 23:36:34 +0200
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <alpine.LFD.0.999.0710101236350.20690@woody.linux-foundation.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
Thread-Index: AcgLdRdM9nblpso1R0u303EXt6jwNAADww3A
X-OriginalArrivalTime: 10 Oct 2007 21:36:34.0287 (UTC) FILETIME=[A12FA7F0:01C80B85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60551>

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@linux-foundation.org] 
> Sent: den 10 oktober 2007 21:38
> To: Joakim Tjernlund
> Cc: git@vger.kernel.org
> Subject: Re: [FEATURE REQUEST] git clone, just clone selected 
> branches?
> 
> 
> 
> On Wed, 10 Oct 2007, Joakim Tjernlund wrote:
> > 
> > I know I can use git remote to do this, but it is a bit clumsy 
> > when starting a new repo.
> 
> How about just
> 
> 	git init
> 	.. set up remote tracking info in .git/config ..
> 	git fetch remote
> 
> which should do what you want.
> 
> 		Linus

>From git remote man page:
 o  Imitate git clone but track only selected branches

          $ mkdir project.git
          $ cd project.git
          $ git init
          $ git remote add -f -t master -m master origin git://example.com/git.git/
          $ git merge origin

yes, this does the trick too but that is more to type so I thought
it would be simpler if I could just tell git clone which branches I want.
Now, this isn't a killer feature to me so if you don't like it, I good
with that too.

 Jocke
