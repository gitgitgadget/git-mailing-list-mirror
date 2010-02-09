From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Some improvements for git-imap-send
Date: Tue, 9 Feb 2010 10:06:50 -0500
Message-ID: <20100209150650.GA15982@sigill.intra.peff.net>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
 <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, jwhite@codeweavers.com,
	robertshearman@gmail.com
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Tue Feb 09 16:07:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nerg6-0001WF-Rl
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 16:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0BIPGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 10:06:53 -0500
Received: from peff.net ([208.65.91.99]:46780 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab0BIPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 10:06:52 -0500
Received: (qmail 21467 invoked by uid 107); 9 Feb 2010 15:06:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Feb 2010 10:06:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 10:06:50 -0500
Content-Disposition: inline
In-Reply-To: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139408>

On Tue, Feb 09, 2010 at 09:09:01PM +0900, Hitoshi Mitake wrote:

>  base64.c                        |  122 ++++++++
>  base64.h                        |   36 +++
>  md5.c                           |  600 +++++++++++++++++++++++++++++++++++++++
>  md5.h                           |   61 ++++
>  md5_hmac.c                      |  137 +++++++++
>  md5_hmac.h                      |   36 +++

That's a lot of extra code. Doesn't imap-send already conditionally
compile against openssl for starttls support? Can't we just get all
three of these algorithms from openssl?

-Peff
