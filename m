From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Thu, 17 Dec 2015 22:55:01 -0500
Message-ID: <20151218035501.GA9273@sigill.intra.peff.net>
References: <20151216032639.GA1901@LykOS>
 <CAGZ79kZNim0wp2fYKv2+6t+CaqqzjTThsm_KoAv1D_8OsD0qTQ@mail.gmail.com>
 <20151218010635.GA16508@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:55:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9m90-0007Tg-2c
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 04:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbbLRDzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 22:55:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:44108 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205AbbLRDzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 22:55:04 -0500
Received: (qmail 14140 invoked by uid 102); 18 Dec 2015 03:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 21:55:04 -0600
Received: (qmail 20971 invoked by uid 107); 18 Dec 2015 03:55:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 22:55:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 22:55:01 -0500
Content-Disposition: inline
In-Reply-To: <20151218010635.GA16508@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282697>

On Thu, Dec 17, 2015 at 08:06:36PM -0500, Santiago Torres wrote:

> > This is what push certificates ought to solve.
> > The server records all pushes and its signed certificates of pushes
> > and by the difference of the
> > refs (either in packed refs or as a loose ref) to the push certificate
> > this tampering of
> > the server can be detected.
> 
> Is there any specification about push certificates? I would like to read
> about them, but I don't seem to find documentation anywhere. Are they a
> part of git's specification?

Try pack-protocol.txt and protocol-capabilities.txt in the
Documentation/technical directory of the git.git repo.

E.g.:

  https://github.com/git/git/blob/bdfc6b364a51b19efbacbd46fcef5be41a5db50e/Documentation/technical/pack-protocol.txt#L489

-Peff
