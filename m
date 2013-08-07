From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] l10n: de.po: translate 5 messages
Date: Wed, 7 Aug 2013 05:22:20 -0400
Message-ID: <20130807092220.GA4563@sigill.intra.peff.net>
References: <1375813794-4578-1-git-send-email-ralf.thielow@gmail.com>
 <87r4e5vp0r.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 07 11:22:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6zwr-0000MS-OK
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 11:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364Ab3HGJW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 05:22:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:55074 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757360Ab3HGJWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 05:22:25 -0400
Received: (qmail 14216 invoked by uid 102); 7 Aug 2013 09:22:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Aug 2013 04:22:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Aug 2013 05:22:20 -0400
Content-Disposition: inline
In-Reply-To: <87r4e5vp0r.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231814>

On Wed, Aug 07, 2013 at 11:17:08AM +0200, Thomas Rast wrote:

> This results from Peff's c17592a (commit: tweak empty cherry pick advice
> for sequencer, 2013-07-26):
> 
>   diff --git a/builtin/commit.c b/builtin/commit.c
>   index a17a5df..39717d5 100644
>   --- a/builtin/commit.c
>   +++ b/builtin/commit.c
>   @@ -62,8 +62,18 @@
>    "If you wish to commit it anyway, use:\n"
>    "\n"
>    "    git commit --allow-empty\n"
>   +"\n");
>   +
>   +static const char empty_cherry_pick_advice_single[] =
>   +N_("Otherwise, please use 'git reset'\n");
>   +
>   +static const char empty_cherry_pick_advice_multi[] =
>   +N_("If you wish to skip this commit, use:\n"
>    "\n"
>   -"Otherwise, please use 'git reset'\n");
>   +"    git reset\n"
>   +"\n"
>   +"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
>   +"the remaining commits.\n");
>    
>    static const char *use_message_buffer;
>    static const char commit_editmsg[] = "COMMIT_EDITMSG";
>
> [...]
>
> So it seems that concatenating sentences indeed falls into a gray area
> between "avoid sentence lego" and "split at paragraphs".  And Peff's
> style of splitting it saves the translators work because the first part
> of the message is shared among two code paths.

Yeah, I was mainly trying to avoid repeating myself, since the first
part of the message would be the same (and I did not want them to fall
out of sync).

However, I do not mind changing it if translators would prefer to see
the whole message as a single string. I agree it's a gray area.

-Peff
