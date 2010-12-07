From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-rm.txt: Fix quoting
Date: Tue, 7 Dec 2010 12:25:42 -0500
Message-ID: <20101207172542.GA25827@sigill.intra.peff.net>
References: <4CFDF388.6060907@drmicha.warpmail.net>
 <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
 <20101207171939.GA21105@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:25:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ1IV-0007aE-1D
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0LGRZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:25:46 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab0LGRZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 12:25:45 -0500
Received: (qmail 25665 invoked by uid 111); 7 Dec 2010 17:25:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 17:25:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 12:25:42 -0500
Content-Disposition: inline
In-Reply-To: <20101207171939.GA21105@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163094>

On Tue, Dec 07, 2010 at 11:19:39AM -0600, Jonathan Nieder wrote:

> Michael J Gruber wrote:
> 
> > --- a/Documentation/git-rm.txt
> > +++ b/Documentation/git-rm.txt
> > @@ -111,8 +111,8 @@ tree using this command:
> >  git ls-files -z | xargs -0 rm -f
> >  ----------------
> >  
> > -and then "untar" the new code in the working tree. Alternately
> > -you could "rsync" the changes into the working tree.
> > +and then `untar` the new code in the working tree. Alternately
> > +you could `rsync` the changes into the working tree.
> 
> I like the patch.  Is there really an "untar" command?

Heh. Yeah, I was so caught up in looking at formatting that I didn't
think about the actual meaning. :) Untar should definitely not be a
literal (and should not have been quoted in the first place).

> Maybe something like this on top?  ('rsync' is in italics because it
> is just a command name rather than a full command ready to be typed on
> the command line.)

No opinion on that from me.

>  Using ``git commit -a''
> -~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~

I think this length doesn't have to match the text above, but I agree it
looks better to viewers of the source if it does.

-Peff
