From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Sun, 13 Mar 2011 01:47:10 -0500
Message-ID: <20110313064710.GA13135@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
 <20110313030214.GB10452@sigill.intra.peff.net>
 <7vsjuril5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 07:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyf5A-0007kr-Hw
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 07:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1CMGrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 01:47:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41630
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab1CMGrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 01:47:11 -0500
Received: (qmail 31106 invoked by uid 107); 13 Mar 2011 06:47:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Mar 2011 01:47:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Mar 2011 01:47:10 -0500
Content-Disposition: inline
In-Reply-To: <7vsjuril5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168961>

On Sat, Mar 12, 2011 at 10:34:08PM -0800, Junio C Hamano wrote:

> I see you rebased your jk/doc-credits topic at GitHub but haven't queued
> this one yet, so I won't be pulling, but give me a holler when the branch
> is ready to be pulled into 'master'.  I'll then push the result out after
> running final "make doc" check on a few platforms I have and eyeballing
> the output.

It's pushed now. I rebase my topics aggressively on top of master (which
you saw), but I don't always push out regularly. Since my main output is
patches to the list, in general I assume nobody is actually looking at
my topics directly. :) Let me know if some other strategy would be
better[1].

I've done a perfunctory check over the changes, but there are a lot of
them, so another set of eyeballs on the output is appreciated.

-Peff

[1] I have mixed feelings about the aggressive rebasing. Our 'master' is
pretty stable, so I don't feel the need to build off the last tagged
release. But rebasing a lot does make it hard for others to follow the
topic, and it makes it hard to organize my work with you queue in pu,
and then merge to 'next' and 'master'. However, I haven't found a
satisfactory solution to tracking patches as they move through the
workflow of local development, sent to list, and applied upstream.

Git-cherry sort of does this, but patch-ids miss a lot of cases: patches
tweaked in transit, patches applied on a different commit, or even
patches taken partially or split up. So I rebase frequently, and as
patches get picked up in master, the branches dwindle to empty.
Suggestions welcome if anybody else has figured out something clever.

-Peff
