From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Support for running tests outside t/ + don't
 run a TODO test
Date: Thu, 19 Aug 2010 12:18:21 -0400
Message-ID: <20100819161821.GA27381@sigill.intra.peff.net>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
 <1282234092-27429-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 18:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7ov-0007sb-VG
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0HSQSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:18:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44544 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871Ab0HSQST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:18:19 -0400
Received: (qmail 14798 invoked by uid 111); 19 Aug 2010 16:18:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 19 Aug 2010 16:18:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Aug 2010 12:18:21 -0400
Content-Disposition: inline
In-Reply-To: <1282234092-27429-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153941>

On Thu, Aug 19, 2010 at 04:08:08PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> As an aside there's a bunch of other things in our tests that are
> writing out shellscripts with a #!/bin/sh shebang instead of
> #!$SHELL_PATH. These are passing purely by accident since they just
> happen to use shell syntax that doesn't run afoul of grumpy old shell=
s
> like Solaris's /bin/sh.

It's not an accident. I (and others) checked them all when $SHELL_PATH
became available to the test scripts, and declared them all trivial. Bu=
t
I would not be opposed to making them all #!$SHELL_PATH.

-Peff
