From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git clone --checkout <branch>
Date: Tue, 16 Feb 2010 06:07:24 -0500
Message-ID: <20100216110724.GA25173@coredump.intra.peff.net>
References: <be6fef0d1002160248h7410d4edu6e3ed1fd27c40059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 12:07:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhLHC-0005dM-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 12:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab0BPLH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 06:07:29 -0500
Received: from peff.net ([208.65.91.99]:60026 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380Ab0BPLH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 06:07:28 -0500
Received: (qmail 32207 invoked by uid 107); 16 Feb 2010 11:07:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 06:07:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 06:07:24 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1002160248h7410d4edu6e3ed1fd27c40059@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140096>

On Tue, Feb 16, 2010 at 06:48:42PM +0800, Tay Ray Chuan wrote:

> what do you guys think about allowing users to specify the branch to
> checkout when cloning, instead of the default HEAD of the to-be-cloned
> repository?

I think it's a great idea, but that we should call it "--branch" and
that I should travel back in time to implement it last September as
7a4ee28.

-Peff
