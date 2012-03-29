From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc3
Date: Thu, 29 Mar 2012 05:52:36 -0400
Message-ID: <20120329095236.GA11911@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 11:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDC2F-0001qe-9m
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 11:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758930Ab2C2Jwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 05:52:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39146
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab2C2Jwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 05:52:40 -0400
Received: (qmail 29985 invoked by uid 107); 29 Mar 2012 09:52:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 05:52:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 05:52:36 -0400
Content-Disposition: inline
In-Reply-To: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194244>

On Wed, Mar 28, 2012 at 12:47:12PM -0700, Junio C Hamano wrote:

>  * When you do not tell which branches and tags to push to the "git push"
>    command in any way, the command used "matching refs" rule to update
>    remote branches and tags with branches and tags with the same name you
>    locally have.  In future versions of Git, this will change to use the
>    "upstream" rule to update the branch at the remote you would "pull"
>    from into your current branch with your local current branch.  The
>    release after 1.7.10 will start issuing a warning about this change,
>    to encourage you to tell the command what to push out, e.g. by setting
>    push.default configuration.

Did we decide that "upstream" will be the new rule in future versions? I
still have some misgivings about that (versus "current"), but I thought
the only decision we were settling now was whether to change at all.

-Peff
