From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6 rebase-version] Make git log --graph looks better
 with -p and other diff options
Date: Tue, 25 May 2010 05:33:37 -0400
Message-ID: <20100525093337.GB32460@coredump.intra.peff.net>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <20100525092336.GB30863@coredump.intra.peff.net>
 <AANLkTim9pDdz-VU8mGsoEaiv81RepaZT29h_5iAOo4bx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 11:33:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqWA-0003nT-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395Ab0EYJdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:33:41 -0400
Received: from peff.net ([208.65.91.99]:34337 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365Ab0EYJdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:33:41 -0400
Received: (qmail 18687 invoked by uid 107); 25 May 2010 09:33:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 05:33:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 05:33:37 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim9pDdz-VU8mGsoEaiv81RepaZT29h_5iAOo4bx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147702>

On Tue, May 25, 2010 at 05:31:23PM +0800, Bo Yang wrote:

> > I have to admit I don't quite understand from the commit message what
> > the problem is that this is fixing.
> 
> Ah, the previous code just call a emit_line for parts of the line, and
> this commit change this behavior. It firstly compose the different
> parts into one line and only call a emit_line. This is necessary
> because each time we call emit_line, there will be a graph prefix
> output. :)

OK. I understood what it _does_ from the commit message and seeing the
code, but the missing bit was that calling emit_line would get multiple
graph prefixes.

Thanks.

-Peff
