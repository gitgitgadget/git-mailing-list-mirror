From: Jeff King <peff@peff.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
	a remote branch?
Date: Tue, 7 Apr 2009 00:41:14 -0400
Message-ID: <20090407044113.GA26556@coredump.intra.peff.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com> <20090406043426.GC12341@coredump.intra.peff.net> <4d8e3fd30904060130l985b0a5x331d215ca6106fd4@mail.gmail.com> <20090406212516.GA882@coredump.intra.peff.net> <4d8e3fd30904061500m7857f0f1i2b76a2113f30c562@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 06:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr398-0007PM-NU
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 06:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZDGElT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 00:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbZDGElT
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 00:41:19 -0400
Received: from peff.net ([208.65.91.99]:58400 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbZDGElS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 00:41:18 -0400
Received: (qmail 31266 invoked by uid 107); 7 Apr 2009 04:41:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 00:41:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 00:41:14 -0400
Content-Disposition: inline
In-Reply-To: <4d8e3fd30904061500m7857f0f1i2b76a2113f30c562@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115905>

On Tue, Apr 07, 2009 at 12:00:20AM +0200, Paolo Ciarrocchi wrote:

> > So the questions are:
> >
> >   - is this worth it? The verbose information is already available via
> >     git status, but only for the current branch.
> 
> I think it's a very usefull information.
> I feel like it would be nice to have this information being part of
> the basic git branch output and not associated to the -vv option.

I'm not sure we should disrupt the simplicity of the current "git
branch" output. I would be curious to hear what others think.

-Peff
