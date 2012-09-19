From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 19:42:26 -0400
Message-ID: <20120919234226.GA27626@sigill.intra.peff.net>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
 <20120919182039.GE11699@sigill.intra.peff.net>
 <7vr4pxg507.fsf@alter.siamese.dyndns.org>
 <7vr4pxegec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:42:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETug-0007Ot-Dy
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab2ISXm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:42:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50207 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab2ISXm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:42:28 -0400
Received: (qmail 8885 invoked by uid 107); 19 Sep 2012 23:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 19:42:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 19:42:26 -0400
Content-Disposition: inline
In-Reply-To: <7vr4pxegec.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206013>

On Wed, Sep 19, 2012 at 04:34:19PM -0700, Junio C Hamano wrote:

> > Yeah, I do not think it is likely.  Among the in-tree scripts,
> > git-stash does use rev-list --oneline but the purpose of the call
> > exactly is to grab a human readable one line summary, and it will be
> > happy with any change to make --oneline more human readble.
> 
> Having said that, one of my often used alias is
> 
>     [alias] recent = log --branches --oneline --no-merges --decorate --since=3.weeks
> 
> to help me see what topics in flight may potentially interact with
> an incoming patch, when deciding on which commit to base the patch
> on.  Pushing the decoration at the end to let it fall off the right
> edge of the screen severely reduces the usefulness of it and defeats
> the point of using --decorate, at least for this use.
> 
> I could use --source instead, though, if it is not moved by the
> patch.

If you are particular about the exact format, how about using
--format="%h%d %s" instead?

Obviously Duy could do the same to achieve his format, but I think there
is still value in considering what the default for --oneline should be.

-Peff
