From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t0303: resurrect commit message as test documentation
Date: Mon, 12 Mar 2012 08:31:53 -0400
Message-ID: <20120312123153.GB14456@sigill.intra.peff.net>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
 <1331553907-19576-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Mar 12 13:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S74Pw-0001Rm-He
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 13:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab2CLMb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 08:31:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47656
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2CLMb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 08:31:56 -0400
Received: (qmail 15798 invoked by uid 107); 12 Mar 2012 12:32:06 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Mar 2012 08:32:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2012 08:31:53 -0400
Content-Disposition: inline
In-Reply-To: <1331553907-19576-3-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192864>

On Mon, Mar 12, 2012 at 01:05:07PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> The commit message which added those tests (861444f 't: add test
> harness for external credential helpers' 2011-12-10) provided nice
> documentation in the commit message. Let's make it more visible.

Thanks, good idea.

> +# If your helper supports time-based expiration with a
> +# configurable timeout, you can test that feature with:
> +#
> +#  GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=3D"foo --timeout=3D1" \
> +#      make t0303-credential-external.sh

This example is slightly bogus, as described in my previous message. It
needs to set GIT_TEST_CREDENTIAL_HELPER, as well.

-Peff
