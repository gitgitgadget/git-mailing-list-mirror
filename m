From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Fri, 30 Jul 2010 08:34:43 -0400
Message-ID: <20100730123443.GA11936@coredump.intra.peff.net>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 14:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oeonh-0003P3-9d
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 14:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab0G3Mew convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 08:34:52 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0G3Mev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 08:34:51 -0400
Received: (qmail 2036 invoked by uid 111); 30 Jul 2010 12:34:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Fri, 30 Jul 2010 12:34:49 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jul 2010 08:34:43 -0400
Content-Disposition: inline
In-Reply-To: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152242>

On Thu, Jul 29, 2010 at 09:20:55PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

>   - Is this worthwhile. Are there developers / packagers / other
>     interested parties here who'd be interested in actually running
>     smoke testers? It should be really easy to set one up.

A few of us were running automated build/tests for a while. Check out:

  http://repo.or.cz/w/git/gitbuild.git

especially:

  http://repo.or.cz/w/git/gitbuild.git/tree/platform

Unfortunately the SunOS and FreeBSD machines I tested on went away, so =
I
am not actually running anything automated anymore. Mike Ralphson was
testing on AIX, but seems to have stopped, as well.

I think these days Junio runs the test suite through a couple of VMs,
but I don't know exactly which platforms, or how often he does so.

-Peff
