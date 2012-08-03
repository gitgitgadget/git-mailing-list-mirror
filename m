From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 3 Aug 2012 18:02:37 -0400
Message-ID: <20120803220237.GA14003@sigill.intra.peff.net>
References: <20120803160229.GA13094@sigill.intra.peff.net>
 <1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120803200201.GA10344@sigill.intra.peff.net>
 <7v3943bsuc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 00:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxPxG-0004Kb-71
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 00:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab2HCWCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 18:02:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50992 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab2HCWCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 18:02:39 -0400
Received: (qmail 28997 invoked by uid 107); 3 Aug 2012 22:02:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 18:02:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 18:02:37 -0400
Content-Disposition: inline
In-Reply-To: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202865>

On Fri, Aug 03, 2012 at 01:53:15PM -0700, Junio C Hamano wrote:

> Wouldn't it be cleaner and readable to write it like this
> 
> 	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$1" "$2"
> 
> by the way?

Yeah, that would be more robust (it's longer to type, which is why I
avoided it in the inline replacement, but since we're factoring it out,
that's not an issue).

-Peff
