From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Some improvements for git-imap-send
Date: Tue, 9 Feb 2010 13:54:10 -0500
Message-ID: <20100209185410.GA22092@coredump.intra.peff.net>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
 <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <20100209150650.GA15982@sigill.intra.peff.net>
 <40aa078e1002090713h7e7d2f93r4cca9649e98db735@mail.gmail.com>
 <20100209165745.GA21135@coredump.intra.peff.net>
 <40aa078e1002091037j226eb911v215a5564cba42142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, gitster@pobox.com,
	git@vger.kernel.org, jwhite@codeweavers.com,
	robertshearman@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 09 19:54:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NevE0-0007Kp-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 19:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab0BISyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 13:54:11 -0500
Received: from peff.net ([208.65.91.99]:45539 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab0BISyK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 13:54:10 -0500
Received: (qmail 24013 invoked by uid 107); 9 Feb 2010 18:54:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 13:54:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 13:54:10 -0500
Content-Disposition: inline
In-Reply-To: <40aa078e1002091037j226eb911v215a5564cba42142@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139431>

On Tue, Feb 09, 2010 at 07:37:44PM +0100, Erik Faye-Lund wrote:

> > Did you mean "SASL-support that is needed for CRAM-MD5"? The SASL n=
eeded
> > for that is pretty simple. Hitoshi's patch 3/4 does all of that alr=
eady
> > in less than 100 lines. =C2=A0Using a "real" sasl library might get=
 us more
> > authentication methods than CRAM-MD5, but I don't know that anyone
> > necessarily cares about them.
>=20
> No, that's not what I meant. I agree that CRAM-MD5 should be
> sufficient, but to be honest I'd already thought that once you have a=
n
> SSL connection, plaintext would also be sufficient. So I'm thinking o=
f
> this addition as a "hmpf, some server requires stuff that is really
> over the top - perhaps we'll have this problem later with other
> servers, and we'd be better off just using some well-tested
> implementation". But that's kinda philosophical.

Ah, I see. Yes, it's possible that we may want to support other
authentication methods later. In my experience, CRAM-MD5 is the only
common non-plain IMAP mechanism used by IMAP, but I admit it has been
quite a number of years since I actively paid attention to such things.

I'd leave that choice to whoever feels like implementing it. :)

-Peff
