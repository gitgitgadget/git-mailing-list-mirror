From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 21:59:38 -0400
Message-ID: <20071031015938.GB24403@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org> <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com> <20071031014347.GB23274@coredump.intra.peff.net> <46a038f90710301849h1c31736an1ec163aa1e274577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In2s7-0003e2-W0
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbXJaB7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbXJaB7l
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:59:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbXJaB7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 21:59:41 -0400
Received: (qmail 6656 invoked by uid 111); 31 Oct 2007 01:59:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 21:59:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 21:59:38 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90710301849h1c31736an1ec163aa1e274577@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62778>

On Wed, Oct 31, 2007 at 02:49:49PM +1300, Martin Langhoff wrote:

> > Actually, IIRC it won't fetch any of the non 'blue' refs.
> You recall correctly, and that was a cogito misfeature. I don't think
> git should follow that part of the spec ;-)

I'm not so sure. Junio keeps unrelated branches in git.git like 'html'
and 'todo'. Is it unreasonable to say "clone git.git, but only the todo
branch" and expect it _not_ to download the entire git history?

-Peff
