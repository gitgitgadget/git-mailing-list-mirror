From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 17:56:26 -0400
Message-ID: <20071031215625.GC14211@coredump.intra.peff.net>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org> <20071031140028.GA30207@diana.vm.bytemark.co.uk> <20071031143641.GF15182@dpotapov.dyndns.org> <20071031180557.GA12211@coredump.intra.peff.net> <7v8x5jgdck.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLYg-0005cR-Vv
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbXJaV43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbXJaV43
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:56:29 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4241 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872AbXJaV42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:56:28 -0400
Received: (qmail 24164 invoked by uid 111); 31 Oct 2007 21:56:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 31 Oct 2007 17:56:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 17:56:26 -0400
Content-Disposition: inline
In-Reply-To: <7v8x5jgdck.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62886>

On Wed, Oct 31, 2007 at 02:53:47PM -0700, Junio C Hamano wrote:

> The following is on top of 'master'.  I haven't tested it.  If it
> works, great.  If it doesn't, at least it should illustrate what
> needs to be touched.

You beat me to it, as I was busy flaming Linus. :)

The patch I started is very similar to this, but I had one concern that
I was tracking down: is the author name encoding necessarily the same as
the commit text encoding?

-Peff
