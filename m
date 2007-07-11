From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Hook after pull ?
Date: Wed, 11 Jul 2007 20:33:41 +0200
Message-ID: <20070711183341.GA2798@steel.home>
References: <4694EC0F.10003@gmail.com> <81b0412b0707110751i7947ac5bv819e1c2de4e94621@mail.gmail.com> <4694F74F.8050908@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Claudio Scordino <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8h0Y-0004BM-I1
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbXGKSds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbXGKSdr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:33:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:49231 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbXGKSdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:33:47 -0400
Received: from tigra.home (Fa968.f.strato-dslnet.de [195.4.169.104])
	by post.webmailer.de (mrclete mo22) (RZmta 8.3)
	with ESMTP id R00201j6BFtG4c ; Wed, 11 Jul 2007 20:33:45 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C09DE277BD;
	Wed, 11 Jul 2007 20:33:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3CDC6C164; Wed, 11 Jul 2007 20:33:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4694F74F.8050908@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmQFKE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52183>

Claudio Scordino, Wed, Jul 11, 2007 17:29:19 +0200:
> >>If no, does exist any easy way of creating such hook ?
> >
> >What for? What do you want to do?
> >
> I just need my script to be called after a pull. My script just sends an 
> email saying that the repository has been pulled (I already did it for the 
> push).

Ach, on _remote_ repo. Where it is _pulled_from_.
There are none. You can catch log output of git-daemon, but...
Isn't it a bit extreme? A fetch (part of a pull) is *very* common
operation, sometime you'll get a *real* lot of mail.

P.S. BTW, there is no hooks for pull in local (where it is pulled
into): it is not needed, you already control everything what happens.
But it is not your situation, as far I understand.
