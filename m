From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Tue, 22 Jan 2008 02:14:05 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801220212460.5731@racer.site>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <47946F67.5060601@gbarbier.org> <7vmyqzzdhf.fsf@gitster.siamese.dyndns.org> <47947399.3000507@gbarbier.org> <7vabmzzbcc.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801211212010.5731@racer.site> <7vejcbx795.fsf@gitster.siamese.dyndns.org> <20080121202953.GA18440@glandium.org> <alpine.LSU.1.00.0801220056080.5731@racer.site> <7vy7aive18.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801220137310.5731@racer.site>
 <7vprvuvcni.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 03:14:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH8eu-0008Ap-Ap
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 03:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbYAVCOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 21:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYAVCOJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 21:14:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:51770 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753916AbYAVCOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 21:14:08 -0500
Received: (qmail invoked by alias); 22 Jan 2008 02:14:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 22 Jan 2008 03:14:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZynonpYIZrlhbDshvhM3BBVSLKTkoYy6g+GJt5p
	nTjcaz/fPIxHSL
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprvuvcni.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71401>

Hi,

On Mon, 21 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 21 Jan 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > So I am half-convinced that http-push w/o CURL_MULTI was broken 
> >> > since long ago (pre 1.5.3).
> >> 
> >> Sigh, but Ok.  Then let's do this.
> >
> > This sigh hurts my heart.
> 
> Heh, it's not like you broke it, and if I sounded like I was shooting at 
> the messenger I apologize.

No, no, that's alright.  I am the messenger alright, but it seems that I 
am in a relatively rare position to do something about the sad state of 
http-push.

Probably with the help of Gregoire and Mike ;-)

Ciao,
Dscho
