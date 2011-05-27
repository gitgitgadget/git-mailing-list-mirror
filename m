From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH maint 0/3] do not write files outside of work-dir
Date: Fri, 27 May 2011 20:09:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105272007500.16250@s15462909.onlinehome-server.info>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> <7vr57krppq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 20:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ1TE-0007W9-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 20:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab1E0SJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 14:09:08 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:57791 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750922Ab1E0SJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 14:09:06 -0400
Received: (qmail invoked by alias); 27 May 2011 18:09:03 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp043) with SMTP; 27 May 2011 20:09:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CTqY/6vqCSlC5Kc6J2lwcuk5gbnFNv2zShJb1IY
	UQ7vIu7C5D18vP
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vr57krppq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174635>

Hi Junio,

On Fri, 27 May 2011, Junio C Hamano wrote:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
> 
> > Theo Niessink has uncovered a serious sercurity issue in Git for 
> > Windows, where cloning an evil repository can arbitrarily overwrite 
> > files outside the repository. Since many Windows users run as 
> > administrators, this can be used for very nasty purposes.
> 
> Which of my integration branches do msysGit/Git for Windows folks base 
> their releases these days? I could carry this through the regular "next 
> to master and then sometime later to maint" schedule, but if you are not 
> using maint and basing primarily on master then I'd rather skip the "and 
> then sometime later to maint" part.

We follow 'next'.

[Cc:ing the msysGit list, as I don't know whether Pat or Sebastian follow 
git@vger]

Thanks,
Johannes
