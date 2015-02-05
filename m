From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s"
 as for "ln" / "cp"
Date: Thu, 5 Feb 2015 14:51:43 -0500
Message-ID: <20150205195143.GB15326@peff.net>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
 <D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
 <xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
 <CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSSs-0006RN-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbbBETvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:51:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:45660 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752000AbbBETvp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:51:45 -0500
Received: (qmail 7982 invoked by uid 102); 5 Feb 2015 19:51:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 13:51:45 -0600
Received: (qmail 1771 invoked by uid 107); 5 Feb 2015 19:51:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Feb 2015 14:51:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Feb 2015 14:51:43 -0500
Content-Disposition: inline
In-Reply-To: <CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263393>

On Thu, Feb 05, 2015 at 08:26:08PM +0100, Sebastian Schuberth wrote:

> > It is not even correct, is it?
> >
> > When DESTDIR is set to allow you to install into a temporary place
> > only so that you can "tar" up the resulting filesystem tree, bindir
> > points at the location we need to "cp" the built programs into, i.e.
> > inside DESTDIR.
> 
> Agreed folks, please disregard this as well as 2/2 of this series.

We would still want an equivalent to 2/2 to set up a relative symlink
for $(ALL_PROGRAMS), though, right?

-Peff
