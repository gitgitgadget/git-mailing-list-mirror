From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase: do not print lots of usage hints after an
 obvious error message
Date: Tue, 28 Jun 2011 11:54:34 -0400
Message-ID: <20110628155434.GA3747@sigill.intra.peff.net>
References: <4E09CD16.2040800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 28 18:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbb4S-00080I-PU
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 18:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab1F1Pz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 11:55:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46489
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758524Ab1F1Pyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 11:54:39 -0400
Received: (qmail 8972 invoked by uid 107); 28 Jun 2011 15:54:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Jun 2011 11:54:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2011 11:54:34 -0400
Content-Disposition: inline
In-Reply-To: <4E09CD16.2040800@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176405>

On Tue, Jun 28, 2011 at 02:46:14PM +0200, Johannes Sixt wrote:

> The error message was introduced recently by 4ac5356c (rebase: give a
> better error message for bogus branch, 2011-01-27), and the result was
> acceptable because the usage text was just two lines. But 45e2acf3
> (rebase: define options in OPTIONS_SPEC, 2011-02-28) made things worse
> because the usage text is now 35 lines.
> 
> Just drop the usage information because it does not add value to the
> error message.

Acked-by: Jeff King <peff@peff.net>

A git-sh-setup function to print just the summary bit of the usage would
restore the original behavior, but I agree it's not really adding
anything.

-Peff
