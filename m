From: Scott Moser <smoser@brickies.net>
Subject: Re: [PATCH] fix guilt-pop and push to fail if no relevant patches
Date: Fri, 17 Oct 2008 10:40:43 -0400 (EDT)
Message-ID: <alpine.DEB.1.00.0810171036410.27798@brickies>
References: <1222714293-9680-1-git-send-email-smoser@brickies.net> <alpine.DEB.1.00.0810170736240.27798@brickies> <20081017142832.GF27647@josefsipek.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 16:42:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqqWe-0001Ib-9f
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 16:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbYJQOkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 10:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbYJQOkq
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 10:40:46 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:43598 "EHLO
	spunkymail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753251AbYJQOkq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 10:40:46 -0400
Received: from brickies.mosers.us (d14-69-66-169.try.wideopenwest.com [69.14.169.66])
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id E82A7E24FE;
	Fri, 17 Oct 2008 07:40:44 -0700 (PDT)
X-X-Sender: smoser@brickies
In-Reply-To: <20081017142832.GF27647@josefsipek.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98478>

On Fri, 17 Oct 2008, Josef 'Jeff' Sipek wrote:

> On Fri, Oct 17, 2008 at 07:37:33AM -0400, Scott Moser wrote:
> > Jeff,
> >    Did you not like the patch below for some reason ?
>
> I don't remember my train of thought, but I ended up making a simpler patch
> to address the push-pushing-more-than-it-should bug. I completely missed the
> part about the exit codes.
>

good enough. I hadn't pulled in a while and didn't realize you'd made a
change.  I never actually saw a problem with "pushing too much" , but
only in the exit codes.

> > > diff --git a/guilt-push b/guilt-push
> > > index 018f9ac..48f886b 100755
> > > --- a/guilt-push
> > > +++ b/guilt-push
> [snipped long diff]
>
> With my fix, this should be a 2-liner :)

for what its worth, the patch i sent only added a couple lines.  It
really just changed indentation.  So, the patch was long, only 2 new
lines that did anything.

anyway... I'm happy if you make it exit failure.

Thanks,
