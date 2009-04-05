From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 16:25:51 -0400
Message-ID: <20090405202551.GD4716@coredump.intra.peff.net>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org> <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com> <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com> <7vocvaq36x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:30:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYwR-0001iD-3T
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbZDEU0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755707AbZDEU0K
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:26:10 -0400
Received: from peff.net ([208.65.91.99]:36207 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbZDEU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:26:10 -0400
Received: (qmail 17681 invoked by uid 107); 5 Apr 2009 20:26:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 05 Apr 2009 16:26:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2009 16:25:51 -0400
Content-Disposition: inline
In-Reply-To: <7vocvaq36x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115698>

On Sun, Apr 05, 2009 at 01:02:30PM -0700, Junio C Hamano wrote:

> > I think Junio is trying to learn base64 :)!
> 
> I think that is what my Gnus/message-mode did.  I do not know which letter
> triggered it to decide it is UTF-8 to begin with, though.  As far as I am
> aware, I didn't type anything non-ascii in my message.

Actually, it is Sverre's fault. :)

You quoted his message, quoting Christian's message. Christian's message
was 7bit. But for some reason, Sverre's quoting of Christian's message
contains weird iso8859 space characters (0xa0).

But it is probably worth configuring Gnus to use QP instead of base64.
It's more efficient (for mostly ascii text), more readable to humans
looking at the encoded form, and is less likely to make you look like a
spammer. :)

-Peff
