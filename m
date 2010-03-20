From: Jeff King <peff@peff.net>
Subject: Re: [gitk PATCH] gitk: Disable log.decorate config
Date: Sat, 20 Mar 2010 01:34:04 -0400
Message-ID: <20100320053404.GA12625@coredump.intra.peff.net>
References: <1269038663-11025-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Mar 20 06:34:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsrKO-0008Kd-5q
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab0CTFeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 01:34:11 -0400
Received: from peff.net ([208.65.91.99]:60989 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201Ab0CTFeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:34:11 -0400
Received: (qmail 1693 invoked by uid 107); 20 Mar 2010 05:34:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 20 Mar 2010 01:34:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Mar 2010 01:34:04 -0400
Content-Disposition: inline
In-Reply-To: <1269038663-11025-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142688>

On Fri, Mar 19, 2010 at 11:44:23PM +0100, Santi B=C3=A9jar wrote:

> Since eb73445 (Add `log.decorate' configuration variable., 2010-02-17=
)
> the log output changes if log.decorate is set. Gitk is unable to
> understand the new output (it returns the error: "Can't parse git log
> output: {commit $sha1 $sha2...}), so disable it with --no-decorate.

log.decorate is still in "next". My understanding was that it was not
going to graduate to "master" until this issue had been resolved, and
that the current plan was to disable config decoration for --pretty=3Dr=
aw.
That would solve the issue without any effort on the part of gitk.

-Peff
