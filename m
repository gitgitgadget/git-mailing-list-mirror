From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Tue, 19 Feb 2008 18:52:50 -0500
Message-ID: <20080219235250.GA12979@coredump.intra.peff.net>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com> <alpine.LSU.1.00.0802192220440.7826@racer.site> <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com> <20080219234422.GA9987@coredump.intra.peff.net> <20080219234945.GB9987@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRcHA-0005Vh-C8
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbYBSXwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbYBSXwx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:52:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4886 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053AbYBSXwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 18:52:53 -0500
Received: (qmail 26393 invoked by uid 111); 19 Feb 2008 23:52:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Feb 2008 18:52:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 18:52:50 -0500
Content-Disposition: inline
In-Reply-To: <20080219234945.GB9987@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74479>

On Tue, Feb 19, 2008 at 06:49:45PM -0500, Jeff King wrote:

> Otherwise, test t1300:58 fails when trying to match the text. It's
> just a typo in my previous patch.

Bah, and there are even more errors at the end of the test (though I am
not sure if they are related to the fix, or were there already). I don't
have time to look at this anymore right now, but I will try to run the
full test suite on Solaris later tonight.

-Peff
