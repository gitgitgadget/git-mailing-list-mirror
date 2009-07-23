From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()
Date: Thu, 23 Jul 2009 01:07:11 -0400
Message-ID: <20090723050711.GB9189@coredump.intra.peff.net>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <1248298475-2990-2-git-send-email-madcoder@debian.org>
 <1248298475-2990-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqWX-0003fh-E6
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbZGWFHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZGWFHM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:07:12 -0400
Received: from peff.net ([208.65.91.99]:52049 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbZGWFHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:07:11 -0400
Received: (qmail 8537 invoked by uid 107); 23 Jul 2009 05:09:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Jul 2009 01:09:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2009 01:07:11 -0400
Content-Disposition: inline
In-Reply-To: <1248298475-2990-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123835>

On Wed, Jul 22, 2009 at 11:34:34PM +0200, Pierre Habouzit wrote:

>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
> +#define bitsizeof(x)  (CHAR_BIT * sizeof(x))

Isn't our style to use all-caps for macros? I.e., BITSIZEOF?

-Peff
