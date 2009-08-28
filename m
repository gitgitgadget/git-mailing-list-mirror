From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 15:00:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281458370.6044@xanadu.home>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828180158.GA6940@coredump.intra.peff.net>
 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
 <20090828183958.GA11488@coredump.intra.peff.net>
 <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6iE-0000RO-3N
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbZH1TAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZH1TAy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:00:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25055 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZH1TAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:00:53 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KP300367OTEJAB0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Aug 2009 15:00:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127330>

On Fri, 28 Aug 2009, Alex Riesen wrote:

> On Fri, Aug 28, 2009 at 20:39, Jeff King<peff@peff.net> wrote:
> > On Fri, Aug 28, 2009 at 08:27:06PM +0200, Alex Riesen wrote:
> >
> >> > Thanks, that is a much better solution. And I don't know offhand of any
> >> > portability problems in overriding the library at link time.
> >>
> >> Microsoft's compiler and libraries? MacOSX?
> >
> > Are you saying you know those to be platforms with problems, or are you
> > asking whether those platforms will have problems?
> 
> Both: MS never had weak/vague linkage, but I don't know about MacOSX.

This is not about weak or vague linkage.  This is plain basic linker 
feature where no library object needs to be linked if there is no symbol 
to resolve.

> I suspect them to have the same deficiency, but I'd be glad to be wrong.

Are you able to test it?


Nicolas
