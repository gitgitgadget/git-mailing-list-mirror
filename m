From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2012, #05; Mon, 13)
Date: Tue, 14 Feb 2012 16:47:29 -0500
Message-ID: <20120214214729.GA24711@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQDs-0003FO-3S
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab2BNVrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:47:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35936
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932487Ab2BNVrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:47:33 -0500
Received: (qmail 12084 invoked by uid 107); 14 Feb 2012 21:54:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 16:54:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 16:47:29 -0500
Content-Disposition: inline
In-Reply-To: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190765>

On Mon, Feb 13, 2012 at 12:42:48PM -0800, Junio C Hamano wrote:

> * jk/config-include (2012-02-06) 2 commits
>   (merged to 'next' on 2012-02-13 at 307ddf6)
>  + config: add include directive
>  + docs: add a basic description of the config API
> 
> An assignment to the include.path pseudo-variable causes the named file
> to be included in-place when Git looks up configuration variables.

Yikes. I was planning to re-roll this, but got sidetracked discussing
David's git-cola case. Besides a few minor tweaks in the documentation
patch, the actual include patch is buggy, and accidentally turns on
includes for "git config --list".

Do you want to revert and re-do to make master pretty, or should I just
build on top?

-Peff
