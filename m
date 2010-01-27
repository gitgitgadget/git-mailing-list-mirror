From: Jeff King <peff@peff.net>
Subject: Re: git commit --cleanup and templates
Date: Wed, 27 Jan 2010 06:48:20 -0500
Message-ID: <20100127114820.GA12656@coredump.intra.peff.net>
References: <hj7bh9$adp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 12:48:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Nq-0007I4-W2
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab0A0Ls0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170Ab0A0Ls0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:48:26 -0500
Received: from peff.net ([208.65.91.99]:33770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0A0LsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 06:48:24 -0500
Received: (qmail 6085 invoked by uid 107); 27 Jan 2010 11:48:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 27 Jan 2010 06:48:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jan 2010 06:48:20 -0500
Content-Disposition: inline
In-Reply-To: <hj7bh9$adp$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138130>

On Wed, Jan 20, 2010 at 05:37:47PM +0100, Sebastian Schuberth wrote:

> when I recently for the first time used commit templates, I was
> surprised to see that git by default strips leading empty lines that
> I deliberately added to the template file when opening the template
> in the editor. I understand that I could use a different cleanup
> mode, but in fact I *want* git to clean everything, but only *after*
> I finished editing the commit message, not already when opening the
> editor.
> 
> Before submitting a patch, I'd like to hear what other people think
> about this, or whether I'm overseeing something.

Nobody has responded, so I doubt anybody has strong objections (or maybe
they just didn't read your message. :) ).

Personally, the behavior you are proposing makes more sense to me, and I
don't think you will really be hurting anybody by changing it. You will
not affect the final commit message, but only what the user sees in
their editor. And if people are really attached to not having extra
whitespace in the editor, then they can simply clean up their templates.

So I would suggest working on a patch if it is something you want.

-Peff
