From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Fri, 22 Aug 2008 17:19:02 -0400
Message-ID: <20080822211902.GA31884@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Alex Riesen <fork0@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:20:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWe3I-0000TA-Ri
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbYHVVTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYHVVTG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:19:06 -0400
Received: from peff.net ([208.65.91.99]:1283 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839AbYHVVTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:19:05 -0400
Received: (qmail 25255 invoked by uid 111); 22 Aug 2008 21:19:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 17:19:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 17:19:02 -0400
Content-Disposition: inline
In-Reply-To: <7vzln492pc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93372>

On Fri, Aug 22, 2008 at 02:09:35PM -0700, Junio C Hamano wrote:

> I often use "git who Jeff" alias to fill the recipient of my e-mails with
> this alias:
> 
>     [alias]
>         who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" --author=\"$1\"' -"

Very clever, I like it. And it also solves the problem I sometimes _do_
have, which is pulling aliases into my mua from git.

-Peff
