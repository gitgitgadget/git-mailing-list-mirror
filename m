From: Jeff King <peff@peff.net>
Subject: Re: progit build instructions and ExtUtils::MakeMaker
Date: Wed, 18 Jun 2014 04:01:56 -0400
Message-ID: <20140618080156.GA11027@sigill.intra.peff.net>
References: <CA+kozekeTOBZFauhU2EY18hTzhpZ-VUnbBH91CtErnD4UGSNsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "C. Benson Manica" <cbmanica@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 10:02:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxAol-0001Ca-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 10:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbaFRIB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 04:01:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:46603 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754208AbaFRIB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 04:01:58 -0400
Received: (qmail 26421 invoked by uid 102); 18 Jun 2014 08:01:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 03:01:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 04:01:56 -0400
Content-Disposition: inline
In-Reply-To: <CA+kozekeTOBZFauhU2EY18hTzhpZ-VUnbBH91CtErnD4UGSNsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251974>

[I added a subject to the thread; that is likely part of why you didn't
 get any responses sooner]

On Sun, Jun 01, 2014 at 02:24:54PM -0700, C. Benson Manica wrote:

> The documentation for installing git from source here,
> http://git-scm.com/book/en/Getting-Started-Installing-Git, incorrectly
> fails to mention that the MakeMaker perl module is also required and
> is installable via
> 
> $ yum install perl-ExtUtils-MakeMaker

The content at git-scm.com/book is pulled from the Creative Commons "Pro
Git" book. Errata and corrections are generally handled by opening an
issue there:

  https://github.com/progit/progit/issues

Note that ExtUtils::MakeMaker is part of the perl core (and has been for
quite a long time). So on many systems, I would not expect it to need to
be installed separately. If you propose a change for Pro Git, you may
want to find out which systems package it separately and which do not
(Debian, for example, does not, but it also does not use yum).

> Also, you might want to let people know that you've configured your
> mail system for 1987 mode and do not accept HTML-formatted mail.

Come on, MIME wasn't standardized until 1996. We're easily state of the
art for the mid-1990's. :)

-Peff
