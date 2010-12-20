From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] completion: add missing configuration variables
Date: Mon, 20 Dec 2010 16:20:18 -0500
Message-ID: <20101220212018.GA18503@sigill.intra.peff.net>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1292858305-7679-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 22:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUn9d-0004z9-Dt
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 22:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933239Ab0LTVUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 16:20:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53737 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933189Ab0LTVUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 16:20:20 -0500
Received: (qmail 32002 invoked by uid 111); 20 Dec 2010 21:20:19 -0000
Received: from 129-79-255-41.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 20 Dec 2010 21:20:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Dec 2010 16:20:18 -0500
Content-Disposition: inline
In-Reply-To: <1292858305-7679-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164012>

On Mon, Dec 20, 2010 at 04:18:25PM +0100, Martin von Zweigbergk wrote:

> Quite a few configuration variables have been added since 226b343
> (completion: add missing configuration variables to _git_config(),
> 2009-05-03). Add these variables to the Bash completion script.
> 
> Also remove the obsolete 'add.ignore-errors' and
> 'color.grep.external', as well as 'diff.renameLimit.', which never
> existed and rename the misspelled 'sendemail.aliasesfiletype'.
> 
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
> Changes since previous version:
> 
> Removed 'add.ignore-errors' and 'color.grep.external'.
> 
> Added 'fetch.recurseSubmodules', which has entered master since last
> round.
> 
> (Still based on master.)

Based on our prior discussion, I think this can go in, and all of the
other issues can be left for future patches if somebody wants to address
them.

Acked-by: Jeff King <peff@peff.net>

-Peff
