From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 05:06:34 -0500
Message-ID: <20110216100622.GA12971@sigill.intra.peff.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
 <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
 <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpeHY-00019d-RS
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884Ab1BPKGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:06:42 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57736 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758746Ab1BPKGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:06:40 -0500
Received: (qmail 8547 invoked by uid 111); 16 Feb 2011 10:06:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 10:06:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Feb 2011 05:06:34 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166943>

On Wed, Feb 16, 2011 at 09:58:52AM +0000, Sverre Rabbelier wrote:

> On Wed, Feb 16, 2011 at 09:54, Jeff King <peff@peff.net> wrote:
> > So? Your question was whether index state is precious. If it's precious,
> > shouldn't we be keeping a history of it?
> 
> I don't think it's quite _that_ precious, but the only operation that
> I regularly use that can blow away my carefully constructed index as
> side effect of doing something else is `git commit -a`.

OK, so how precious is it? :)

If you want to have an option that specifically prevents the "git commit
-a" muscle memory thing, then go for it. I'm guessing it is the most
common "oops" one. Even with an index reflog, you might want it on top.

But it just seems silly to me to not protect at the same time against
the other ways you can lose state from the index.

-Peff
