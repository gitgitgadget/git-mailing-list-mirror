From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 13:23:41 +0100
Message-ID: <20090210122341.GH1320@atjola.homenet>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com> <20090210075214.GC1320@atjola.homenet> <20090210111907.GD12089@coredump.intra.peff.net> <20090210115036.GG1320@atjola.homenet> <20090210115943.GA15387@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrgD-0008F6-NA
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbZBJMYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 07:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbZBJMYG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:24:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:43120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750887AbZBJMYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:24:03 -0500
Received: (qmail invoked by alias); 10 Feb 2009 12:24:02 -0000
Received: from i577B9B52.versanet.de (EHLO atjola.local) [87.123.155.82]
  by mail.gmx.net (mp047) with SMTP; 10 Feb 2009 13:24:02 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/VJcAmqaTVFfkQxZ0MIUv2DFYDI5h2Mz3hP4JMP5
	j9pbu55aLZuisn
Content-Disposition: inline
In-Reply-To: <20090210115943.GA15387@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109222>

On 2009.02.10 06:59:43 -0500, Jeff King wrote:
> On Tue, Feb 10, 2009 at 12:50:36PM +0100, Bj=F6rn Steinbrink wrote:
> > Yeah, as I said in the other mail, having it as a default would mak=
e add
> > -m quite pointless.
>=20
> Not necessarily. You might be interested in some other branch that is=
n't
> their HEAD. So yes, you would hopefully be using it much less because=
 we
> would be guessing what you wanted to put there instead of making you
> type it. But it would still be useful as an override.

I guess you read that in the wrong context (or I replied in the wrong
context). What I meant is that it would be bad if "git remote update" o=
r
"git fetch <remote>" or whatever would update <remote>/HEAD
automatically, as that would kill what you have setup with -m.

Using -m as an override for the automatic guessing makes sense, sure.
It's even what the docs say how it's supposed to work already (it just
doesn't create <remote>/HEAD at all atm, unless -m is given).

Bj=F6rn
