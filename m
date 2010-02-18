From: Jeff King <peff@peff.net>
Subject: Re: How to create patches for a merge?
Date: Thu, 18 Feb 2010 15:37:38 -0500
Message-ID: <20100218203738.GB8110@coredump.intra.peff.net>
References: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Geoffrey Lee <geoffreyj.lee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiD84-0004y5-UB
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab0BRUhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 15:37:39 -0500
Received: from peff.net ([208.65.91.99]:43972 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735Ab0BRUhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:37:39 -0500
Received: (qmail 5363 invoked by uid 107); 18 Feb 2010 20:37:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 18 Feb 2010 15:37:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Feb 2010 15:37:38 -0500
Content-Disposition: inline
In-Reply-To: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140377>

On Thu, Feb 18, 2010 at 03:40:07AM -0800, Geoffrey Lee wrote:

> When I use=C2=A0"git format-patch", it doesn't seem to include merges=
=2E How
> can I perform a merge and then e-mail it to someone as a set of
> patches?

Is it important that it be patches, or simply that it go over email? In
the latter case, you can use "git bundle" to create a set of commits,
including merges, and send them to the remote.

-Peff
