From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Tue, 19 Feb 2008 13:53:53 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191352360.30505@racer.site>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>  <20080219074423.GA3982@steel.home> <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSvq-0005ND-9C
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbYBSNyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbYBSNyK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:54:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:57002 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751757AbYBSNyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:54:09 -0500
Received: (qmail invoked by alias); 19 Feb 2008 13:54:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 19 Feb 2008 14:54:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IS0leqnBIO0Cf2fcLYsCO5eEx8k5KPT8Q//0n09
	WZiacRY8QmZZvM
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74406>

Hi,

On Tue, 19 Feb 2008, Jay Soffian wrote:

> On Feb 19, 2008 2:44 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Jay Soffian, Tue, Feb 19, 2008 03:07:12 +0100:
> > > +enum branch_track {
> > > +     BRANCH_TRACK_NEVER = 0,
> >
> > enums start at 0 anyway, don't they?
> 
> I don't know, but guys, give me a break on the enums already.

Heh.

Don't be discouraged.  I think you help educating me here, too:

> What's the preferred syntax already because the existing code is not 
> consistent: [...]

I had the impression that the first was set to "= 0", and the rest was not 
explicitely set.  But I was obviously wrong.

Ciao,
Dscho
