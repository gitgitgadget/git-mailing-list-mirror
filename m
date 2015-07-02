From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as
 required
Date: Thu, 2 Jul 2015 09:53:10 -0400
Message-ID: <20150702135309.GA18286@peff.net>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com>
 <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com>
 <xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 15:53:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAevX-0004pi-47
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 15:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbbGBNxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 09:53:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54758 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752426AbbGBNxM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 09:53:12 -0400
Received: (qmail 7055 invoked by uid 102); 2 Jul 2015 13:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jul 2015 08:53:12 -0500
Received: (qmail 1086 invoked by uid 107); 2 Jul 2015 13:53:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jul 2015 09:53:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jul 2015 09:53:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273229>

On Wed, Jul 01, 2015 at 01:39:49PM -0700, Junio C Hamano wrote:

> There is a slight complication on sending an empty line without any
> termination, though ;-)  The reader that calls packet_read() cannot
> tell such a payload from a flush packet, I think.
> 
> *That* may be something we want to document.

Usually flush packets are "0000", and an empty data packet
is "0004". Or are you talking about some kind of flush inside the
pkt-data stream?

-Peff
