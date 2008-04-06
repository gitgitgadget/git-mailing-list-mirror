From: Jeff King <peff@peff.net>
Subject: Re: [bug] git-clone over ssh fails when repository has local
	commits
Date: Sun, 6 Apr 2008 12:56:55 -0400
Message-ID: <20080406165655.GA26060@coredump.intra.peff.net>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com> <20080406161120.GB24358@coredump.intra.peff.net> <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: seventh guardian <seventhguardian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 18:57:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiYBZ-0007OA-A7
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 18:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYDFQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754321AbYDFQ45
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 12:56:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1667 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbYDFQ45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 12:56:57 -0400
Received: (qmail 29660 invoked by uid 111); 6 Apr 2008 16:56:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Apr 2008 12:56:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 12:56:55 -0400
Content-Disposition: inline
In-Reply-To: <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78899>

On Sun, Apr 06, 2008 at 05:22:39PM +0100, seventh guardian wrote:

> I can, but it is a local commit. It seems like local commits aren't
> being "cloned over" to the slaves.. As I said, this only happens for
> "local masters" where I have local commits. If my master is untouched,
> then I can successfuly clone the repo.

You are going to have to clarify what you mean by "local commit" and
"local master". Those aren't terms that are commonly used, so I don't
understand what you are talking about. Can you describe which git
commands you used to create this situation?

-Peff
