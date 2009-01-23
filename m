From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3 2/3] sha1_file: prepare for adding alternates on
  demand
Date: Fri, 23 Jan 2009 20:54:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901232054090.21467@intel-tinevez-2-302>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>  <1232659071-14401-2-git-send-email-hjemli@gmail.com>  <1232659071-14401-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901230041500.3586@pacific.mpi-cbg.de>
 <8c5c35580901231035j31484249nf96e0e659b119a2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQS8O-0003Of-Vl
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 20:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZAWTyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 14:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbZAWTyn
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 14:54:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:56137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbZAWTyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 14:54:43 -0500
Received: (qmail invoked by alias); 23 Jan 2009 19:54:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 23 Jan 2009 20:54:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7AH4eXyK7KBoR0UB8DqlDtWOiJe1MI6tgNxht4D
	yA29ogRjWaa3I0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <8c5c35580901231035j31484249nf96e0e659b119a2b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106906>

Hi,

On Fri, 23 Jan 2009, Lars Hjemli wrote:

> On Fri, Jan 23, 2009 at 00:43, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 22 Jan 2009, Lars Hjemli wrote:
> >> +             if (!quiet)
> >> +                     error("object directory %s does not exist; "
> >> +                           "check .git/objects/info/alternates.",
> >> +                           ent->base);
> >
> > FWIW my concern is not at all addressed.  A future user of add_alt_odb()
> > (and possibly your users in rare cases, too) can trigger the error that
> > suggests looking into the alternates.  Leaving the human user puzzled.
> 
> Is it the phrasing of the error message that concerns you (when
> invoked from add_alt_odb())?
> 
> If so, would something like this be ok/better?
> 
> >> +             if (!quiet)
> >> +                     error("Alternate object directory %s does not exist ",
> >> +                           ent->base);

That would almost certainly be better.

Ciao,
Dscho
