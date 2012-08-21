From: Jeff King <peff@peff.net>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 17:53:50 -0400
Message-ID: <20120821215350.GA22215@sigill.intra.peff.net>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
 <20120821061059.GA26516@sigill.intra.peff.net>
 <7v628cfb6h.fsf@alter.siamese.dyndns.org>
 <7va9xndibh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:54:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wOd-0002AT-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 23:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696Ab2HUVxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 17:53:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44183 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758608Ab2HUVxx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 17:53:53 -0400
Received: (qmail 3601 invoked by uid 107); 21 Aug 2012 21:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 17:54:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 17:53:50 -0400
Content-Disposition: inline
In-Reply-To: <7va9xndibh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203995>

On Tue, Aug 21, 2012 at 02:52:02PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Modulo the above "you might want to turn the call to warn() to
> > another helper that can be used from elsewhere", this patch looks
> > perfect to me.
> 
> And that "modulo" is fairly simple if we wanted to go that route.
> 
>  attr.c            | 2 +-
>  dir.c             | 2 +-
>  git-compat-util.h | 3 +++
>  wrapper.c         | 7 ++++++-
>  4 files changed, 11 insertions(+), 3 deletions(-)

Yeah, that looks fine to me if you want to squash it in.

-Peff
