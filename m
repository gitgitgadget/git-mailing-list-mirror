From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 14:05:57 -0400
Message-ID: <20071031180557.GA12211@coredump.intra.peff.net>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org> <20071031140028.GA30207@diana.vm.bytemark.co.uk> <20071031143641.GF15182@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InHxL-0001ja-3e
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 19:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbXJaSGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXJaSGD
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 14:06:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2366 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbXJaSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 14:06:01 -0400
Received: (qmail 18063 invoked by uid 111); 31 Oct 2007 18:05:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 31 Oct 2007 14:05:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 14:05:57 -0400
Content-Disposition: inline
In-Reply-To: <20071031143641.GF15182@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62852>

On Wed, Oct 31, 2007 at 05:36:41PM +0300, Dmitry Potapov wrote:

> Hmm... I looked at the mail again and I cannot see where 8859-1 is
> specified. It seems that context encoding is not specified at all.
> Of course, it is incorrect to use non ASCII characters in a mail
> without specifying encoding. Apparently, because I use utf-8 in the
> terminal, the Sign-off line displays correctly for me, so I did not
> notice the problem. Sorry for the noise...

It is our old friend vger adding the iso-8859-1 header, I think, since
no encoding was specified.

I think the problem is that git-format-patch only decides whether to
append a MIME header based on the commit message contents; it does not
take the Signed-Off-By into account. This may also be the cause of the
recent complaints from Matti Aarnio.

-Peff
