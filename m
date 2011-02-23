From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Wed, 23 Feb 2011 12:18:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102231213280.26358@xanadu.home>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie> <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
 <7vlj16aeih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 18:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsILu-0004tf-Br
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 18:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab1BWRSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 12:18:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30101 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab1BWRSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 12:18:07 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LH20074AYPFNM10@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 23 Feb 2011 12:17:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vlj16aeih.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167705>

On Wed, 23 Feb 2011, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 22, 2011 at 11:30:41AM -0800, Junio C Hamano wrote:
> >
> >> > Speaking of Makefiles, one downside to all of this directory
> >> > segmentation is that you can't run "make" from the subdirectories.
> >> 
> >> I had an impression that "make -C lib/" would be one of the goals, iow,
> >> when we split the directory structure, the next step would be to split the
> >> top-level Makefile so that each directory is covered by its own Makefile,
> >> just like Documentation/ is already usable that way.
> >
> > Ugh. I am not thrilled at the prospect of more recursive make.
> 
> Likewise. Notice that I have consistently been unthrilled when people
> started talking about splitting the source code tree?

Maybe that would be wiser to consider an initial set of patches as those 
which were proposed to only do the simple file move first, then wait for 
the dust to settle before doing more changes.  Doing too much in one go 
is inevitably going to bounce against the human tendency to resist any 
kind of change, good or bad.


Nicolas






> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
