From: Jeff King <peff@peff.net>
Subject: Re: [Patch 1/5] Fix some asciidoc layout problems
Date: Sat, 6 Oct 2012 15:10:09 -0400
Message-ID: <20121006191009.GB3644@sigill.intra.peff.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <244418682.269701.1349538839518.JavaMail.ngmail@webmail08.arcor-online.net>
 <7vfw5rqwby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZla-0000xB-0w
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab2JFTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 15:10:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43160 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463Ab2JFTKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:10:14 -0400
Received: (qmail 10043 invoked by uid 107); 6 Oct 2012 19:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 15:10:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 15:10:09 -0400
Content-Disposition: inline
In-Reply-To: <7vfw5rqwby.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207168>

On Sat, Oct 06, 2012 at 11:39:13AM -0700, Junio C Hamano wrote:

> Thomas Ackermann <th.acker66@arcor.de> writes:
> 
> > Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> > ---
> >  Documentation/git-bisect-lk2009.txt | 12 ++++++------
> >  Documentation/git-fetch-pack.txt    |  5 ++++-
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> You didn't say what "layout problem" you are fixing, or what the
> approach you took to "fix" it.  From the patch, I can guess that the
> latter is to lengthen the lines that surround the displayed examples,
> but as far as I know and can tell, the existing ones are long enough
> so I cannot tell why you needed such a change to the source in the
> first place.
> 
> A better explanation, please?

I had the same question. Also, some of the lines convert tabs in literal
output into spaces, which is actively wrong (or maybe they were
converted already to spaces in the current code, but they should at
least align with 8-space tabstops):

> > -:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
> > +:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile

-Peff
