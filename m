From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Mon, 4 Jun 2012 07:56:30 -0400
Message-ID: <20120604115630.GC27676@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org>
 <vpq1ulvuxd9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 04 13:56:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbVtl-0005tA-FY
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 13:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab2FDL4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 07:56:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:42456
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab2FDL4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 07:56:33 -0400
Received: (qmail 2152 invoked by uid 107); 4 Jun 2012 11:56:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Jun 2012 07:56:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2012 07:56:30 -0400
Content-Disposition: inline
In-Reply-To: <vpq1ulvuxd9.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199132>

On Mon, Jun 04, 2012 at 01:31:30PM +0200, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thanks.  All looked good.
> >
> > This is the first one that refers to "../something" with "linkgit:";
> > do they format sensibly?
> 
> On my machine (Debian stable), the HTML formatting is correct (and BTW,
> the other instance of linkgit in technical, "(see
> linkgit:gitattributes[5])" is broken). One can see the .. in the link,
> but at least the target of the link is OK. I didn't worry too much about
> formatting since this is a technical documentation.

There is also a broken reference to linkgit:git-config[1] in
api-config.txt.

We only build html documentation from technical/, not manpages. So they
could just all be switched to link: (the point of linkgit is to format a
manpage reference from either html or a manpage).

-Peff
