From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 13/21] pack-objects: implement bitmap writing
Date: Sat, 21 Dec 2013 08:17:05 -0500
Message-ID: <20131221131705.GB10123@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124544.GM10757@sigill.intra.peff.net>
 <87d2l8k4es.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Dec 21 14:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuMQb-0000b4-5W
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab3LUNRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:17:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:48433 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUNRH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:17:07 -0500
Received: (qmail 4660 invoked by uid 102); 21 Dec 2013 13:17:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:17:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:17:05 -0500
Content-Disposition: inline
In-Reply-To: <87d2l8k4es.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239590>

On Sat, Dec 07, 2013 at 05:32:43PM +0100, Thomas Rast wrote:

> > +pack.writebitmaps::
> > +	When true, git will write a bitmap index when packing all
> > +	objects to disk (e.g., as when `git repack -a` is run).  This
>                                ^^
> 
> Doesn't sound right in my ears.  Remove the "as"?

It was meant to be "such as when...", but I think it is just as clear to
drop it. Will do.

-Peff
