From: Jeff King <peff@peff.net>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 02:18:12 -0500
Message-ID: <20160223071812.GD8395@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
 <20160223050210.GA17767@sigill.intra.peff.net>
 <20160223051402.GA23375@sigill.intra.peff.net>
 <20160223060338.GA2912@sigill.intra.peff.net>
 <xmqqr3g42atl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 08:18:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY7Eg-00031i-OA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 08:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbcBWHSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 02:18:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:47369 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbcBWHSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 02:18:14 -0500
Received: (qmail 12432 invoked by uid 102); 23 Feb 2016 07:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:18:15 -0500
Received: (qmail 26347 invoked by uid 107); 23 Feb 2016 07:18:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:18:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 02:18:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3g42atl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287033>

On Mon, Feb 22, 2016 at 10:35:34PM -0800, Junio C Hamano wrote:

> > I stopped short of dropping the create_virtual_base function in the
> > first patch, for reasons explained there. But if we were to do so, I
> > suspect we could deprecated and eventually drop "apply --no-add", too.
> 
> Thanks.  I think the "virtual" stuff started its life outside
> sh-setup but later was moved there for p4merge.  The log message for
> 4549162e (mergetools/p4merge: create a base if none available,
> 2013-03-13) seems to indicate that using an empty file does not work
> well over there as you suspected, so unfortunately we cannot lose it
> just yet.

Oh, indeed. I did find that commit in my git-blaming, but failed to
actually read it carefully. :)

With that, yeah, I agree that we cannot drop the virtual-base thing, and
my 3 patches are fine as-is.

-Peff
