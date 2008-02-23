From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 17:39:33 -0500
Message-ID: <20080223223933.GA13683@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <7v63wf2yzt.fsf@gitster.siamese.dyndns.org> <200802232209.41428.johannes.sixt@telecom.at> <20080223211536.GA13280@coredump.intra.peff.net> <7vmypr1gmh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT32T-0007sR-BY
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYBWWjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbYBWWjh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:39:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4418 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026AbYBWWjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:39:36 -0500
Received: (qmail 11578 invoked by uid 111); 23 Feb 2008 22:39:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 17:39:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 17:39:33 -0500
Content-Disposition: inline
In-Reply-To: <7vmypr1gmh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74869>

On Sat, Feb 23, 2008 at 01:56:38PM -0800, Junio C Hamano wrote:

> > Well, the trap I wanted to avoid is that "/bin/sh" specifically is
> > broken. But yes, I think losing the ability to run the tests from the
> > commandline is bad.
> 
> We never had it.  "make t3404-rebase-interactive" is the way to
> do so.

Well, that is a surprise to me, since I have been using it for almost
two years with no problems. And I know I am not alone because others
have posted snippets on the list invoking a test via "sh -x", including
both Dscho and you.

Is there a good reason not to do so?

-Peff
