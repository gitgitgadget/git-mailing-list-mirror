From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add -S, --gpg-sign option to manpage of "git commit"
Date: Mon, 29 Oct 2012 03:49:32 -0400
Message-ID: <20121029074932.GG5102@sigill.intra.peff.net>
References: <7vbofvfup7.fsf@alter.siamese.dyndns.org>
 <20121023225101.189E57D4C@ralph.oxix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom Jones <tom@oxix.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSk6V-0005Y4-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab2J2Htg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 03:49:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41899 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab2J2Htf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:49:35 -0400
Received: (qmail 16591 invoked by uid 107); 29 Oct 2012 07:50:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 03:50:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 03:49:32 -0400
Content-Disposition: inline
In-Reply-To: <20121023225101.189E57D4C@ralph.oxix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208602>

On Sun, Oct 21, 2012 at 08:46:37PM +0100, Tom Jones wrote:

> git commit -S, --gpg-sign was mentioned in the program's help message,
> but not in the manpage.
> 
> This adds an equivalent entry for the option in the manpage.
> 
> Signed-off-by: Tom Jones <tom@oxix.org>

Thanks. This slipped through the cracks last week, but I've picked it up
now.

>  DESCRIPTION
>  -----------
> @@ -276,6 +276,10 @@ configuration variable documented in linkgit:git-config[1].
>  	commit message template when using an editor to prepare the
>  	default commit message.
>  
> +-S[<keyid>]::
> +--gpg-sign[=<keyid>]::
> +	GPG-sign commit.
> +

Potentially we could say more (like how to verify), but I will leave
that for somebody to build on top if they want.

-Peff
