From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Documentation: reword --thin description
Date: Wed, 10 Feb 2010 16:04:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002101554200.1681@xanadu.home>
References: <1265778851-5397-1-git-send-email-bebarino@gmail.com>
 <alpine.LFD.2.00.1002101037300.1681@xanadu.home>
 <7vsk98apcr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:05:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJk9-0007Ry-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 22:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab0BJVE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 16:04:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40174 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083Ab0BJVE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 16:04:59 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXN0011N989FC70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Feb 2010 16:04:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vsk98apcr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139551>

On Wed, 10 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > ....  But --thin turned 
> > out to be re-enabled by default for pushes by mistake on a few occasions 
> > when the affected code has been reworked.  No idea what state it is now, 
> > and I don't think that makes such a difference on the server in the end.
> 
> Hmmmm... it's doubly bad that the maintainer does not recall these
> few occasions that mistakes happened.

The default was changed in commit a4503a15af.  Seems that today --thin 
is on by default again.  I don't think we should care that much, 
especially as --thin would logically have to be the default when pushing 
to a bundle.  Obviously leaving it off for push and on for fetch is 
creating needless confusion.


Nicolas
