From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
	further processing
Date: Tue, 17 Jun 2008 23:34:23 -0400
Message-ID: <20080618033423.GC19657@sigill.intra.peff.net>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	madcoder@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 05:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8oS9-0004xv-Dq
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbYFRDe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757805AbYFRDe0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:34:26 -0400
Received: from peff.net ([208.65.91.99]:3466 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757790AbYFRDe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:34:26 -0400
Received: (qmail 3104 invoked by uid 111); 18 Jun 2008 03:34:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 17 Jun 2008 23:34:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2008 23:34:23 -0400
Content-Disposition: inline
In-Reply-To: <20080618033010.GA19657@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85360>

On Tue, Jun 17, 2008 at 11:30:10PM -0400, Jeff King wrote:

> Agreed. I was just about to write the same thing. As it happens, I think
> in the case of git-shortlog that there is not likely to be such a
> parameter. The only three I see looking over setup_revisions are "-n"
> (which is masked by shortlog anyway), "--default", and "-U" (which one
> would never need with shortlog).

BTW, looking in my personal repo, I have the start of the exact same
patch (except I called it PARSE_OPT_STOP_AT_UNKNOWN). I think I
abandoned it when I realized the fundamental flaw with the approach, but
I guess I never got it to the point of sharing with the list.

-Peff
