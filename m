From: Jeff King <peff@peff.net>
Subject: Re: System wide gitattributes
Date: Thu, 24 Sep 2009 03:08:57 -0400
Message-ID: <20090924070857.GA461@coredump.intra.peff.net>
References: <4AB0D0EB.5080105@andrena.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?Q?F=C3=B6rster?= <david.foerster@andrena.de>
X-From: git-owner@vger.kernel.org Thu Sep 24 09:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqiRj-0001Uw-Vg
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 09:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbZIXHIq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbZIXHIq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 03:08:46 -0400
Received: from peff.net ([208.65.91.99]:46312 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbZIXHIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 03:08:46 -0400
Received: (qmail 3390 invoked by uid 107); 24 Sep 2009 07:12:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Sep 2009 03:12:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2009 03:08:57 -0400
Content-Disposition: inline
In-Reply-To: <4AB0D0EB.5080105@andrena.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129027>

On Wed, Sep 16, 2009 at 01:50:03PM +0200, David F=C3=B6rster wrote:

> from the documentation I understand that things like external diff
> tools can be set up in a gitattributes file per repository (or
> subfolder).
>=20
> Why is there no support for a ~/.gitattributes file? This would be
> very handy, for example to always get a textual diff of OpenDocument
> files.

I think it is simply that nobody found it particularly useful until now=
,
and so nobody implemented it. Gitattributes tend to be somewhat tied to
the project files themselves. However, I can certainly see the use of
something like "*.doc diff=3Dword" in your ~/.gitattributes.

So I think it is a sound concept; it just needs somebody to volunteer t=
o
write it.

-Peff
