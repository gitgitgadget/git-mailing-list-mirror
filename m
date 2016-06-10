From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] diff: disable compaction heuristic for now
Date: Fri, 10 Jun 2016 16:53:57 -0400
Message-ID: <20160610205357.GA22470@sigill.intra.peff.net>
References: <20160610075043.GA13411@sigill.intra.peff.net>
 <20160610083102.GA14192@sigill.intra.peff.net>
 <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
 <CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
 <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
 <20160610203026.GA21464@sigill.intra.peff.net>
 <xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:54:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTRb-0007nr-Cz
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbcFJUyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:54:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:52993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752704AbcFJUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:54:06 -0400
Received: (qmail 30210 invoked by uid 102); 10 Jun 2016 20:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 16:54:00 -0400
Received: (qmail 8806 invoked by uid 107); 10 Jun 2016 20:54:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 16:54:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2016 16:53:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297072>

On Fri, Jun 10, 2016 at 01:48:58PM -0700, Junio C Hamano wrote:

>     Jeff King <peff@peff.net> writes:
> 
>     > We probably want a patch to the release notes to note that it's not on
>     > by default. And we may want to advertise the experimental knob so
>     > that people actually try it (otherwise we won't get feedback from the
>     > masses).
> 
>     OK, I think that is sensible.  The interdiff is not a strict
>     reversion of 77085a61 (diff: undocument the compaction heuristic
>     knobs for experimentation, 2016-05-02) but stresses that the
>     feature is off by default and is experimental.

Looks good to me. Do we want to include in "experimental" that the
option and command-line flag might go away in the future? I think
probably not. I do not mind supporting this forever (it _has_ shown its
usefulness, so I don't think it is any worse to maintain going forward
than things like --patience, which people can tweak if their diff looks
uglier than they would like).

-Peff
