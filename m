From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 02:26:06 -0500
Message-ID: <20140228072606.GA622@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <531032DD.9000904@viscovery.net>
 <20140228071401.GA1229@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 08:26:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHpm-0002xK-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaB1H0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 02:26:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:58528 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750701AbaB1H0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 02:26:08 -0500
Received: (qmail 13137 invoked by uid 102); 28 Feb 2014 07:26:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 01:26:08 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 02:26:06 -0500
Content-Disposition: inline
In-Reply-To: <20140228071401.GA1229@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242898>

On Fri, Feb 28, 2014 at 02:14:01AM -0500, Jeff King wrote:

> I didn't think we bothered to make "sh -x" work robustly. I don't mind
> if we do, but "git grep -E 'test_(i18n)?cmp .*err" shows many potential
> problem spots.

Just for fun:

  cd t
  make SHELL_PATH="sh -x" prove

causes 326 test failures across 43 scripts. That's slightly misleading,
because 200 of the failures are all in t0008, and updating one function
would probably clear up all of them.

-Peff
