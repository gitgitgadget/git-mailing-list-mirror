From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Speeding up "git status" and "git diff --cached"
Date: Mon, 25 May 2009 06:59:17 -0400
Message-ID: <20090525105917.GA27070@coredump.intra.peff.net>
References: <1243106678-6343-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 12:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Xtx-00032A-Iy
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbZEYK7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 06:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbZEYK7T
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:59:19 -0400
Received: from peff.net ([208.65.91.99]:49319 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbZEYK7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:59:19 -0400
Received: (qmail 3939 invoked by uid 107); 25 May 2009 10:59:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 06:59:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 06:59:17 -0400
Content-Disposition: inline
In-Reply-To: <1243106678-6343-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119920>

On Sat, May 23, 2009 at 12:24:33PM -0700, Junio C Hamano wrote:

> Here is a refined version of an earlier patch series to use cache-tree
> information to optimize comparison between the index with an existing
> commit.

I just read through the series, and it looks sane to me. My only concern
would be that we are forgetting some option that needs to disable the
optimization (in the same way that find-copies-harder) does, but I
couldn't think of one. And that is, after all, what cooking it in next
is for. :)

But I am not terribly familiar with the cache-trees corner of the code,
so take my endorsement with a grain of salt.

There is a minor typo in the subject of 2/5.

-Peff
