From: Jeff King <peff@peff.net>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Tue, 27 Jul 2010 01:46:38 -0400
Message-ID: <20100727054638.GA6662@coredump.intra.peff.net>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com>
 <AANLkTin9kbMp5nOS=GaM2rX1w+y8vbzYfWunkSSeoPZg@mail.gmail.com>
 <20100727053040.GA6014@coredump.intra.peff.net>
 <AANLkTin+jUB85Zua7TP_dmdU9QSEiAuTDZhPQQ7hQTP-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 07:46:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odd03-0001SS-5r
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 07:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab0G0Fqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 01:46:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52161 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab0G0Fql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 01:46:41 -0400
Received: (qmail 13739 invoked by uid 111); 27 Jul 2010 05:46:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 27 Jul 2010 05:46:40 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jul 2010 01:46:38 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin+jUB85Zua7TP_dmdU9QSEiAuTDZhPQQ7hQTP-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151913>

On Tue, Jul 27, 2010 at 01:42:39AM -0400, Avery Pennarun wrote:

> On Tue, Jul 27, 2010 at 1:30 AM, Jeff King <peff@peff.net> wrote:
> > On Fri, Jul 23, 2010 at 02:16:45AM -0400, Avery Pennarun wrote:
> >> Only this: Junio said that there are no major downsides to this ch=
ange
> >> - and given the slow pace of change in gitk/git-gui, this is proba=
bly
> >> true - but are there any *upsides*? =C2=A0What problem does this s=
olve?
> >
> > One minor complaint with the current setup is that browsing the his=
tory
> > with path limiting is unintuitive. You can't do "gitk gitk" in the
> > gitk-git directory. You must instead do "cd .. && gitk -- gitk".
>=20
> Arguably this would be an encouragement to fix the path limiting code=
,
> in a similar way that people expect switching to a submodule setup to
> encourage people to fix submodules :)

Heh. Somewhat true. My multi-file --follow code actually handles "git
log --follow gitk-git", but it does look awful in gitk. And that is not
likely to be fixed soon, as --follow and things like parent rewriting
simply don't work together at this point.

-Peff
