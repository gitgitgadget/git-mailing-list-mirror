From: Jeff King <peff@peff.net>
Subject: Re: the pager
Date: Tue, 3 Sep 2013 04:16:52 -0400
Message-ID: <20130903081652.GG3608@sigill.intra.peff.net>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
 <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
 <201308291541.r7TFfuJr023110@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 03 10:17:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlnK-0005ge-DG
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 10:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505Ab3ICIQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 04:16:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:53304 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932457Ab3ICIQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 04:16:55 -0400
Received: (qmail 23595 invoked by uid 102); 3 Sep 2013 08:16:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 03:16:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 04:16:52 -0400
Content-Disposition: inline
In-Reply-To: <201308291541.r7TFfuJr023110@freeze.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233709>

On Thu, Aug 29, 2013 at 11:41:56AM -0400, Dale R. Worley wrote:

> I know I'm griping here, but I thought that part of the reward for
> contributing to an open-source project was as a showcase of one's
> work.  Commenting your code is what you learn first in programming.

You will find that the best comments in the git source code are those
written in the commit messages. Learn to use "git blame" (or I recommend
"tig blame" for interactive use), "git log -S", and the new "git log -L"
for finding the commits that touched an area.

It is also sometimes useful to look at the review and discussion that
accompanied the original patches on the list, if you are looking for
rationale or alternatives that did not make it into the commit message.
You can simply search on gmane, but Thomas Rast also maintains a mapping
of commits back to their original discussions. You can fetch his notes
by doing:

  git config remote.mailnotes.url git://github.com/trast/git.git
  git config remote.mailnotes.fetch refs/heads/notes/*:refs/notes/*
  git fetch mailnotes

You can then use "git notes --ref=gmane show" to show notes for specific
commits, or just "git log --notes=gmane" to view them along with the
regular logs.

-Peff
