From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 13:20:22 -0400
Message-ID: <20120917172022.GA1179@sigill.intra.peff.net>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDf1I-0002qv-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab2IQRUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:20:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46636 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552Ab2IQRU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:20:28 -0400
Received: (qmail 9035 invoked by uid 107); 17 Sep 2012 17:20:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 13:20:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 13:20:22 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205716>

On Mon, Sep 17, 2012 at 10:31:07PM +0530, Ramkumar Ramachandra wrote:

> I tried running `make valgind` inside t/ and got:
> 
>     bug in test framework: multiple prerequisite tags do not work reliably
> 
> which means that even the basic tests don't pass.  Am I doing something wrong?

No, that should work (and it does work here). I assume you can pass
t0000 without --valgrind?

It seems very odd that valgrind would have an impact here, since those
tests are not even running git.

-Peff
