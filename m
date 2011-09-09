From: Jeff King <peff@peff.net>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our
 Documentation/
Date: Fri, 9 Sep 2011 15:05:47 -0400
Message-ID: <20110909190547.GF28480@sigill.intra.peff.net>
References: <4E6A23DB.1040606@drmicha.warpmail.net>
 <7v4o0lvcq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 21:05:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R26Oh-0007kS-CN
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 21:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759683Ab1IITFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 15:05:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45362
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759652Ab1IITFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 15:05:49 -0400
Received: (qmail 824 invoked by uid 107); 9 Sep 2011 19:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 15:06:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 15:05:47 -0400
Content-Disposition: inline
In-Reply-To: <7v4o0lvcq3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181107>

On Fri, Sep 09, 2011 at 10:37:24AM -0700, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Our own customisation is not loaded (of course) so that, e.g., the
> > linkgit macro does not work; and the include statement makes GitHub's
> > parser unhappy and choke.
> >
> > Does anybody feel this is worth pursuing?
> >
> > + Nicer blob view
> > + Simpler way to judge documentation changes
> > - Need to get our asciidoc config in there
> > - GitHub's parser neeeds to learn include
> 
> Personally I am not very interested. Couldn't you just visit the html
> branch instead for viewing?

I agree that it's not very nice for release-quality documentation. But
if I understand correctly, Michael means that you can go straight to any
blob at any commit of any fork on github, and get the rendered (or raw)
version. Which is neat.

How frequently do you build the html branch? I always assumed it was
once in a while (every push?), not for every commit.

We could help that along by giving our documentation a more descriptive
filename. But it would be cool if GitHub respected gitattributes for
this, too.

-Peff
