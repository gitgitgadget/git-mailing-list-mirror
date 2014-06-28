From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 0/4] verify-commit: verify commit signatures
Date: Fri, 27 Jun 2014 20:49:47 -0400
Message-ID: <20140628004946.GD13228@sigill.intra.peff.net>
References: <xmqqoaxjb9rr.fsf@gitster.dls.corp.google.com>
 <cover.1403877430.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0gq0-0001p9-Ik
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbaF1Att (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:49:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:52391 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751496AbaF1Ats (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:49:48 -0400
Received: (qmail 24237 invoked by uid 102); 28 Jun 2014 00:49:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jun 2014 19:49:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jun 2014 20:49:47 -0400
Content-Disposition: inline
In-Reply-To: <cover.1403877430.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252594>

On Fri, Jun 27, 2014 at 04:13:22PM +0200, Michael J Gruber wrote:

> This is v3 rebased on current next (the %G works by Jeff & Junio).

Aside from the minor test issues Junio pointed out, I think this version
looks OK.

> For a general command which allows different verification policies,
> I'm still wondering whether we may need hooks which receive all
> the relevant information in the environment. Otherwise we'll have a ton of
> options such as --match-committer-uid, --verify--AllParentsHaveMergeTags,
> --verify--All-ParentsAreSignedCommits, --peel-to-commit, --merge-commit-only, ...

I'd guess these would be project policies that could go in config. But I
do not think your series needs to be concerned with that yet.

-Peff
