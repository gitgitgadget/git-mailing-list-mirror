From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 23:51:32 -0500
Message-ID: <20090130045131.GB18655@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl> <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com> <20090129115026.GB10792@coredump.intra.peff.net> <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 05:53:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSlND-0005me-A0
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 05:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbZA3Evf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 23:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755097AbZA3Eve
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 23:51:34 -0500
Received: from peff.net ([208.65.91.99]:50078 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610AbZA3Eve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 23:51:34 -0500
Received: (qmail 26992 invoked by uid 107); 30 Jan 2009 04:51:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 23:51:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 23:51:32 -0500
Content-Disposition: inline
In-Reply-To: <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107770>

On Thu, Jan 29, 2009 at 01:20:20PM +0100, Sverre Rabbelier wrote:

> > It wouldn't help the case of "somebody
> > else pushed some content that you want to pull", but like you said, I
> > think the primary workflow is that you immediately push after cloning
> > the empty repo.
> 
> Also, the only way to support the "somebody else pushed already"
> workflow would be to assume the user wants to name the branch
> 'master', which might not be the case at all.

You could make a guess that they will use "master", and if you are
wrong, it behaves as now. But if you are right, "git pull" pulls down
master automatically.

But that is getting a little confusing. So let's push this "git push
--track" idea to completion and see how people like it.

-Peff
