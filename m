From: Jeff King <peff@peff.net>
Subject: Re: origin/branchname and tracking branch pointing to different
 commits?
Date: Tue, 8 Jun 2010 14:30:07 -0400
Message-ID: <20100608183007.GA31293@coredump.intra.peff.net>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
 <201001071813.01187.trast@student.ethz.ch>
 <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
 <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
 <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
 <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 20:30:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM3Z5-0007Pp-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 20:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0FHSaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 14:30:12 -0400
Received: from peff.net ([208.65.91.99]:57588 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab0FHSaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 14:30:11 -0400
Received: (qmail 10313 invoked by uid 107); 8 Jun 2010 18:30:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Jun 2010 14:30:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jun 2010 14:30:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148700>

On Tue, Jun 08, 2010 at 12:27:14PM -0400, Eugene Sajine wrote:

> I'm coming back to this topic as i see some confusion growing about
> such behavior. Every now and then users come across this problem and
> they expect pull to *really* behave as fetch and merge so it will
> cause the update of remote/branchname branch. And it is kind of
> difficult to justify why they have to do git fetch after pull...
> 
> Can somebody, please, take a look?

This was discussed a while back:

  http://thread.gmane.org/gmane.comp.version-control.git/127163

and I even posted a patch, but never followed up (I think mostly just
due to being busy).. There is some concern about unexpected ref updates,
though.

-Peff
