From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] docs: clarify git-branch --list behavior
Date: Fri, 1 Feb 2013 00:06:37 -0500
Message-ID: <20130201050637.GC29973@sigill.intra.peff.net>
References: <20130131064357.GA24660@sigill.intra.peff.net>
 <20130131064545.GA25315@sigill.intra.peff.net>
 <CAPig+cT21Fx6BaD=1jT7KSBZSZkWu-A-0U+QsM2qO8g5gki=YQ@mail.gmail.com>
 <7v4nhweuoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Peter Wu <lekensteyn@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 06:07:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U18q7-00060y-KA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 06:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab3BAFGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 00:06:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55163 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3BAFGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 00:06:41 -0500
Received: (qmail 17746 invoked by uid 107); 1 Feb 2013 05:08:04 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 00:08:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 00:06:37 -0500
Content-Disposition: inline
In-Reply-To: <7v4nhweuoi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215204>

On Thu, Jan 31, 2013 at 04:37:01PM -0800, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Thu, Jan 31, 2013 at 1:45 AM, Jeff King <peff@peff.net> wrote:
> >> +If `--list` is given, or if there are no non-option arguments, existing
> >> +branches are listed; the current branch will be highlighted with an
> >> +asterisk.  Option `-r` causes the remote-tracking branches to be listed,
> >> +and option `-a` shows both local and remote branches. If a `<pattern>`
> >> +is given, it is used as a shell wildcard to restrict the output to
> >> +matching branches. If multiple patterns are given, a branch is shown if
> >> +any it is matched by any of the patterns.
> >
> > s/if any it is/if it is/
> 
> Thanks; I'll squash this in.  Peff, no need to resend.

Thanks. No matter how many times I proofread a doc change, I always
manage to slip an error into the final version. Hooray for many eyes.

-Peff
