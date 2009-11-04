From: Jeff King <peff@peff.net>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Wed, 4 Nov 2009 02:37:31 -0500
Message-ID: <20091104073731.GA15408@coredump.intra.peff.net>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
 <20091104063612.GA24263@coredump.intra.peff.net>
 <20091104071053.GB24263@coredump.intra.peff.net>
 <20091104071940.GA15011@coredump.intra.peff.net>
 <4AF12EC5.4030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aR4-0003HP-DR
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbZKDHhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbZKDHhb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:37:31 -0500
Received: from peff.net ([208.65.91.99]:52637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbZKDHha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:37:30 -0500
Received: (qmail 8690 invoked by uid 107); 4 Nov 2009 07:41:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Nov 2009 02:41:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2009 02:37:31 -0500
Content-Disposition: inline
In-Reply-To: <4AF12EC5.4030407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132057>

On Tue, Nov 03, 2009 at 11:35:33PM -0800, Stephen Boyd wrote:

> >@@ -940,6 +941,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > 		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
> > 			    "enable message threading, styles: shallow, deep",
> > 			    PARSE_OPT_OPTARG, thread_callback },
> >+		OPT_BOOLEAN('p', NULL, &use_patch_format,
> >+			"show patch format instead of default (patch + stat)"),
> > 		OPT_END()
> > 	};
> 
> I don't imagine we want this option in the messaging group though.
> Can you move it up?

Thanks, good catch. I just tacked it onto the end, forgetting that we
were using grouping. Junio, can you tweak it, or do you want a resend?

-Peff
