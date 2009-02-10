From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 08:04:16 -0500
Message-ID: <20090210130416.GB17305@coredump.intra.peff.net>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com> <20090210075214.GC1320@atjola.homenet> <20090210111907.GD12089@coredump.intra.peff.net> <20090210115036.GG1320@atjola.homenet> <20090210115943.GA15387@coredump.intra.peff.net> <20090210122341.GH1320@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsJ8-0004a5-Fg
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZBJNEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 08:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbZBJNET
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:04:19 -0500
Received: from peff.net ([208.65.91.99]:45422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbZBJNES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:04:18 -0500
Received: (qmail 13656 invoked by uid 107); 10 Feb 2009 13:04:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 08:04:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 08:04:16 -0500
Content-Disposition: inline
In-Reply-To: <20090210122341.GH1320@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109233>

On Tue, Feb 10, 2009 at 01:23:41PM +0100, Bj=C3=B6rn Steinbrink wrote:

> > > Yeah, as I said in the other mail, having it as a default would m=
ake add
> > > -m quite pointless.
> >=20
> > Not necessarily. You might be interested in some other branch that =
isn't
> > their HEAD. So yes, you would hopefully be using it much less becau=
se we
> > would be guessing what you wanted to put there instead of making yo=
u
> > type it. But it would still be useful as an override.
>=20
> I guess you read that in the wrong context (or I replied in the wrong
> context). What I meant is that it would be bad if "git remote update"=
 or
> "git fetch <remote>" or whatever would update <remote>/HEAD
> automatically, as that would kill what you have setup with -m.

Ah, OK, I totally misunderstood. Yes, I think we are in agreement, then=
=2E

-Peff
