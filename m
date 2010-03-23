From: Jeff King <peff@peff.net>
Subject: Re: git rev-list formatting
Date: Tue, 23 Mar 2010 08:26:03 -0400
Message-ID: <20100323122603.GA2053@coredump.intra.peff.net>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
 <4BA7A75A.6060909@lsrfire.ath.cx>
 <m31vfbpzol.fsf@winooski.ccs.neu.edu>
 <4BA89D88.7080803@drmicha.warpmail.net>
 <m3ocifnvpd.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 13:27:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu3C2-0006Gb-E6
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 13:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab0CWM0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 08:26:07 -0400
Received: from peff.net ([208.65.91.99]:44467 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123Ab0CWM0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 08:26:06 -0400
Received: (qmail 19293 invoked by uid 107); 23 Mar 2010 12:26:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 23 Mar 2010 08:26:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Mar 2010 08:26:03 -0400
Content-Disposition: inline
In-Reply-To: <m3ocifnvpd.fsf@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143011>

On Tue, Mar 23, 2010 at 07:06:38AM -0400, Eli Barzilay wrote:

> > [...]
> 
> I've made a copy of the repository at
> 
>   http://tmp.barzilay.org/testing.git.tgz
> 
> which shows what I said when I run
> 
>   git rev-list --pretty="%b" 267d60518
>   git rev-list --pretty="%b" 84482

The problem is that most of those commits don't _have_ bodies. Remember
that "%b" is about everything in the commit message after the first
first paragraph.

Now one might argue that rev-list should still put in the extra newline
separator in this case. I haven't been paying attention, but hasn't that
been discussed in another thread recently?

-Peff
