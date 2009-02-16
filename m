From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 08:58:12 -0500
Message-ID: <20090216135812.GA20377@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm> <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 15:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ40v-0004Y1-9y
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757691AbZBPN6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 08:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757297AbZBPN6P
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 08:58:15 -0500
Received: from peff.net ([208.65.91.99]:33314 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368AbZBPN6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 08:58:14 -0500
Received: (qmail 16293 invoked by uid 107); 16 Feb 2009 13:58:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 08:58:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 08:58:12 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090216T101457-231@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110182>

On Mon, Feb 16, 2009 at 10:17:01AM +0000, Sergio Callegari wrote:

> > For people who do not follow the git list regularly, a "HEAD contain the
> > actual commit" is often called "detached".
> 
> Could you have that done automatically?
> Namely rather to denying push to a branch b where HEAD->b, when you get such
> push you detach head?

See

  http://article.gmane.org/gmane.comp.version-control.git/108923

for discussion.

-Peff
