From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Tue, 3 Jul 2012 14:40:19 -0400
Message-ID: <20120703184018.GB5765@sigill.intra.peff.net>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
 <20120703180439.GC3294@sigill.intra.peff.net>
 <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm81S-0007PZ-Qq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab2GCSkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:40:22 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52461
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957Ab2GCSkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:40:22 -0400
Received: (qmail 24437 invoked by uid 107); 3 Jul 2012 18:40:29 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 14:40:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 14:40:19 -0400
Content-Disposition: inline
In-Reply-To: <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200930>

On Tue, Jul 03, 2012 at 02:34:59PM -0400, jonsmirl@gmail.com wrote:

> > and now:
> >
> >   $ git push origin :bogus
> >   error: unable to delete 'bogus': remote ref does not exist
> >   error: failed to push some refs to '$URL'
> 
> This error return would have made my mistake obvious.

Thanks for confirming.

> Might want to add a paragraph to the doc saying this is how you delete
> remote branches since it is not an obvious solution. I found it via
> Google and a question asked on stackoverflow.com

It's already in git-push(1):

  OPTIONS
     ...
     <refspec>
       ...
       Pushing an empty <src> allows you to delete the <dst> ref from
       the remote repository.

but if you have rewording suggestions, or a suggestion as to where else
to mention it, please do.

-Peff
