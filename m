From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Wed, 14 Mar 2012 23:56:42 -0400
Message-ID: <20120315035642.GB4149@sigill.intra.peff.net>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 15 04:56:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S81o2-0002pl-7w
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 04:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386Ab2COD4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 23:56:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49582
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847Ab2COD4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 23:56:45 -0400
Received: (qmail 16206 invoked by uid 107); 15 Mar 2012 03:56:56 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Mar 2012 23:56:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2012 23:56:42 -0400
Content-Disposition: inline
In-Reply-To: <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193176>

On Wed, Mar 14, 2012 at 03:18:23PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> -pre_test() {
> -	test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
> -	eval "$GIT_TEST_CREDENTIAL_HELPER_SETUP"
> [...]
> +$GIT_TEST_CREDENTIAL_HELPER_SETUP

Except for losing the eval here that Junio mentioned, I think both
patches look good.

-Peff
