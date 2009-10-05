From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 11:17:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de>
References: <4AC8F22F.5070101@gmail.com>  <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de> <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1598012560-1254734269=:4985"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:27:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MujpQ-0007U7-56
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbZJEJQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbZJEJQO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:16:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:60902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932344AbZJEJQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:16:13 -0400
Received: (qmail invoked by alias); 05 Oct 2009 09:15:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 05 Oct 2009 11:15:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Xa0ReZd0XF3h9ZODe2n/M1iuFawiSOprrMXGnbF
	nZ3UU8MKAUxRN2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129542>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1598012560-1254734269=:4985
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 Oct 2009, Björn Gustavsson wrote:

> 2009/10/4 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > I thought that we had a discussion about this and that the consensus was
> > that "amend" would be misleading.  Maybe you can find that thread in
> > GMane?
> 
> I found this thread from January 2009:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/105738
> 
> Having read the thread, I agree that "amend" would be misleading.
> 
> There were several suggestions for alternate command names
> in that thread, for example:
> 
> "msg", "msgedit", "message", "reword", "rephrase"
> 
> It think that "msgedit" was suggested by several people. ("editmsg"
> was also suggested, but it is not possible as the abbreviation "e" would
> become ambiguous.)
> 
> Would the patch have a chance to be accepted if I renamed
> the new command to "msgedit"?

My objection was that the "upcoming" (yeah, Sverre, I am imitating Duke 
Nukem Forever here) "merge" command would clash with "msgedit", which was 
why I suggested "rephrase" (but would be okay with "reword" Junio 
mentions).

AFAIR the naming was the only objection.

Ciao,
Dscho

--8323328-1598012560-1254734269=:4985--
