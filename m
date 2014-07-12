From: Jeff King <peff@peff.net>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Sat, 12 Jul 2014 00:56:17 -0400
Message-ID: <20140712045616.GA14459@sigill.intra.peff.net>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross>
 <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross>
 <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
 <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 06:59:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5pP1-000493-9p
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 06:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaGLE4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 00:56:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:60617 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaGLE4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 00:56:21 -0400
Received: (qmail 20360 invoked by uid 102); 12 Jul 2014 04:56:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 23:56:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jul 2014 00:56:17 -0400
Content-Disposition: inline
In-Reply-To: <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253381>

On Fri, Jul 11, 2014 at 12:12:55AM +0200, Tuncer Ayaz wrote:

> Sorry, didn't test properly when I tried with/without config.mak, and
> PROFILE=BUILD was the problem. I had that in config.mak based on
> information gathered from INSTALL and Makefile. To be clear, is
> PROFILE=BUILD (still) supported?

I think none of the regular devs uses PROFILE, and it bit-rotted
somewhat. Andi Kleen recently posted a series to fix it[1]. I can
reproduce your problem without that series, but compiling with
ak/profile-feedback-build merged in seems to work OK.

[1] http://thread.gmane.org/gmane.comp.version-control.git/253005
