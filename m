From: Jeff King <peff@peff.net>
Subject: Re: [PATCH next v2] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 12:19:25 -0500
Message-ID: <20090114171925.GA16199@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E129B.3020502@trolltech.com> <20090114165633.GC15758@coredump.intra.peff.net> <496E1D77.6000307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tavestbo@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9QF-0005o3-06
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763608AbZANRT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762204AbZANRT2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:19:28 -0500
Received: from peff.net ([208.65.91.99]:57036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757387AbZANRT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 12:19:27 -0500
Received: (qmail 2185 invoked by uid 107); 14 Jan 2009 17:19:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Jan 2009 12:19:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2009 12:19:25 -0500
Content-Disposition: inline
In-Reply-To: <496E1D77.6000307@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105668>

On Wed, Jan 14, 2009 at 06:14:31PM +0100, Johannes Sixt wrote:

> A the point was that $MSG contains \n, which should be turned int LF. IMO,
> the easiest way to achieve this is:
> 
> MSG='b3
> c3c3c3c3
> d3d3d3'
> 
> test_expect_success ' ... ' '
>    ...
>    MSG="$MSG" git notes edit
> '
> 
> and go back to using echo in the part cited above.

Yes, sorry, I hadn't read his original patch carefully. I think that is
a sane solution.

-Peff
