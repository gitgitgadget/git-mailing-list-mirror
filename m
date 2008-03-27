From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add--interactive: ignore mode change in 'p'atch
	command
Date: Thu, 27 Mar 2008 18:16:17 -0400
Message-ID: <20080327221616.GA28179@coredump.intra.peff.net>
References: <cover.1206602393.git.peff@peff.net> <20080327073043.GB22444@coredump.intra.peff.net> <7v7ifob0et.fsf@gitster.siamese.dyndns.org> <20080327171022.GA27189@coredump.intra.peff.net> <7vprtg9g0p.fsf@gitster.siamese.dyndns.org> <m3fxucuesq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:17:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0P9-0005NW-MQ
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918AbYC0WQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758569AbYC0WQU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:16:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4520 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758767AbYC0WQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 18:16:20 -0400
Received: (qmail 7138 invoked by uid 111); 27 Mar 2008 22:16:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 18:16:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 18:16:17 -0400
Content-Disposition: inline
In-Reply-To: <m3fxucuesq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78368>

On Thu, Mar 27, 2008 at 12:51:04PM -0700, Jakub Narebski wrote:

> Well, one hypothetical situation where having mode-change as 0th
> pseudo-hunk in git-add--interactive would be useful is the situation
> where you have changed file mode by accident, and do not want it
> staged (included in the commit), at all.

FWIW, the diff "header" that "git add -p" gives you now does mention the
mode change. But it's very easy to miss, since you are presumably
looking for the hunk text. Asking is much nicer, IMHO.

-Peff
