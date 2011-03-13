From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Sat, 12 Mar 2011 22:02:14 -0500
Message-ID: <20110313030214.GB10452@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 04:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PybZY-0004iu-Gi
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 04:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab1CMDCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 22:02:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40895
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216Ab1CMDCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 22:02:16 -0500
Received: (qmail 29409 invoked by uid 107); 13 Mar 2011 03:02:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Mar 2011 22:02:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Mar 2011 22:02:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168957>

On Sat, Mar 12, 2011 at 11:52:23AM +0200, Alexei Sholik wrote:

> On 11 March 2011 00:37, Jeff King <peff@peff.net> wrote:
> > -The documentation for git suite was started by David Greaves
> > -<david@dgreaves.com>, and later enhanced greatly by the
> > -contributors on the git-list <git@vger.kernel.org>.
> > +Git was started by Linus Torvalds, and is currently maintained by Junio
> > +C Hamano. Numerous contributions have come from the git mailing list
> > +<git@vger.kernel.org>. For a complete list of contributors, see
> > +linkgit:git-shortlog[1] and linkgit:git-blame[1].
> 
> The last sentence could be a little bit more informative for casual
> git-users, something like
>   For a complete list of contributors, see http://git-scm.com/about,
> or (if you are a true geek) linkgit:git-shortlog[1] and
> linkgit:git-blame[1].

Yeah, I was tempted to put in explicit instructions but opted to keep it
simple. I forgot about the credits listing at git-scm.com, though. Maybe
this on top of my other patches?

-- >8 --
Subject: [PATCH] docs: point git.txt author credits to git-scm.com

There is a nice shortlog-ish output of the authors there. We
also point people directly to shortlog, but of course they
might be reading the documentation online or from a binary
package of git.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4323843..5e57f69 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -747,8 +747,10 @@ Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
 C Hamano. Numerous contributions have come from the git mailing list
-<git@vger.kernel.org>. For a complete list of contributors, see
-linkgit:git-shortlog[1] and linkgit:git-blame[1].
+<git@vger.kernel.org>. For a more complete list of contributors, see
+http://git-scm.com/about. If you have a clone of git.git itself, the
+output of linkgit:git-shortlog[1] and linkgit:git-blame[1] can show you
+the authors for specific parts of the project.
 
 Reporting Bugs
 --------------
-- 
1.7.2.5.18.g3ffb9
