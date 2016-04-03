From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] builtin/verify-tag.c: Ignore SIGPIPE on
 gpg-interface
Date: Sun, 3 Apr 2016 00:30:41 -0400
Message-ID: <20160403043041.GA1519@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-2-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Sun Apr 03 06:30:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amZga-0004iJ-Ju
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 06:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbcDCEan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 00:30:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:43224 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750950AbcDCEan (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 00:30:43 -0400
Received: (qmail 29248 invoked by uid 102); 3 Apr 2016 04:30:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:30:42 -0400
Received: (qmail 8984 invoked by uid 107); 3 Apr 2016 04:30:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 03 Apr 2016 00:30:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Apr 2016 00:30:41 -0400
Content-Disposition: inline
In-Reply-To: <1459638975-17705-2-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290625>

On Sat, Apr 02, 2016 at 07:16:12PM -0400, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> The verify_signed_buffer comand might cause a SIGPIPE signal when the
> gpg child process terminates early (due to a bad keyid, for example) and
> git tries to write to it afterwards. Previously, ignoring SIGPIPE was
> done on the builtin/gpg-verify.c command to avoid this issue. However,

s/gpg-verify/verify-tag/ here, I think.

Other than that, nicely explained.

-Peff
