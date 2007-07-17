From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Update a bare repository
Date: Tue, 17 Jul 2007 09:26:35 +0200
Message-ID: <20070717072635.GG5823@cip.informatik.uni-erlangen.de>
References: <20070717063026.GA5823@cip.informatik.uni-erlangen.de> <20070717070428.GA13266@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 17 09:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAhTA-0001sk-HQ
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 09:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762553AbXGQH0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 03:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762084AbXGQH0h
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 03:26:37 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:65359 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760090AbXGQH0g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 03:26:36 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 9C48D3F435; Tue, 17 Jul 2007 09:26:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070717070428.GA13266@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52743>

Hello,

> The "+" in both cases means that it copies whatever Junio has, even if
> it might lose some commits of yours. But that seems to be what you
> want in this case.

thanks a lot. That is exactly what I was looking for.

> The simplest thing is not to give write access to the repo for your
> pushers. However, you could also put in a pre-receive hook that rejects
> all pushes.

Is there an example somewhere?

	Thomas
