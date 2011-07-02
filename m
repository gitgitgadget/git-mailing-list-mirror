From: Jeff King <peff@peff.net>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 06:44:37 -0400
Message-ID: <20110702104437.GA10538@sigill.intra.peff.net>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
 <20110702104313.GA10245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Al Haraka <alharaka@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 12:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcxp4-0006it-PK
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 12:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab1GBKok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jul 2011 06:44:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59512
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBKok (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 06:44:40 -0400
Received: (qmail 15972 invoked by uid 107); 2 Jul 2011 10:44:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jul 2011 06:44:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jul 2011 06:44:37 -0400
Content-Disposition: inline
In-Reply-To: <20110702104313.GA10245@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176554>

On Sat, Jul 02, 2011 at 06:43:13AM -0400, Jeff King wrote:

> The default gitweb configuration doesn't allow textconv (or external
> diff) for security reasons; it would mean repo owners could execute
> arbitrary commands as the gitweb user.
> 
> If that's OK for your site, you can probably enable it with:
> 
>   push @diff_opts, '--allow-textconv';

Oops, this option is just called "--textconv". I got it confused with
the flag in the code, which is ALLOW_TEXTCONV.

-Peff
