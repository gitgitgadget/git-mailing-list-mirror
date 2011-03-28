From: Jeff King <peff@peff.net>
Subject: Re: git @ be919d50 broken on OSX build
Date: Mon, 28 Mar 2011 12:33:55 -0400
Message-ID: <20110328163355.GB18774@sigill.intra.peff.net>
References: <86lizzi4zv.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:34:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4FOJ-0006yr-Vz
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab1C1Qd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:33:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47179
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab1C1Qd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:33:57 -0400
Received: (qmail 13029 invoked by uid 107); 28 Mar 2011 16:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Mar 2011 12:34:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Mar 2011 12:33:55 -0400
Content-Disposition: inline
In-Reply-To: <86lizzi4zv.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170153>

On Mon, Mar 28, 2011 at 09:28:36AM -0700, Randal L. Schwartz wrote:

> ...
>     GEN git-add--interactive
> Writing perl.mak for Git
> make[2]: *** [perl.mak] Error 1
> make[1]: *** [instlibdir] Error 2
> make: *** [git-add--interactive] Error 2

Hmm. That looks like our parallel-build recursive-make heisenbug. If you
redo the "make", does it work?

If not, do you mind bisecting? be919d50 updates the release notes, so it
is probably not the cause. :)

-Peff
