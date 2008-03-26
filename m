From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Wed, 26 Mar 2008 11:23:03 +0200
Message-ID: <20080326092303.GA17835@mithlond.arda.local>
References: <7caf19ae394accab538d2f94953bb62b55a2c79f.1206486012.git.peff@peff.net> <200803260759.48922.tlikonen@iki.fi> <20080326062029.GA26286@coredump.intra.peff.net> <20080326083033.GA13933@mithlond.arda.local> <20080326083925.GA31475@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 10:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeRs4-0003kA-OR
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 10:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbYCZJXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 05:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYCZJXy
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 05:23:54 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:39363 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781AbYCZJXy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 05:23:54 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96003D4A6F; Wed, 26 Mar 2008 10:23:04 +0100
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JeRqZ-0004ko-3Z; Wed, 26 Mar 2008 11:23:03 +0200
Content-Disposition: inline
In-Reply-To: <20080326083925.GA31475@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78276>

Jeff King kirjoitti (26.3.2008 klo 4.39):

> On Wed, Mar 26, 2008 at 10:30:33AM +0200, Teemu Likonen wrote:
> 
> > I had missed the --cover-letter option completely. It may be useful
> > too. I'm still trying to find the best way to send pathces. If
> > I send intro message with real MUA I either need to wait for the
> > message to show up on a mailing list or check my sent-mail folder to
> > find the Message-Id. Once I know the Message-Id I can send the
> > actual patch series with 'git send-email' as replies to the intro
> > message. Well, this is OK.
> 
> That is how I used to do it; now I use --cover-letter (which you
> probably missed because it is brand new in the upcoming 1.5.5).

I'm using the current 'master' branch so --cover-letter is there.
Managed to miss it anyway. :)

Hmm, do you send the 0000-cover-letter.patch with 'git send-email'? It
seems that this cover letter don't get MIME headers when sent that way.
Sending through 'mutt -H' it works fine but then the Message-Id needs to
be copy-pasted manually to send-mail for the rest of the series (to have
them appear as replies, that is). No problem with that.

> OK, I will add it to the end of my long todo. Out of curiosity, do you
> actually want something besides utf-8, or is this just to make us feel
> feature complete?

I mostly use (and promote) UTF-8 and now that I begin to understand how
send-email works I can live with the current behaviour just fine. Don't
take my feedback as complaining. :)

In general my interests are in human languages and I have done quite
a lot of work in different areas to make computers interact nicely with
human languages. This is my interest in general level and I tend to
report/fix problems when I notice them. From Git's point of view at the
present moment we can probably say just like you did: "make us feel
feature complete."

Thanks for your work on this. Really.
