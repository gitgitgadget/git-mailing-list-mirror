From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] t/README: Tests are all +x, ./test, not sh ./test
Date: Thu, 1 Jul 2010 11:42:12 -0400
Message-ID: <20100701154211.GA15542@sigill.intra.peff.net>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
 <1277997004-29504-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 17:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULuD-0002Fz-KP
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab0GAPmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:42:15 -0400
Received: from peff.net ([208.65.91.99]:35220 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab0GAPmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:42:14 -0400
Received: (qmail 6756 invoked by uid 107); 1 Jul 2010 15:43:08 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 01 Jul 2010 11:43:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jul 2010 11:42:12 -0400
Content-Disposition: inline
In-Reply-To: <1277997004-29504-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150050>

On Thu, Jul 01, 2010 at 03:09:57PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> They all run with a #!/bin/sh shebang, but it's probably better to us=
e
> the ./ form anyway.

If we want to be nitpicky, they are actually run by "make test" with
$SHELL_PATH. We don't re-write the shebang lines in the test scripts (a=
s
we do with the actual git-* scripts), so running "./t-whatever" won't
work if you have a broken shell (e.g., Solaris). You have to do "bash
=2E/t-whatever".

-Peff
