From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files (resubmit
Date: Fri, 22 Feb 2013 13:37:03 -0500
Message-ID: <20130222183703.GC18934@sigill.intra.peff.net>
References: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:37:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8xUx-0006wH-GI
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 19:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab3BVShG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 13:37:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57298 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758225Ab3BVShF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 13:37:05 -0500
Received: (qmail 7091 invoked by uid 107); 22 Feb 2013 18:38:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 13:38:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 13:37:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216852>

On Fri, Feb 22, 2013 at 09:30:57AM -0800, Joshua Clayton wrote:

> Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files
>   (resubmit with reviewed-by)

One thing I forgot to note in my other response: the subject is part of
the commit message, so information like "resubmit with..." should go
with other cover letter material after the "---".

It's also customary to say something like "PATCHv2" in the brackets
(which does get stripped off), and mention what is changed since v1
after the "---". That can help reviewers remember what happened, and it
can help the maintainer understand where in the process of review the
patch is.

-Peff
