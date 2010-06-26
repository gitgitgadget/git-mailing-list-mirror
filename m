From: Jeff King <peff@peff.net>
Subject: Re: Confusion about content of conflicted file after : git
 remove/add
Date: Sat, 26 Jun 2010 01:58:12 -0400
Message-ID: <20100626055812.GA10290@coredump.intra.peff.net>
References: <AANLkTimqrfeNEmlfHGxWTdLgS7tAMOA66N4nV8b5I8F6@mail.gmail.com>
 <20100624061029.GA11020@coredump.intra.peff.net>
 <AANLkTilo0b9aL3oxk0b8eNkBWygwA7xSclTy1MaK8qba@mail.gmail.com>
 <AANLkTinQu19HKUC2a_JkSyeZ_SynE11eNwgH9zEMiY8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sabyasachi Ruj <ruj.sabya@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 07:58:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSOPG-0001jI-Vp
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 07:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab0FZF6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 01:58:19 -0400
Received: from peff.net ([208.65.91.99]:53761 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab0FZF6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 01:58:18 -0400
Received: (qmail 8513 invoked by uid 107); 26 Jun 2010 05:59:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 26 Jun 2010 01:59:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jun 2010 01:58:12 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinQu19HKUC2a_JkSyeZ_SynE11eNwgH9zEMiY8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149726>

On Fri, Jun 25, 2010 at 11:06:46AM +0530, Sabyasachi Ruj wrote:

> >> So I think there may be a bug. I don't really see any code in
> >> merge-recursive.c to handle conflicts on _both_ sides of a rename, but
> >> obviously that is possible here.
> 
> Then I guess having contents of both the files would be an expected
> behavior. Should I report a bug somewhere?

I would certainly expect it (at least in the index). Posting here is
fine to report, but you may want to repost with a more descriptive
subject line and a summary of the issue. That will get the attention of
people interested in merge issues.

-Peff
