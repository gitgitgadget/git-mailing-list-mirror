From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] remote-hg: add missing config for basic tests
Date: Mon, 12 Nov 2012 15:32:07 -0500
Message-ID: <20121112203207.GF4623@sigill.intra.peff.net>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
 <1352742068-15346-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0gE-0004ms-1O
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab2KLUcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:32:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44981 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab2KLUcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:32:12 -0500
Received: (qmail 13599 invoked by uid 107); 12 Nov 2012 20:32:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 15:32:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 15:32:07 -0500
Content-Disposition: inline
In-Reply-To: <1352742068-15346-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209520>

On Mon, Nov 12, 2012 at 06:41:05PM +0100, Felipe Contreras wrote:

> From: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> 'hg commit' fails otherwise in some versiosn of mercurial because of

s/versiosn/versions/

> +setup () {
> +	(
> +	echo "[ui]"
> +	echo "username = A U Thor <author@example.com>"
> +	) >> "$HOME"/.hgrc
> +}

This makes sense, but I wonder if we should use something different from
the git author ident set up by the test scripts, just to double check
that we do not have any bugs in confusing the two during the import.

Something like "H G Wells <wells@example.com>" would work, and satisfies
my deep-seated desire for bad puns.

-Peff
