From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] add--interactive: better mode change handling
Date: Thu, 27 Mar 2008 03:29:31 -0400
Message-ID: <20080327072931.GA22444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 08:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JemYx-0007I1-MN
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 08:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbYC0H3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2008 03:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYC0H3e
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 03:29:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3188 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbYC0H3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 03:29:34 -0400
Received: (qmail 15529 invoked by uid 111); 27 Mar 2008 07:29:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 03:29:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 03:29:31 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78338>

This was spawned by a bug report from J=C3=B6rg about "git add -i"'s ha=
ndling
of mode changes. I don't think it's actually a bug, but rather a featur=
e
request, and as such should happen post-1.5.5.

The two patches are:

  [1/2] add--interactive: ignore mode change in 'p'atch command
  [2/2] add--interactive: allow user to choose mode update

Actually, you might argue that 1/2 _is_ a bugfix, though not quite the
same one that was reported.  I don't actually like the behavior after
just 1/2 is applied, but I split the changes to be more readable.

There may potentially be a "[3/2] change the name of the 'p'atch
command" since it is now not just about the patch (actually, since git
patches _do_ include mode changes, it maybe is appropriate). Wincent
suggested "pick" which I think is reasonable. I'm not planning on doing
such a 3/2, but I'm sure some industrious soul can make arguments for o=
r
against changing the name. I will let them handle the ensuing bikeshed
jamboree.

-Peff
