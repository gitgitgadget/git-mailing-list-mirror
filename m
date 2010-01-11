From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] string-list: remove print_string_list,
 since it is not used anymore.
Date: Mon, 11 Jan 2010 17:23:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001111722150.10143@xanadu.home>
References: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
 <alpine.DEB.1.00.1001112252040.4985@pacific.mpi-cbg.de>
 <7v3a2ccmrg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUSfW-00071T-5g
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab0AKWXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948Ab0AKWXW
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:23:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61235 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0AKWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:23:22 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KW300GPKSUXLPR0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jan 2010 17:23:21 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3a2ccmrg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136672>

On Mon, 11 Jan 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 11 Jan 2010, Thiago Farina wrote:
> >
> >> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> >> ---
> >
> > It was never used, except for debugging.  Does it hurt you really all that 
> > much?
> 
> Exactly my feeling.
> 
> I think I discarded at least two other patches sent to me to remove this
> "unused" (but obviously meant for debugging) function in the past.  I
> guess we'll keep the function this time, too.

If so many people are so inclined to discard it, then maybe a little 
comment could be added to explain its existance?


Nicolas
