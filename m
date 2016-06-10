From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] diff: disable compaction heuristic for now
Date: Fri, 10 Jun 2016 17:05:17 -0400
Message-ID: <20160610210516.GC22470@sigill.intra.peff.net>
References: <20160610075043.GA13411@sigill.intra.peff.net>
 <20160610083102.GA14192@sigill.intra.peff.net>
 <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
 <CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
 <xmqqeg84gbex.fsf_-_@gitster.mtv.corp.google.com>
 <20160610203026.GA21464@sigill.intra.peff.net>
 <xmqqoa78epmt.fsf_-_@gitster.mtv.corp.google.com>
 <xmqqk2hwepcq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 23:05:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBTcL-0007ye-SZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 23:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbcFJVFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 17:05:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:53015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752016AbcFJVFU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 17:05:20 -0400
Received: (qmail 30736 invoked by uid 102); 10 Jun 2016 21:05:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 17:05:19 -0400
Received: (qmail 9062 invoked by uid 107); 10 Jun 2016 21:05:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jun 2016 17:05:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jun 2016 17:05:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2hwepcq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297075>

On Fri, Jun 10, 2016 at 01:55:01PM -0700, Junio C Hamano wrote:

> This is for 'master' when the topic is merged (will keep it in stash
> for now).
> 
>  Documentation/RelNotes/2.9.0.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RelNotes/2.9.0.txt b/Documentation/RelNotes/2.9.0.txt
> index 927cb9b..79b46e1 100644
> --- a/Documentation/RelNotes/2.9.0.txt
> +++ b/Documentation/RelNotes/2.9.0.txt
> @@ -118,9 +118,11 @@ UI, Workflows & Features
>   * HTTP transport clients learned to throw extra HTTP headers at the
>     server, specified via http.extraHeader configuration variable.
>  
> - * Patch output from "git diff" and friends has been tweaked to be
> -   more readable by using a blank line as a strong hint that the
> -   contents before and after it belong to logically separate units.
> + * The "--compaction-heuristic" option to "git diff" family of
> +   commands enables a heuristic to make the patch output more readable
> +   by using a blank line as a strong hint that the contents before and
> +   after it belong to logically separate units.  It is still
> +   experimental.
>  
>   * A new configuration variable core.hooksPath allows customizing
>     where the hook directory is.

Looks good.

I think your calendar calls for release 2.9.0 on Monday. Are you going
to bump the schedule for this? I don't think it's very high risk, and
wouldn't need to.

-Peff
