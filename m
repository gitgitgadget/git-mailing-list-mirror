From: Jeff King <peff@peff.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 16:11:42 -0500
Message-ID: <20091214211142.GC9364@coredump.intra.peff.net>
References: <1260822484.9379.53.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:11:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKICw-0005tw-DC
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbZLNVLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbZLNVLs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:11:48 -0500
Received: from peff.net ([208.65.91.99]:36618 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932640AbZLNVLs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:11:48 -0500
Received: (qmail 14744 invoked by uid 107); 14 Dec 2009 21:16:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Dec 2009 16:16:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2009 16:11:42 -0500
Content-Disposition: inline
In-Reply-To: <1260822484.9379.53.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135238>

On Mon, Dec 14, 2009 at 03:28:04PM -0500, Eric Paris wrote:

> So I have no idea what is interesting or relevant what I can collect,
> what you want to know or anything like that, so this is a bit of a dump
> of info and I'm sorry to whoever tries to pick anything useful out of

It sounds like you might have found an infinite loop, as reflog should
never really need a lot of CPU. Is it possible to tar the whole
repository and make it available publicly for us to look at?

-Peff
