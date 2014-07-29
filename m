From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Tue, 29 Jul 2014 03:54:54 -0400
Message-ID: <20140729075454.GA4114@peff.net>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
 <20140728103504.GB10737@peff.net>
 <xmqqtx614cea.fsf@gitster.dls.corp.google.com>
 <20140728173734.GA10309@peff.net>
 <20140728180157.GA11265@peff.net>
 <xmqqppgp4a7x.fsf@gitster.dls.corp.google.com>
 <xmqqegx53txe.fsf@gitster.dls.corp.google.com>
 <CAGyf7-HK74YuqhrRDJ46qti17UNAd6Bp6if4y+ZwUV_PZs2ujQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 09:55:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC2FQ-0006EO-JB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 09:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaG2Hy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 03:54:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:42293 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751038AbaG2Hy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 03:54:56 -0400
Received: (qmail 1433 invoked by uid 102); 29 Jul 2014 07:54:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 02:54:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 03:54:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-HK74YuqhrRDJ46qti17UNAd6Bp6if4y+ZwUV_PZs2ujQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254401>

On Tue, Jul 29, 2014 at 11:06:25AM +1000, Bryan Turner wrote:

> On Tue, Jul 29, 2014 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> > OK, I pushed out updated 'maint' and 'master'.  The former merges
> > a rebased version of jk/alloc-commit-id in to make the "reorganize
> > the way we manage the in-core commit data" topic, and the latter
> > reverts the "Use SSE to micro-optimize a leaf function to check the
> > format of a ref string".
> >
> > Please give them some quick sanity check.

They both look OK to me.

> Thanks both of you; I appreciate your efforts! I've run my suite of
> tests against the tips of master and maint and all 681 pass for each.
> Looks good to me.

So what suite of tests is this? Is it worth getting you to fold it into
our regular test suite? :)

-Peff
