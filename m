From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] First step, making setup (somewhat) reentrant
Date: Mon, 7 Jan 2008 12:28:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801071227110.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org>
 <1199684855-14246-2-git-send-email-ct@pipapo.org> <alpine.LSU.1.00.0801070845270.10101@racer.site>
 <7v4pdq0z30.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Thaeter <ct@pipapo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 12:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBqAQ-0003B1-5P
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 12:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbYAGL2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 06:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYAGL2s
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 06:28:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:48531 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754373AbYAGL2r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 06:28:47 -0500
Received: (qmail invoked by alias); 07 Jan 2008 11:28:45 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp033) with SMTP; 07 Jan 2008 12:28:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uz99pcFcuh/BvMaRtkm+4/NDuZzbXFEf3qTmdYj
	FatotJsYyoooOr
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v4pdq0z30.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69783>

Hi,

On Mon, 7 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Which brings me to a more fundamental question: what do you need 
> > reentrant setup_directory() for?  If it is just to allow multiple 
> > calls to that function for the _same_ repository, I say clean up your 
> > code.
> 
> IIRC, he is writing a set-of-repositories browser.
> 
> But I think the right approach of cleaning up is to design a
> layer of containers like we did for "the_index" libification

Yes, I concur. That was a nice abstraction without impacting existing code 
too much.

Ciao,
Dscho
