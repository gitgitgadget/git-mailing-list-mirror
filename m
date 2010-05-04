From: Jeff King <peff@peff.net>
Subject: Re: [PATCH][CLEANUP] remove ecb parameter from xdi_diff_outf()
Date: Tue, 4 May 2010 16:58:53 -0400
Message-ID: <20100504205853.GA10716@coredump.intra.peff.net>
References: <4BE0867E.3060906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 04 22:59:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9PCr-0008Lu-1g
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 22:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112Ab0EDU65 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 16:58:57 -0400
Received: from peff.net ([208.65.91.99]:39186 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab0EDU65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 16:58:57 -0400
Received: (qmail 14286 invoked by uid 107); 4 May 2010 20:59:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 16:59:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 16:58:53 -0400
Content-Disposition: inline
In-Reply-To: <4BE0867E.3060906@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146343>

On Tue, May 04, 2010 at 10:41:34PM +0200, Ren=C3=A9 Scharfe wrote:

> xdi_diff_outf() overrides the structure members of its last parameter=
,
> ignoring any value that callers pass in.  It's no surprise then that =
all
> callers pass a pointer to an uninitialized structure.  They also don'=
t
> read it after the call, so the parameter is neither used for input no=
r
> for output.   Turn it into a local variable of xdi_diff_outf().

Heh:

  http://article.gmane.org/gmane.comp.version-control.git/102861

So,

Acked-by: Jeff King <peff@peff.net>

-Peff
