From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix quote_path when called with negative length.
Date: Mon, 3 Dec 2007 12:18:39 -0500
Message-ID: <20071203171839.GA19144@coredump.intra.peff.net>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org> <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com> <20071203090652.GA25154@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:19:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzEwg-0000e8-GP
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXLCRSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbXLCRSn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:18:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4841 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXLCRSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:18:42 -0500
Received: (qmail 30829 invoked by uid 111); 3 Dec 2007 17:18:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Dec 2007 12:18:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2007 12:18:39 -0500
Content-Disposition: inline
In-Reply-To: <20071203090652.GA25154@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66928>

On Mon, Dec 03, 2007 at 10:06:52AM +0100, Pierre Habouzit wrote:

>     Speaking of which, there is this irritating bug in git status that
>     let it show too long paths in the first chunk (the "tracked files"
>     one).

It was annoying me, too. See the thread 'quote_path: fix collapsing of
relative paths'.

-Peff
