From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Wed, 14 Nov 2012 17:56:08 -0800
Message-ID: <20121115015608.GB19131@sigill.intra.peff.net>
References: <20121113175205.GA26960@sigill.intra.peff.net>
 <50A2B14C.9040608@web.de>
 <50A2F17D.4010907@gmail.com>
 <20121114190228.GA3860@sigill.intra.peff.net>
 <50A40978.2060504@web.de>
 <20121115001635.GA17370@sigill.intra.peff.net>
 <50A44A73.8020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYogs-0003NM-9E
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992625Ab2KOB4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:56:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48923 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992614Ab2KOB4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:56:11 -0500
Received: (qmail 10466 invoked by uid 107); 15 Nov 2012 01:57:00 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 20:57:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 17:56:08 -0800
Content-Disposition: inline
In-Reply-To: <50A44A73.8020007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209790>

On Wed, Nov 14, 2012 at 08:50:43PM -0500, Mark Levedahl wrote:

> Cygwin changed the win32api implementation, and the old is not just
> no longer supported for the current release series, but virtually
> impossible to even install (several new packages are now installed,
> the old package is in the "obsolete" category, i.e., not available).
> The older cygwin 1.5 dll + utilities can be installed afresh, so that
> is why I set up to switch based upon dll version - the proposed
> test(s) and configuration would be to have git maintain compatibility
> with an unsupported Cygwin configuration. I just don't think this is
> worth the maintenance burden, but of course I am not the maintainer,
> just expressing my opinion.

OK. I don't have a strong opinion either, as I don't know what's normal
in the Cygwin world, and that is probably the most important thing to
follow for the default. I got the impression that "normal" is changing
to the new way, but Torsten's message made me wonder if were there quite
yet (if there was some issue with upgrades versus new fresh installs).

But I have no real cygwin knowledge, so I'll bow out and let you guys
discuss.

-Peff
