From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Wed, 13 Feb 2008 11:16:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131113360.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site>
 <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 12:17:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFc9-00053x-93
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 12:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764740AbYBMLQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 06:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764440AbYBMLQR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 06:16:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:51430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764387AbYBMLQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 06:16:16 -0500
Received: (qmail invoked by alias); 13 Feb 2008 11:16:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 13 Feb 2008 12:16:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Q1L8G9c3Q9Erd8PzRKofjCH4Iml/DSBkiFCg5zv
	vDp0O89fcJezu1
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73773>

Hi,

On Tue, 12 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When a merge conflicts, there are often common lines that are not 
> > really common, such as empty lines or lines containing a single curly 
> > bracket.
> >
> > With XDL_MERGE_ZEALOUS_ALNUM, we use the following heuristics: when a 
> > hunk does not contain any letters or digits, it is treated as 
> > conflicting.
> 
> I like the general direction.
> 
> This might need to be loosened further if we want to cover Voltage's 
> case where the inconveniently common hunk had another line, "int err;", 
> which had alnums.  Perhaps we would want to say "max N alnums" instead 
> of "no alnums".

Maybe even both.  

As Linus has stated in the other reply, up to three lines between two 
conflicts could be "merged" with the conflicts by default, because less or 
equally much screen estate would used.

So I am thinking about an interface that is not too painful.

Ciao,
Dscho
