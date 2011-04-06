From: Jeff King <peff@github.com>
Subject: Re: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Wed, 6 Apr 2011 17:46:11 -0400
Message-ID: <20110406214610.GC18481@sigill.intra.peff.net>
References: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:46:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7aYO-00015a-Ka
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 23:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234Ab1DFVqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 17:46:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51493
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab1DFVqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 17:46:14 -0400
Received: (qmail 9582 invoked by uid 107); 6 Apr 2011 21:47:00 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 17:47:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 17:46:11 -0400
Content-Disposition: inline
In-Reply-To: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171021>

On Wed, Apr 06, 2011 at 01:04:40PM -0700, Junio C Hamano wrote:

> * jk/maint-merge-rename-create (2011-03-25) 3 commits
>   (merged to 'next' on 2011-03-31 at b9bc9f1)
>  + merge: turn on rewrite detection
>  + merge: handle renames with replacement content
>  + t3030: fix accidental success in symlink rename

I think this was already your plan, but please hold off on merging this
to master. I got an off-list bug report that the top commit breaks a
cherry-pick on somebody's private repo, and I'm trying to track down the
exact reason.

-Peff
