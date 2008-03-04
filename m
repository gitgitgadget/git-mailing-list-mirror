From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule: Don't die when command fails for one
 submodule
Date: Tue, 4 Mar 2008 16:13:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041612400.22527@racer.site>
References: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>  <alpine.LSU.1.00.0803041500170.22527@racer.site>  <46dff0320803040800o499bb77bsa033134bda43becb@mail.gmail.com>  <alpine.LSU.1.00.0803041602150.22527@racer.site>
 <46dff0320803040806y5ed02b86p9216ddc752f3052@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:14:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZn6-0000rP-3Y
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763774AbYCDQOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762732AbYCDQOS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:14:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:36746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760224AbYCDQOS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:14:18 -0500
Received: (qmail invoked by alias); 04 Mar 2008 16:14:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 04 Mar 2008 17:14:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sobVkF79smWyHUawtxjVzbrOGD+EvgubJBQXbcI
	r0tCyaTzEbd4dK
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320803040806y5ed02b86p9216ddc752f3052@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76114>

Hi,

On Wed, 5 Mar 2008, Ping Yin wrote:

> On Wed, Mar 5, 2008 at 12:03 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Wed, 5 Mar 2008, Ping Yin wrote:
> >
> >  > The error output is not lost and is in module_name
> >
> >  That's what I am saying: the error output is not enough.  The exit status
> >  needs to indicate that there was an error, too.  Everything else is
> >  unusable by scripts.
> 
> I think this can be done in a following patch which capture any error
> and give the right exit status.

That's horrible!  Are you seriously suggesting breaking a perfectly fine 
paradigm in one patch, just to fix it in the next one?

*Shudders*,
Dscho
