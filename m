From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 21:27:11 -0400
Message-ID: <20080624012711.GA3816@sigio.intra.peff.net>
References: <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org> <20080623210935.GC13395@artemis.madism.org> <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org> <7v3an3hke8.fsf@gitster.siamese.dyndns.org> <20080623222404.GM13395@artemis.madism.org> <7vmylbg4ks.fsf@gitster.siamese.dyndns.org> <20080623233146.GP13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 03:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAxJk-00052V-Gg
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 03:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYFXB0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 21:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYFXB0g
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 21:26:36 -0400
Received: from peff.net ([208.65.91.99]:2128 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbYFXB0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 21:26:36 -0400
Received: (qmail 31561 invoked by uid 111); 24 Jun 2008 01:26:34 -0000
Received: from sigio.intra.peff.net (HELO sigio.intra.peff.net) (10.0.0.10)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 23 Jun 2008 21:26:34 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 21:27:11 -0400
Content-Disposition: inline
In-Reply-To: <20080623233146.GP13395@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85961>

On Tue, Jun 24, 2008 at 01:31:46AM +0200, Pierre Habouzit wrote:

>   Are we sure argv[argc] is NULL when those are main() arguments ? If
> yes there is no issue, and I should read posix more carefully, but I was
> under the impression that POSIX wasn't enforcing that.

It's not POSIX; it's actually in the C standard. 5.1.2.2.1, paragraph 2:

  "argv[argc] shall be a null pointer"

-Peff
