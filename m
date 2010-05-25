From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6 rebase-version] Make git log --graph looks better
 with -p and other diff options
Date: Tue, 25 May 2010 05:47:16 -0400
Message-ID: <20100525094716.GB984@coredump.intra.peff.net>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <20100525092336.GB30863@coredump.intra.peff.net>
 <AANLkTim9pDdz-VU8mGsoEaiv81RepaZT29h_5iAOo4bx@mail.gmail.com>
 <20100525093337.GB32460@coredump.intra.peff.net>
 <AANLkTin1Ouo9DsEIp6s6vLVbsXvBps7NooJyMjx5e8e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 11:47:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqjP-0002Ac-Cy
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282Ab0EYJrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:47:21 -0400
Received: from peff.net ([208.65.91.99]:52881 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756413Ab0EYJrU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:47:20 -0400
Received: (qmail 18850 invoked by uid 107); 25 May 2010 09:47:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 05:47:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 05:47:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin1Ouo9DsEIp6s6vLVbsXvBps7NooJyMjx5e8e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147706>

On Tue, May 25, 2010 at 05:39:18PM +0800, Bo Yang wrote:

> > OK. I understood what it _does_ from the commit message and seeing the
> > code, but the missing bit was that calling emit_line would get multiple
> > graph prefixes.
> >
> 
> Hmm, as I design, emit_line will be used for emit a complete line out,
> so I can add the prefix output code in the emit_line function. And
> thus, I should make sure, no one call emit_line to just output some
> strings instead of a complete line...

Right, I get it now. I was just complaining that that important
information was not in the patch's commit message. :)

-Peff
