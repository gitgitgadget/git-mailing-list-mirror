From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8] Add Travis CI support
Date: Tue, 1 Dec 2015 19:45:24 -0500
Message-ID: <20151202004524.GB28197@sigill.intra.peff.net>
References: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
 <20151128171223.GD27264@sigill.intra.peff.net>
 <A529A168-CC08-4F8F-B46D-3DF5EAA8EBB9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:45:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vY3-0007Qg-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 01:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222AbbLBAp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 19:45:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:36032 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756629AbbLBAp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 19:45:27 -0500
Received: (qmail 26332 invoked by uid 102); 2 Dec 2015 00:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:45:27 -0600
Received: (qmail 24767 invoked by uid 107); 2 Dec 2015 00:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 19:45:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 19:45:24 -0500
Content-Disposition: inline
In-Reply-To: <A529A168-CC08-4F8F-B46D-3DF5EAA8EBB9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281868>

On Tue, Dec 01, 2015 at 09:43:45AM +0100, Lars Schneider wrote:

> > Thanks. I don't have any other comments on this one. I guess the next
> > step is for me to get git/git signed up for Travis, and then merging
> > this to 'master' will have the desired effect.
> 
> Thanks! You're right, signing up git/git for Travis should do it.
> Right now it is configured to build all branches on git/git that
> contain a travis.yml. That means if you merge it to pu or next then we
> should see builds already.

I merged to 'pu', and signed up peff/git, and got a build. Incidentally,
something in pu causes a bunch of tests to fail on OS X (but not Linux).
:)

-Peff
