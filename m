From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
	the work tree
Date: Mon, 3 Dec 2007 20:43:27 -0500
Message-ID: <20071204014326.GA21358@coredump.intra.peff.net>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071203024916.GA11003@coredump.intra.peff.net> <200712030755.37038.robin.rosenberg@dewire.com> <200712032153.31322.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMpB-00042Y-30
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbXLDBn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXLDBn3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:43:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1962 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbXLDBn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:43:29 -0500
Received: (qmail 1559 invoked by uid 111); 4 Dec 2007 01:43:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 20:43:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 20:43:27 -0500
Content-Disposition: inline
In-Reply-To: <200712032153.31322.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66987>

On Mon, Dec 03, 2007 at 09:53:30PM +0100, Robin Rosenberg wrote:

> code did not pass). Like Linus, this code does not resolve symlinks,
> but I forgot to state that it is by design. It solves my problem and

By design meaning "I didn't feel like implemening it because I do not
personally care" or "I have some reason not to resolve symlinks"?

-Peff
