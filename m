From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix 'No newline...' annotation in rewrite diffs.
Date: Fri, 3 Aug 2012 13:00:06 -0400
Message-ID: <20120803170005.GA24068@sigill.intra.peff.net>
References: <85f291cec03411c61ddf8808e53621ae@imap.force9.net>
 <20120802213346.GA575@sigill.intra.peff.net>
 <7vipd1c66f.fsf@alter.siamese.dyndns.org>
 <20120802221404.GA1682@sigill.intra.peff.net>
 <loom.20120803T094115-721@post.gmane.org>
 <20120803160229.GA13094@sigill.intra.peff.net>
 <7vobmrc49t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 19:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxLEW-00079f-Am
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 19:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab2HCRAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 13:00:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50750 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab2HCRAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 13:00:08 -0400
Received: (qmail 26365 invoked by uid 107); 3 Aug 2012 17:00:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 13:00:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 13:00:06 -0400
Content-Disposition: inline
In-Reply-To: <7vobmrc49t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202844>

On Fri, Aug 03, 2012 at 09:46:22AM -0700, Junio C Hamano wrote:

> >> Maybe you could introduce "test_seq" instead.
> >
> > I don't have a strong preference, as there are only two callsites. Do
> > you want to make a patch?
> 
> If you run "for . in . . ." in t/, we see quite a many hits, so
> "only two callsites" might be undercounting the candidates.

True. Although a good number of them are not numeric sequences (however
perl being perl, I think my one-liner would take "a" and "g" as
end-points just as readily).

I have no problem with converting them all. I just didn't want to
personally go to the work myself.

-Peff
