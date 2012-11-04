From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add rm to submodule command.
Date: Sun, 4 Nov 2012 08:43:24 -0500
Message-ID: <20121104134324.GA31623@sigill.intra.peff.net>
References: <1351877171-3176-1-git-send-email-lindenle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Alex Linden Levy <lindenle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 14:43:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV0UG-00059p-WE
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 14:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab2KDNn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 08:43:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56597 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2KDNn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 08:43:27 -0500
Received: (qmail 23782 invoked by uid 107); 4 Nov 2012 13:44:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Nov 2012 08:44:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2012 08:43:24 -0500
Content-Disposition: inline
In-Reply-To: <1351877171-3176-1-git-send-email-lindenle@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209027>

On Fri, Nov 02, 2012 at 10:26:11AM -0700, Alex Linden Levy wrote:

> This change removes the config entries in .gitmodules and adds it.
> ---

Signoff?

>  git-submodule.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)

No documentation or tests?

> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..29d950f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh

I'd defer to submodule experts on whether the steps to 'rm' the
submodule make sense. Jens?

-Peff
