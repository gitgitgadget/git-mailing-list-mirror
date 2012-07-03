From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Tue, 3 Jul 2012 15:35:52 -0400
Message-ID: <20120703193552.GB20503@sigill.intra.peff.net>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
 <20120703180439.GC3294@sigill.intra.peff.net>
 <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
 <20120703184018.GB5765@sigill.intra.peff.net>
 <CAKON4OwJAdAMG2_LD6Eh8d=zx+5Hwn_aqRKW-MF5e8k=esCUkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm8tI-0002Nx-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487Ab2GCTf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:35:57 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52504
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188Ab2GCTfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:35:55 -0400
Received: (qmail 25078 invoked by uid 107); 3 Jul 2012 19:36:02 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 15:36:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 15:35:52 -0400
Content-Disposition: inline
In-Reply-To: <CAKON4OwJAdAMG2_LD6Eh8d=zx+5Hwn_aqRKW-MF5e8k=esCUkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200936>

On Tue, Jul 03, 2012 at 02:43:01PM -0400, jonsmirl@gmail.com wrote:

> > It's already in git-push(1):
> >
> >   OPTIONS
> >      ...
> >      <refspec>
> >        ...
> >        Pushing an empty <src> allows you to delete the <dst> ref from
> 
> I was searching for "git delete remote branch". Can out add the word
> 'branch' in so that Google will find it?

I didn't quite parse what you were saying here.

-Peff
