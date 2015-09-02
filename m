From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 17:27:34 -0400
Message-ID: <20150902212733.GA21612@sigill.intra.peff.net>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <20150901224431.GA9353@sigill.intra.peff.net>
 <20150902074826.GK30659@serenity.lan>
 <20150902080529.GA19248@sigill.intra.peff.net>
 <xmqq4mjcq2ac.fsf@gitster.mtv.corp.google.com>
 <20150902194946.GL30659@serenity.lan>
 <xmqqk2s8mvig.fsf@gitster.mtv.corp.google.com>
 <20150902202148.GM30659@serenity.lan>
 <xmqqfv2wmup7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 23:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXFZF-0007d4-5a
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 23:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbbIBV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 17:27:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:54000 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756085AbbIBV1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 17:27:37 -0400
Received: (qmail 22072 invoked by uid 102); 2 Sep 2015 21:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Sep 2015 16:27:37 -0500
Received: (qmail 4402 invoked by uid 107); 2 Sep 2015 21:27:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Sep 2015 17:27:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2015 17:27:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv2wmup7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277125>

On Wed, Sep 02, 2015 at 01:29:08PM -0700, Junio C Hamano wrote:

> John Keeping <john@keeping.me.uk> writes:
> 
> > In which case, should we just support it now?
> >
> > Normally I'd suggest banning controversial options on the basis that
> > it's easier in the future to allow something that was previously banned
> > than change the meaning of an options, but in this case I can't see any
> > other meaning for these options than that described above.
> 
> My usual stance is the same as yours, and I agree that there is no
> other sane and useful behaviour for "relative-local" to do the same
> as "relative".

That sounds fine to me. Then we don't have to worry about the error
messages. ;)

-Peff
