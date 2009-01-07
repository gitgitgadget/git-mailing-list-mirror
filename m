From: Jeff King <peff@peff.net>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Wed, 7 Jan 2009 00:59:47 -0500
Message-ID: <20090107055947.GA22616@coredump.intra.peff.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com> <20090106072253.GA9920@coredump.intra.peff.net> <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com> <20090106080300.GA10079@coredump.intra.peff.net> <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net> <488807870901060705m49419ec1he14aace5caaa3d89@mail.gmail.com> <slrngm6uf5.vuo.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 07:01:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKRTd-0004tu-J4
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbZAGF7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 00:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbZAGF7u
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 00:59:50 -0500
Received: from peff.net ([208.65.91.99]:37861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbZAGF7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 00:59:49 -0500
Received: (qmail 9236 invoked by uid 107); 7 Jan 2009 06:00:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Jan 2009 01:00:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jan 2009 00:59:47 -0500
Content-Disposition: inline
In-Reply-To: <slrngm6uf5.vuo.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 06, 2009 at 03:33:57PM +0000, Sitaram Chamarty wrote:

> > We also plan to do it in this way, just a small wondering that it
> > looks a kind of workaround instead of a more graceful solution.
> 
> I wouldn't consider it a workaround.  It uses normal Unix
> permissions the way they were designed to, including setgid
> for directories.

Yes, I think core.sharedrepository is the "official" way to do this, so
it is definitely not a workaround.

> Actually, I am yet to come up with a situation where I
> actually needed ACLs, though they are more generalised, and
> fine-grained.

I like ACLs mainly because you don't have to bug root to change
permissions (like you do to get them to create or modify a group).

-Peff
