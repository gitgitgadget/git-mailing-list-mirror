From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 17:31:50 -0400
Message-ID: <20160504213149.GA22828@sigill.intra.peff.net>
References: <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
 <5729DF25.7030503@ramsayjones.plus.com>
 <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
 <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
 <20160504192516.GD21259@sigill.intra.peff.net>
 <xmqq7ff9h9zo.fsf@gitster.mtv.corp.google.com>
 <20160504200635.GA22787@sigill.intra.peff.net>
 <xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4Ol-0005B3-Mq
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbcEDVbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:31:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:34245 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752702AbcEDVbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:31:53 -0400
Received: (qmail 5510 invoked by uid 102); 4 May 2016 21:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 17:31:52 -0400
Received: (qmail 14243 invoked by uid 107); 4 May 2016 21:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 17:32:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 17:31:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8tzpfrt0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293595>

On Wed, May 04, 2016 at 02:15:39PM -0700, Junio C Hamano wrote:

> > make sense? Or a simpler but non-streaming spelling:
> >
> >   my @files = map { chomp; $_ } `git ls-files`;
> 
> I forgot to say that I wanted not to rely on "git" (i.e. OK to use
> this on tarball extract).

Oh, that's a good idea.

> > Or just taking the list of files on the command line as your original
> > did, and feeding `ls-files` from the caller. That also lets you do
> > "link-gitlink git-foo.txt", etc.
> 
> Yes, I think that is the most sensible.

Yeah, and then the Makefile can drive it from $(MAN_TXT), etc, without
requiring git (which I think is what you were getting at, but just
spelling it out for myself and the list).

-Peff
