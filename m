From: Jeff King <peff@peff.net>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Wed, 16 Sep 2015 13:37:04 -0400
Message-ID: <20150916173704.GA2727@sigill.intra.peff.net>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
 <20150911140133.GA14311@sigill.intra.peff.net>
 <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
 <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
 <20150912033054.GA30431@sigill.intra.peff.net>
 <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
 <20150913100728.GA26562@sigill.intra.peff.net>
 <CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
 <20150915100538.GA21831@sigill.intra.peff.net>
 <xmqqwpvrtbbh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 19:37:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcGe0-0001e9-RV
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 19:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbbIPRhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 13:37:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:60129 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752524AbbIPRhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 13:37:13 -0400
Received: (qmail 14523 invoked by uid 102); 16 Sep 2015 17:37:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 12:37:13 -0500
Received: (qmail 20254 invoked by uid 107); 16 Sep 2015 17:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 13:37:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 13:37:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpvrtbbh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278039>

On Tue, Sep 15, 2015 at 06:14:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It seems like nobody is actually that interested in what "blame
> > --first-parent --reverse" does in the first place, though, and there's
> > no reason for its complexity to hold up vanilla --first-parent. So what
> > do you think of:
> 
> I like the part that explicitly disables the combination of the two
> ;-)

Meaning you didn't like the other part, or that you'll pick up the patch
as-is? :)

-Peff
