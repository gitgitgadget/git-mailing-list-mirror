From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 10:21:57 -0400
Message-ID: <20090921142157.GA20860@sigio.peff.net>
References: <871vm0k6jm.fsf@meyering.net> <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com> <87ocp4imul.fsf@meyering.net> <20090921134427.GA20567@sigio.peff.net> <87tyywgzhu.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 16:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpjjv-0002Kj-GJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 16:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZIUOTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 10:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbZIUOT3
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 10:19:29 -0400
Received: from [208.65.91.99] ([208.65.91.99]:47002 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZIUOT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 10:19:29 -0400
Received: (qmail 20871 invoked by uid 1000); 21 Sep 2009 14:21:57 -0000
Content-Disposition: inline
In-Reply-To: <87tyywgzhu.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128890>

On Mon, Sep 21, 2009 at 04:10:21PM +0200, Jim Meyering wrote:

> >>  	test "$(git diff --cached --name-only --diff-filter=A -z |
> >>  	  LC_ALL=C tr -d '[ -~]\0')"
> >
> > Does this work on non-bracket systems?
> 
> Yes, since [] happen to fall in the range.
> 
> > I would think that enumerating
> > the sequence would be the most portable thing.
> 
> Enumerating is more portable, at the expense of
> readability and maintainability.
> In case you want to go that route, here's one more:

Agreed. If we can avoid enumeration, we should. If your original is
portable, then I think it is preferable. Thanks for looking into it.

-Peff
