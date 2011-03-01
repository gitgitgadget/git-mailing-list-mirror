From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Tue, 01 Mar 2011 17:18:33 -0500
Message-ID: <1299017913.14490.10.camel@drew-northup.unet.maine.edu>
References: <20110225133056.GA1026@sigill.intra.peff.net>
	 <1298665854.27129.25.camel@drew-northup.unet.maine.edu>
	 <20110301220053.GB23945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:19:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuXvA-0005UH-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab1CAWTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:19:52 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:43226 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab1CAWTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:19:51 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p21MIdIu002570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Mar 2011 17:18:39 -0500
In-Reply-To: <20110301220053.GB23945@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p21MIdIu002570
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299622719.98933@hQYgqQ7r8HSKeijAVPcHIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168265>


On Tue, 2011-03-01 at 17:00 -0500, Jeff King wrote:
> On Fri, Feb 25, 2011 at 03:30:54PM -0500, Drew Northup wrote:
> 
> > > So your commit template looks like:
> > > 
> > >   subject
> > > 
> > >   commit message body
> > >   ---
> > >   notes data
> > > 
> > >   # usual template stuff
> > > 
> > > I'm curious what people think. Do others find this useful? Does it seem
> > > harmful?
> > > 
> > 
> > I'm in agreement with the others that it doesn't seem like a bad idea,
> > and likely a good one. Just one thing, can you add an end-of-note
> > delimiter (the same thing perhaps)? I didn't spend a long time looking
> > at the code, but I can imagine more than a few ways for this to go wrong
> > without one.
> 
> We could add one pretty easily, but I'm not sure what you would be
> delimiting it from. Can you describe a case where it would be useful?
> 
> -Peff

A notes message which contains "the usual template stuff" as means of
describing a change to it, for starters...

There is likely good reason why the commit message already has an end
mark, I suspect that also applies here. (Unless you count "---" between
the commit message and the patch as "the usual template stuff"--which
wasn't clear at this keyboard anyway.) If that's already in there then
please forgive the noise--it didn't jump out at me, but I also spend way
too much time programming in too many languages for that to be very
likely.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
