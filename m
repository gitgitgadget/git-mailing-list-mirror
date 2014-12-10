From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 16:06:51 -0500
Message-ID: <20141210210651.GB31071@peff.net>
References: <20141209174958.GA26167@peff.net>
 <20141209180916.GA26873@peff.net>
 <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
 <20141210073447.GA20298@peff.net>
 <CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
 <20141210094702.GA8917@peff.net>
 <CAPig+cSx2dw7DsZgiebHqZUG7DbnQtpgxKbi2883Z42VajeAJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 22:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyoTK-00020w-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 22:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360AbaLJVGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 16:06:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:51267 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932726AbaLJVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 16:06:53 -0500
Received: (qmail 27463 invoked by uid 102); 10 Dec 2014 21:06:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 15:06:53 -0600
Received: (qmail 12814 invoked by uid 107); 10 Dec 2014 21:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 16:06:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 16:06:51 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSx2dw7DsZgiebHqZUG7DbnQtpgxKbi2883Z42VajeAJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261247>

On Wed, Dec 10, 2014 at 03:14:17PM -0500, Eric Sunshine wrote:

> > +test_expect_success 'try to create repo with absurdly long refname' '
> > +       ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40
> 
> Maybe you want to keep the &&-chain intact here?

Thanks, yeah. It doesn't matter in practice, but we do try to &&-chain
everything.

-Peff
