From: Jeff King <peff@peff.net>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Mon, 14 Jul 2014 02:04:00 -0400
Message-ID: <20140714060400.GC5593@sigill.intra.peff.net>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross>
 <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross>
 <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
 <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
 <20140712045616.GA14459@sigill.intra.peff.net>
 <CAOvwQ4gEeTS4o6dEUczq+tnS3HePbab-=NpWWA1Z5tkNTjMxfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:04:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ZMu-0007NF-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 08:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbaGNGEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 02:04:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:33441 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752649AbaGNGEC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 02:04:02 -0400
Received: (qmail 586 invoked by uid 102); 14 Jul 2014 06:04:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 01:04:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 02:04:00 -0400
Content-Disposition: inline
In-Reply-To: <CAOvwQ4gEeTS4o6dEUczq+tnS3HePbab-=NpWWA1Z5tkNTjMxfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253476>

On Sat, Jul 12, 2014 at 10:53:47AM +0200, Tuncer Ayaz wrote:

> On Sat, Jul 12, 2014 at 6:56 AM, Jeff King wrote:
> 
> > I think none of the regular devs uses PROFILE, and it bit-rotted
> 
> By the way, is there no build (CI) server for git.git to regularly
> test branches on different platforms or at least different build
> configs on the same platform?

Junio tests master and next on a few different platforms before pushing
out the results of topic integration. Other than that, we rely on people
to report problems (and people testing master or even next on their
platforms is very much appreciated, as it means we can fix problems
before they are cemented in a release).

-Peff
