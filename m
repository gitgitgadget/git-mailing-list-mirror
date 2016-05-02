From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 2 May 2016 14:02:31 -0400
Message-ID: <20160502180231.GA8812@sigill.intra.peff.net>
References: <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
 <20160420041827.GA7627@sigill.intra.peff.net>
 <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
 <xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
 <1461969582.731.1.camel@intel.com>
 <CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
 <1461970113.731.3.camel@intel.com>
 <xmqqfuu0uzn7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"sbeller@google.com" <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:02:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIB4-0001pK-Of
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbcEBSCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:02:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:60419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753818AbcEBSCe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:02:34 -0400
Received: (qmail 6551 invoked by uid 102); 2 May 2016 18:02:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 14:02:34 -0400
Received: (qmail 16860 invoked by uid 107); 2 May 2016 18:02:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 14:02:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2016 14:02:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfuu0uzn7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293254>

On Mon, May 02, 2016 at 10:40:28AM -0700, Junio C Hamano wrote:

> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
> 
> > True. I think the chances that it needs such a thing are quite minor,
> > and if an undocumented knob gets exposed it would have to become
> > documented and maintained, so I'd prefer to avoid it. Given that the
> > risk is pretty small I think that's ok.
> 
> OK, then let's do only the "documentation" part.
> 
> -- >8 --
> Subject: [PATCH] diff: undocument the compaction heuristic knobs for experimentation
> 
> It seems that people around here are all happy with the updated
> heuristics used to decide where the hunks are separated.  Let's keep
> that as the default.  Even though we do not expect too much trouble
> from the difference between the old and the new algorithms, just in
> case let's leave the implementation of the knobs to turn it off for
> emergencies.  There is no longer need for documenting them, though.

I agree with this reasoning. Thanks.

-Peff
