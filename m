From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 01:48:59 -0400
Message-ID: <20160601054858.GA25528@sigill.intra.peff.net>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
 <20160531225628.GA4585@sigill.intra.peff.net>
 <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
 <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <574E771C.7030009@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 07:49:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7z1h-0002G6-54
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 07:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbcFAFtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 01:49:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:46976 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751195AbcFAFtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 01:49:03 -0400
Received: (qmail 19762 invoked by uid 102); 1 Jun 2016 05:49:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 01:49:02 -0400
Received: (qmail 30185 invoked by uid 107); 1 Jun 2016 05:49:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 01:49:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 01:48:59 -0400
Content-Disposition: inline
In-Reply-To: <574E771C.7030009@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296054>

On Wed, Jun 01, 2016 at 07:48:12AM +0200, Johannes Sixt wrote:

> Am 01.06.2016 um 05:31 schrieb Jeff King:
> > 	printf '%s' "$1" | sed "s/'/'\\\\''/g"
> ...
> > 	export -p | grep "^declare -x $1="
> ...
> > 					"$fake_env_var_=$(shellquote "$fake_env_orig_")"
> ...
> > 			eval "$fake_env_var_=$(shellquote "$fake_env_val_")"
> 
> An intolerable number of new processes... Please stop this mental exercise.

Please read to the end of the thread?

-Peff
